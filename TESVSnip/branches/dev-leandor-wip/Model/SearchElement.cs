﻿namespace TESVSnip.Model
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using System.Text;
    using System.Xml.Serialization;

    using TESVSnip.Collections;

    public enum SearchCondRecordType
    {
        Exists, 

        Missing
    }

    public enum SearchCondElementType
    {
        Equal, 

        Not, 

        Greater, 

        Less, 

        GreaterEqual, 

        LessEqual, 

        StartsWith, 

        EndsWith, 

        Contains, 

        Exists, 

        Missing
    }

    #region XML Serialization

    [XmlRoot("SearchCriteria", Namespace = "", IsNullable = false)]
    public class SearchCriteriaList
    {
        [XmlElement("Search", typeof(SearchCriteriaXmlSettings))]
        public List<SearchCriteriaXmlSettings> Settings = new List<SearchCriteriaXmlSettings>();

        public static SearchCriteriaList Deserialize(Stream stream)
        {
            try
            {
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                return xs.Deserialize(stream) as SearchCriteriaList;
            }
            catch
            {
            }

            return null;
        }

        public static bool Serialize(Stream stream, SearchCriteriaList items)
        {
            try
            {
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                xs.Serialize(stream, items);
                return true;
            }
            catch
            {
            }

            return false;
        }

        public static bool Serialize(Stream stream, IEnumerable<SearchCriteriaXmlSettings> items)
        {
            try
            {
                var list = new SearchCriteriaList { Settings = items.ToList() };
                var xs = new XmlSerializer(typeof(SearchCriteriaList));
                xs.Serialize(stream, list);
                return true;
            }
            catch
            {
            }

            return false;
        }

        internal static SearchCriteriaXmlSettings ToXml(SearchCriteriaSettings setting)
        {
            var criteria = new ArrayList();
            foreach (var child in setting.Items.OfType<SearchSubrecord>().Where(x => x.Checked))
            {
                criteria.Add(new SearchSubrecordXml { SubRecord = child.Record.name, Type = child.Type });
            }

            foreach (var elem in setting.Items.OfType<SearchElement>().Where(x => x.Checked))
            {
                var par = elem.Parent;
                criteria.Add(new SearchElementXml { SubRecord = par.Record.name, Element = elem.Record.name, Type = elem.Type, Value = elem.Value != null ? elem.Value.ToString() : null });
            }

            return new SearchCriteriaXmlSettings { Name = setting.ToString(), Type = setting.Type, Items = criteria.ToArray() };
        }
    }

    [XmlType(AnonymousType = true)]
    public class SearchCriteriaXmlSettings
    {
        [XmlElement("Subrecord", typeof(SearchSubrecordXml))]
        [XmlElement("Element", typeof(SearchElementXml))]
        public object[] Items = new object[0];

        [XmlAttribute]
        public string Name;

        [XmlAttribute]
        public string Type;

        public override string ToString()
        {
            return this.Name;
        }
    }

    [XmlType(AnonymousType = true)]
    public class SearchSubrecordXml
    {
        [XmlAttribute]
        public string SubRecord;

        [XmlAttribute]
        public SearchCondRecordType Type;
    }

    [XmlType(AnonymousType = true)]
    public class SearchElementXml
    {
        [XmlAttribute]
        public string Element;

        [XmlAttribute]
        public string SubRecord;

        [XmlAttribute]
        public SearchCondElementType Type;

        [XmlText]
        public string Value;
    }

    #endregion

    internal class SearchCriteriaSettings
    {
        public IEnumerable<SearchCriteria> Items;

        public string Type;

        public static string GetDisplayString(SearchCondRecordType type)
        {
            switch (type)
            {
                case SearchCondRecordType.Exists:
                    return "Exists";
                case SearchCondRecordType.Missing:
                    return "Missing";
            }

            return string.Empty;
        }

        public static string GetFormatString(SearchCondElementType type)
        {
            switch (type)
            {
                case SearchCondElementType.Equal:
                    return "{0} = {1}";
                case SearchCondElementType.Not:
                    return "Not {0}";
                case SearchCondElementType.Greater:
                    return "{0} > {1}";
                case SearchCondElementType.Less:
                    return "{0} < {1}";
                case SearchCondElementType.GreaterEqual:
                    return "{0} >= {1}";
                case SearchCondElementType.LessEqual:
                    return "{0} <= {1}";
                case SearchCondElementType.StartsWith:
                    return "{0} like '{1}%'";
                case SearchCondElementType.EndsWith:
                    return "{0} like '%{1}'";
                case SearchCondElementType.Contains:
                    return "{0} like '%{1}%'";
                case SearchCondElementType.Exists:
                    return "{0} Exists";
                case SearchCondElementType.Missing:
                    return "{0} Missing";
            }

            return string.Empty;
        }

        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.AppendFormat("({0}) ", this.Type);

            foreach (var kvp in this.Items.GroupBy(
                x => {
                    if (x is SearchSubrecord)
                    {
                        return ((SearchSubrecord)x).Record;
                    }

                    if (x is SearchElement)
                    {
                        return ((SearchElement)x).Parent.Record;
                    }

                    return null;
                }))
            {
                if (kvp.Key == null)
                {
                    continue;
                }

                sb.AppendFormat("[{0}: ", kvp.Key.name);
                bool first = true;
                foreach (var item in kvp.OfType<SearchSubrecord>())
                {
                    if (!first)
                    {
                        sb.Append(",");
                    }

                    sb.Append(item.Type.ToString());
                    first = false;
                }

                foreach (var item in kvp.OfType<SearchElement>())
                {
                    if (!first)
                    {
                        sb.Append(" && ");
                    }

                    sb.AppendFormat(GetFormatString(item.Type), item.Name, item.Value);
                    first = false;
                }

                sb.Append("]");
            }

            return sb.ToString();
        }
    }

    internal abstract class SearchCriteria
    {
        public bool Checked { get; set; }

        public string Name { get; set; }

        public abstract bool Match(Record r);

        public abstract bool Match(Record r, SubRecord sr);

        public abstract bool Match(Record r, SubRecord sr, Element se);
    }

    internal class SearchSubrecord : SearchCriteria
    {
        public ICollection<SearchElement> Children { get; set; }

        public SubrecordStructure Record { get; set; }

        public SearchCondRecordType Type { get; set; }

        public override bool Match(Record r)
        {
            var sr = r.SubRecords.FirstOrDefault(x => x.Name == this.Record.name);
            return this.Match(r, sr);
        }

        public override bool Match(Record r, SubRecord sr)
        {
            return this.Type == SearchCondRecordType.Exists ^ sr == null;
        }

        public override bool Match(Record r, SubRecord sr, Element se)
        {
            return false;
        }
    }

    internal class SearchElement : SearchCriteria
    {
        private ElementStructure record;

        private SearchCondElementType type;

        private object value;

        public SearchSubrecord Parent { get; set; }

        public ElementStructure Record
        {
            get
            {
                return this.record;
            }

            set
            {
                this.record = value;
                if (value != null)
                {
                    Name = value.name;
                }
            }
        }

        public SearchCondElementType Type
        {
            get
            {
                return this.type;
            }

            set
            {
                if (this.type != value)
                {
                    this.type = value;
                    Checked = true;
                }
            }
        }

        public object Value
        {
            get
            {
                return this.value;
            }

            set
            {
                this.value = value;
                Checked = true;
                if (value != null && this.type == SearchCondElementType.Exists)
                {
                    this.type = SearchCondElementType.Equal;
                }
            }
        }

        public override bool Match(Record r)
        {
            bool any = false;
            foreach (bool value in r.SubRecords.Where(x => x.Name == this.Parent.Record.name).Select(x => this.Match(r, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public override bool Match(Record r, SubRecord sr)
        {
            bool any = false;
            foreach (bool value in sr.EnumerateElements().Where(x => x.Structure.name == this.Record.name).Select(x => this.Match(r, sr, x)))
            {
                if (!value)
                {
                    return false;
                }

                any = true;
            }

            return any;
        }

        public override bool Match(Record r, SubRecord sr, Element se)
        {
            if (this.Type == SearchCondElementType.Exists && se != null)
            {
                return true;
            }

            if (this.Type == SearchCondElementType.Missing && se == null)
            {
                return true;
            }

            if (se == null)
            {
                return false;
            }

            var value = sr.GetCompareValue(se);
            int diff = ValueComparer.Compare(value, this.Value);
            switch (this.Type)
            {
                case SearchCondElementType.Equal:
                    return diff == 0;
                case SearchCondElementType.Not:
                    return diff != 0;
                case SearchCondElementType.Greater:
                    return diff > 0;
                case SearchCondElementType.Less:
                    return diff < 0;
                case SearchCondElementType.GreaterEqual:
                    return diff >= 0;
                case SearchCondElementType.LessEqual:
                    return diff <= 0;
                case SearchCondElementType.StartsWith:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().StartsWith(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase);
                    }

                    break;
                case SearchCondElementType.EndsWith:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().EndsWith(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase);
                    }

                    break;
                case SearchCondElementType.Contains:
                    if (diff == 0)
                    {
                        return true;
                    }

                    if (value != null && this.Value != null)
                    {
                        return value.ToString().IndexOf(this.Value.ToString(), StringComparison.CurrentCultureIgnoreCase) >= 0;
                    }

                    break;
            }

            return false;
        }

        public bool ValidateValue(object value)
        {
            if (value == null)
            {
                return true;
            }

            var strvalue = value.ToString();
            var numText = strvalue;

            var numStyle = NumberStyles.Any;
            if (numText.StartsWith("0x"))
            {
                numStyle = NumberStyles.HexNumber;
                numText = strvalue.Substring(2);
            }

            switch (this.Record.type)
            {
                case ElementValueType.String:
                case ElementValueType.BString:
                case ElementValueType.IString:
                case ElementValueType.Str4:
                    return true;
                case ElementValueType.Float:
                    {
                        float v;
                        if (float.TryParse(strvalue, NumberStyles.Any, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Int:
                    {
                        int v;
                        if (int.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Short:
                    {
                        short v;
                        if (short.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Byte:
                    {
                        byte v;
                        if (byte.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.FormID:
                    {
                        uint v;
                        if (uint.TryParse(strvalue, NumberStyles.HexNumber, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.Blob:
                    {
                        return false; // no support yet
                    }

                case ElementValueType.LString:
                    {
                        return true;
                    }

                case ElementValueType.UShort:
                    {
                        ushort v;
                        if (ushort.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.UInt:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
                case ElementValueType.SByte:
                    {
                        uint v;
                        if (uint.TryParse(numText, numStyle, CultureInfo.CurrentCulture, out v))
                        {
                            return true;
                        }
                    }

                    break;
            }

            return false;
        }
    }
}
