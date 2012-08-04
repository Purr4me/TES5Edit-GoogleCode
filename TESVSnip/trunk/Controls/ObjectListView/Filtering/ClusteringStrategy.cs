﻿/*
 * ClusteringStrategy - Implements a simple clustering strategy
 *
 * Author: Phillip Piper
 * Date: 3-March-2011 10:53 pm
 *
 * Change log:
 * 2011-03-03  JPP  - First version
 * 
 * Copyright (C) 2011 Phillip Piper
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * If you wish to use this code in a closed source application, please contact phillip_piper@bigfoot.com.
 */

using System;

namespace BrightIdeasSoftware
{
    /// <summary>
    /// This class provides a useful base implemention of a clustering
    /// strategy where the clusters are grouped around the value of a given column.
    /// </summary>
    public class ClusteringStrategy : IClusteringStrategy
    {
        #region Static properties

        /// <summary>
        /// This field is the text that will be shown to the user when a cluster
        /// key is null. It is exposed so it can be localized.
        /// </summary>
        public static string NULL_LABEL = "[null]";

        /// <summary>
        /// This field is the text that will be shown to the user when a cluster
        /// key is empty (i.e. a string of zero length). It is exposed so it can be localized.
        /// </summary>
        public static string EMPTY_LABEL = "[empty]";

        /// <summary>
        /// Gets or sets the format that will be used by default for clusters that only
        /// contain 1 item. The format string must accept two placeholders:
        /// - {0} is the cluster key converted to a string
        /// - {1} is the number of items in the cluster (always 1 in this case)
        /// </summary>
        public static string DefaultDisplayLabelFormatSingular
        {
            get { return defaultDisplayLabelFormatSingular; }
            set { defaultDisplayLabelFormatSingular = value; }
        }

        private static string defaultDisplayLabelFormatSingular = "{0} ({1} item)";

        /// <summary>
        /// Gets or sets the format that will be used by default for clusters that 
        /// contain 0 or two or more items. The format string must accept two placeholders:
        /// - {0} is the cluster key converted to a string
        /// - {1} is the number of items in the cluster
        /// </summary>
        public static string DefaultDisplayLabelFormatPlural
        {
            get { return defaultDisplayLabelFormatPural; }
            set { defaultDisplayLabelFormatPural = value; }
        }

        private static string defaultDisplayLabelFormatPural = "{0} ({1} items)";

        #endregion

        #region Life and death

        /// <summary>
        /// Create a clustering strategy
        /// </summary>
        public ClusteringStrategy()
        {
            DisplayLabelFormatSingular = DefaultDisplayLabelFormatSingular;
            DisplayLabelFormatPlural = DefaultDisplayLabelFormatPlural;
        }

        #endregion

        #region Public properties

        /// <summary>
        /// Gets or sets the column upon which this strategy is operating
        /// </summary>
        public OLVColumn Column { get; set; }

        /// <summary>
        /// Gets or sets the format that will be used when the cluster
        /// contains only 1 item. The format string must accept two placeholders:
        /// - {0} is the cluster key converted to a string
        /// - {1} is the number of items in the cluster (always 1 in this case)
        /// </summary>
        /// <remarks>If this is not set, the value from 
        /// ClusteringStrategy.DefaultDisplayLabelFormatSingular will be used</remarks>
        public string DisplayLabelFormatSingular { get; set; }

        /// <summary>
        /// Gets or sets the format that will be used when the cluster 
        /// contains 0 or two or more items. The format string must accept two placeholders:
        /// - {0} is the cluster key converted to a string
        /// - {1} is the number of items in the cluster
        /// </summary>
        /// <remarks>If this is not set, the value from 
        /// ClusteringStrategy.DefaultDisplayLabelFormatPlural will be used</remarks>
        public string DisplayLabelFormatPlural { get; set; }

        #endregion

        #region ICluster implementation

        /// <summary>
        /// Get the cluster key by which the given model will be partitioned by this strategy
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public virtual object GetClusterKey(object model)
        {
            return Column.GetValue(model);
        }

        /// <summary>
        /// Create a cluster to hold the given cluster key
        /// </summary>
        /// <param name="clusterKey"></param>
        /// <returns></returns>
        public virtual ICluster CreateCluster(object clusterKey)
        {
            return new Cluster(clusterKey);
        }

        /// <summary>
        /// Gets the display label that the given cluster should use
        /// </summary>
        /// <param name="cluster"></param>
        /// <returns></returns>
        public virtual string GetClusterDisplayLabel(ICluster cluster)
        {
            string s = Column.ValueToString(cluster.ClusterKey) ?? NULL_LABEL;
            if (String.IsNullOrEmpty(s))
                s = EMPTY_LABEL;
            return ApplyDisplayFormat(cluster, s);
        }

        /// <summary>
        /// Create a label that combines the string representation of the cluster
        /// key with a format string that holds an "X [N items in cluster]" type layout.
        /// </summary>
        /// <param name="cluster"></param>
        /// <param name="s"></param>
        /// <returns></returns>
        protected virtual string ApplyDisplayFormat(ICluster cluster, string s)
        {
            string format = (cluster.Count == 1) ? DisplayLabelFormatSingular : DisplayLabelFormatPlural;
            return String.IsNullOrEmpty(format) ? s : String.Format(format, s, cluster.Count);
        }

        #endregion
    }
}