namespace TESVSnip.Main
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using System.Xml.Serialization;

    using TESVSnip.Data;

    internal class RecordXmlException : Exception
    {
        public RecordXmlException(string msg)
            : base(msg)
        {
        }
    }

    public enum ElementValueType
    {
        String, 

        Float, 

        Int, 

        Short, 

        Byte, 

        FormID, 

        Blob, 

        LString, 

        BString, 

        UShort, 

        UInt, 

        SByte, 

        Str4, 

        IString
    }

    public enum CondType
    {
        None, 

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

    public struct Conditional
    {
        public readonly ElementValueType type;

        public readonly object value;

        public Conditional(ElementValueType type, object value)
        {
            this.type = type;
            this.value = value;
        }
    }

    internal class SubrecordBase
    {
        public readonly string desc;

        public readonly string name;

        public readonly int optional;

        public readonly int repeat;

        protected SubrecordBase(SubrecordBase src, int optional, int repeat)
        {
            if (src.name.StartsWith("&#x"))
            {
                string[] val = src.name.Split(new[] { ';' }, 2, StringSplitOptions.None);
                var c = (char)int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                this.name = c + val[1];
            }
            else
            {
                this.name = src.name;
            }

            this.desc = src.desc;
            this.optional = optional;
            this.repeat = repeat;
        }

        protected SubrecordBase(Subrecord node)
        {
            if (node.name.StartsWith("&#x"))
            {
                string[] val = node.name.Split(new[] { ';' }, 2, StringSplitOptions.None);
                var c = (char)int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                this.name = c + val[1];
            }
            else
            {
                this.name = node.name;
            }

            this.repeat = node.repeat;
            this.optional = node.optional;
            this.desc = node.desc;
        }

        protected SubrecordBase(Group node)
        {
            if (node.name.StartsWith("&#x"))
            {
                string[] val = node.name.Split(new[] { ';' }, 2, StringSplitOptions.None);
                var c = (char)int.Parse(val[0].Substring(3), NumberStyles.HexNumber, null);
                this.name = c + val[1];
            }
            else
            {
                this.name = node.name;
            }

            this.repeat = node.repeat;
            this.optional = node.optional;
            this.desc = node.desc;
        }

        public virtual bool IsGroup
        {
            get
            {
                return false;
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(this.desc) || this.name == this.desc)
            {
                return this.name;
            }

            return string.Format("{0}: {1}", this.name, this.desc);
        }
    }

    internal class SubrecordGroup : SubrecordBase
    {
        public readonly SubrecordBase[] elements;

        public SubrecordGroup(Group node, SubrecordBase[] items)
            : base(node)
        {
            this.elements = items;
        }

        public override bool IsGroup
        {
            get
            {
                return true;
            }
        }
    }

    internal class SubrecordStructure : SubrecordBase
    {
        public readonly int CondID;

        public readonly string CondOperand;

        public readonly CondType Condition;

        public readonly bool ContainsConditionals;

        public readonly bool UseHexEditor;

        public readonly ElementStructure[] elements;

        public readonly bool notininfo;

        public readonly int size;

        /// <summary>
        /// Initializes a new instance of the <see cref="SubrecordStructure"/> class. 
        /// Clone structure with optional and repeat values overridden.
        /// </summary>
        /// <param name="src">
        /// </param>
        /// <param name="optional">
        /// </param>
        /// <param name="repeat">
        /// </param>
        public SubrecordStructure(SubrecordStructure src, int optional, int repeat)
            : base(src, optional, repeat)
        {
            this.elements = src.elements;
            this.notininfo = src.notininfo;
            this.size = src.size;
            this.Condition = src.Condition;
            this.CondID = src.CondID;
            this.CondOperand = src.CondOperand;
            this.ContainsConditionals = src.ContainsConditionals;
            this.UseHexEditor = src.UseHexEditor;
        }

        public SubrecordStructure(Subrecord node)
            : base(node)
        {
            this.notininfo = node.notininfo;
            this.size = node.size;
            this.Condition = (!string.IsNullOrEmpty(node.condition)) ? (CondType)Enum.Parse(typeof(CondType), node.condition, true) : CondType.None;
            this.CondID = node.condid;
            this.CondOperand = node.condvalue;
            this.UseHexEditor = node.usehexeditor;

            // if (optional && repeat)
            // {
            // throw new RecordXmlException("repeat and optional must both have the same value if they are non zero");
            // }
            var elements = new List<ElementStructure>();
            foreach (var elem in node.Elements)
            {
                elements.Add(new ElementStructure(elem));
            }

            this.elements = elements.ToArray();

            this.ContainsConditionals = this.elements.Count(x => x.CondID != 0) > 0;
        }
    }

    internal class ElementStructure
    {
        public readonly int CondID;

        public readonly string FormIDType;

        public readonly string desc;

        public readonly string[] flags;

        public readonly int group;

        public readonly bool hexview;

        public readonly bool multiline;

        public readonly string name;

        public readonly bool notininfo;

        public readonly bool optional;

        public readonly string[] options;

        public readonly int repeat;

        public readonly ElementValueType type;

        public ElementStructure()
        {
            this.name = "DATA";
            this.desc = "Data";
            this.@group = 0;
            this.hexview = true;
            this.notininfo = true;
            this.optional = false;
            this.options = null;
            this.flags = null;
            this.repeat = 0;
            this.CondID = 0;
            this.FormIDType = null;
            this.multiline = false;
            this.type = ElementValueType.Blob;
        }

        public ElementStructure(SubrecordElement node)
        {
            this.name = node.name;
            this.desc = node.desc;
            this.@group = node.group;
            this.hexview = node.hexview;
            this.notininfo = node.notininfo;
            this.optional = node.optional != 0;
            this.options = node.options == null ? new string[0] : node.options.Split(new[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
            this.flags = node.flags == null ? new string[0] : node.flags.Split(new[] { ';' });
            this.repeat = node.repeat;
            this.CondID = node.condid;
            if (this.optional || this.repeat > 0)
            {
                if (this.@group != 0)
                {
                    throw new RecordXmlException("Elements with a group attribute cant be marked optional or repeat");
                }
            }

            this.FormIDType = null;
            this.multiline = node.multiline;
            this.type = (ElementValueType)Enum.Parse(typeof(ElementValueType), node.type, true);
            switch (this.type)
            {
                case ElementValueType.FormID:
                    this.FormIDType = node.reftype;
                    break;
                case ElementValueType.Blob:
                    if (this.repeat > 0 || this.optional)
                    {
                        throw new RecordXmlException("blob type elements can't be marked with repeat or optional");
                    }

                    break;
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(this.desc) || this.desc == this.name)
            {
                return this.name;
            }

            return string.Format("{0}: {1}", this.name, this.desc);
        }
    }

    internal class RecordStructure
    {
        public static Dictionary<string, RecordStructure> Records = new Dictionary<string, RecordStructure>(StringComparer.InvariantCultureIgnoreCase);

        private static readonly string xmlPath = Path.Combine(Program.settingsDir, @"RecordStructure.xml");

        private static bool loaded;

        public readonly string description;

        public readonly string name;

        public readonly SubrecordBase[] subrecordTree;

        public readonly SubrecordStructure[] subrecords;

        private RecordStructure(RecordsRecord rec, SubrecordBase[] subrecordTree, SubrecordStructure[] subrecords)
        {
            this.name = rec.name;
            this.description = rec.desc;
            this.subrecordTree = subrecordTree;
            this.subrecords = subrecords;
        }

        public static bool Loaded
        {
            get
            {
                return loaded;
            }
        }

        public static void Load()
        {
            if (loaded)
            {
                Records.Clear();
            }
            else
            {
                loaded = true;
            }

            var xs = new XmlSerializer(typeof(Records));
            using (FileStream fs = File.OpenRead(xmlPath))
            {
                var baseRec = xs.Deserialize(fs) as Records;
                var groups = baseRec.Items.OfType<Group>().ToDictionary(x => x.id, StringComparer.InvariantCultureIgnoreCase);
                foreach (var rec in baseRec.Items.OfType<RecordsRecord>())
                {
                    List<SubrecordBase> subrecords = GetSubrecordStructures(rec.Items, groups);
                    var sss = BuildSubrecordStructure(subrecords);
                    Records[rec.name] = new RecordStructure(rec, subrecords.ToArray(), sss.ToArray());
                }
            }
        }

        public override string ToString()
        {
            if (string.IsNullOrEmpty(this.description) && this.description != this.name)
            {
                return this.name;
            }

            return string.Format("{0}: {1}", this.name, this.description);
        }

        /// <summary>
        /// Build the Subrecord array with groups expanded.
        /// </summary>
        /// <param name="list">
        /// The list.
        /// </param>
        /// <returns>
        /// The System.Collections.Generic.List`1[T -&gt; TESVSnip.SubrecordStructure].
        /// </returns>
        private static List<SubrecordStructure> BuildSubrecordStructure(IEnumerable<SubrecordBase> list)
        {
            var subrecords = new List<SubrecordStructure>();
            foreach (var sr in list)
            {
                if (sr is SubrecordStructure)
                {
                    subrecords.Add((SubrecordStructure)sr);
                }
                else if (sr is SubrecordGroup)
                {
                    var sg = sr as SubrecordGroup;
                    List<SubrecordStructure> sss = BuildSubrecordStructure(sg.elements);
                    if (sss.Count > 0)
                    {
                        if (sg.repeat > 0)
                        {
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, sss.Count); // replace
                        }
                        else if (sg.optional > 0)
                        {
                            sss[0] = new SubrecordStructure(sss[0], sss.Count, 0); // optional
                        }
                    }

                    subrecords.AddRange(sss);
                }
            }

            return subrecords;
        }

        private static List<SubrecordBase> GetSubrecordStructures(ICollection items, Dictionary<string, Group> dict)
        {
            var subrecords = new List<SubrecordBase>();
            foreach (var sr in items)
            {
                if (sr is Subrecord)
                {
                    subrecords.Add(new SubrecordStructure((Subrecord)sr));
                }
                else if (sr is Group)
                {
                    var g = sr as Group;
                    var ssr = GetSubrecordStructures((g.Items.Count > 0) ? g.Items : dict[g.id].Items, dict);
                    if (ssr.Count > 0)
                    {
                        // if (!ssr[0].IsGroup && (ssr[0].optional || ssr[0].repeat))
                        // {
                        // throw new RecordXmlException("repeat and optional cannot be specified on first subrecord of a group");
                        // }
                        subrecords.Add(new SubrecordGroup(g, ssr.ToArray()));
                    }
                }
            }

            return subrecords;
        }
    }
}
