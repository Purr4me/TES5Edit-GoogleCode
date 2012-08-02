namespace TESVSnip {
    partial class HexDataEdit {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing) {
            if(disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent() {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(HexDataEdit));
            this.bSave = new System.Windows.Forms.Button();
            this.bCancel = new System.Windows.Forms.Button();
            this.tbName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.tbFloat = new System.Windows.Forms.TextBox();
            this.tbInt = new System.Windows.Forms.TextBox();
            this.tbWord = new System.Windows.Forms.TextBox();
            this.bCFloat = new System.Windows.Forms.Button();
            this.bCInt = new System.Windows.Forms.Button();
            this.bCWord = new System.Windows.Forms.Button();
            this.cbInsert = new System.Windows.Forms.CheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.tbFormID = new System.Windows.Forms.TextBox();
            this.bLookup = new System.Windows.Forms.Button();
            this.bCFormID = new System.Windows.Forms.Button();
            this.tbEDID = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.bFromFile = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.hexBox1 = new Be.Windows.Forms.HexBox();
            this.SuspendLayout();
            // 
            // bSave
            // 
            resources.ApplyResources(this.bSave, "bSave");
            this.bSave.DialogResult = System.Windows.Forms.DialogResult.OK;
            this.bSave.Name = "bSave";
            this.bSave.UseVisualStyleBackColor = true;
            this.bSave.Click += new System.EventHandler(this.bSave_Click);
            // 
            // bCancel
            // 
            resources.ApplyResources(this.bCancel, "bCancel");
            this.bCancel.DialogResult = System.Windows.Forms.DialogResult.Cancel;
            this.bCancel.Name = "bCancel";
            this.bCancel.UseVisualStyleBackColor = true;
            this.bCancel.Click += new System.EventHandler(this.bCancel_Click);
            // 
            // tbName
            // 
            resources.ApplyResources(this.tbName, "tbName");
            this.tbName.CharacterCasing = System.Windows.Forms.CharacterCasing.Upper;
            this.tbName.Name = "tbName";
            this.tbName.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.tbName_KeyPress);
            this.tbName.Leave += new System.EventHandler(this.tbName_Leave);
            // 
            // label1
            // 
            resources.ApplyResources(this.label1, "label1");
            this.label1.Name = "label1";
            // 
            // tbFloat
            // 
            resources.ApplyResources(this.tbFloat, "tbFloat");
            this.tbFloat.Name = "tbFloat";
            // 
            // tbInt
            // 
            resources.ApplyResources(this.tbInt, "tbInt");
            this.tbInt.Name = "tbInt";
            // 
            // tbWord
            // 
            resources.ApplyResources(this.tbWord, "tbWord");
            this.tbWord.Name = "tbWord";
            // 
            // bCFloat
            // 
            resources.ApplyResources(this.bCFloat, "bCFloat");
            this.bCFloat.Name = "bCFloat";
            this.bCFloat.UseVisualStyleBackColor = true;
            this.bCFloat.Click += new System.EventHandler(this.bCFloat_Click);
            // 
            // bCInt
            // 
            resources.ApplyResources(this.bCInt, "bCInt");
            this.bCInt.Name = "bCInt";
            this.bCInt.UseVisualStyleBackColor = true;
            this.bCInt.Click += new System.EventHandler(this.bCInt_Click);
            // 
            // bCWord
            // 
            resources.ApplyResources(this.bCWord, "bCWord");
            this.bCWord.Name = "bCWord";
            this.bCWord.UseVisualStyleBackColor = true;
            this.bCWord.Click += new System.EventHandler(this.bCShort_Click);
            // 
            // cbInsert
            // 
            resources.ApplyResources(this.cbInsert, "cbInsert");
            this.cbInsert.Name = "cbInsert";
            this.cbInsert.UseVisualStyleBackColor = true;
            this.cbInsert.CheckedChanged += new System.EventHandler(this.cbInsert_CheckedChanged);
            // 
            // label2
            // 
            resources.ApplyResources(this.label2, "label2");
            this.label2.Name = "label2";
            // 
            // label3
            // 
            resources.ApplyResources(this.label3, "label3");
            this.label3.Name = "label3";
            // 
            // label4
            // 
            resources.ApplyResources(this.label4, "label4");
            this.label4.Name = "label4";
            // 
            // tbFormID
            // 
            resources.ApplyResources(this.tbFormID, "tbFormID");
            this.tbFormID.Name = "tbFormID";
            // 
            // bLookup
            // 
            resources.ApplyResources(this.bLookup, "bLookup");
            this.bLookup.Name = "bLookup";
            this.bLookup.UseVisualStyleBackColor = true;
            this.bLookup.Click += new System.EventHandler(this.bLookup_Click);
            // 
            // bCFormID
            // 
            resources.ApplyResources(this.bCFormID, "bCFormID");
            this.bCFormID.Name = "bCFormID";
            this.bCFormID.UseVisualStyleBackColor = true;
            this.bCFormID.Click += new System.EventHandler(this.bCFormID_Click);
            // 
            // tbEDID
            // 
            resources.ApplyResources(this.tbEDID, "tbEDID");
            this.tbEDID.Name = "tbEDID";
            this.tbEDID.ReadOnly = true;
            // 
            // label5
            // 
            resources.ApplyResources(this.label5, "label5");
            this.label5.Name = "label5";
            // 
            // bFromFile
            // 
            resources.ApplyResources(this.bFromFile, "bFromFile");
            this.bFromFile.Name = "bFromFile";
            this.bFromFile.UseVisualStyleBackColor = true;
            this.bFromFile.Click += new System.EventHandler(this.bFromFile_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.AddExtension = false;
            this.openFileDialog1.FileName = "openFileDialog1";
            resources.ApplyResources(this.openFileDialog1, "openFileDialog1");
            this.openFileDialog1.RestoreDirectory = true;
            // 
            // hexBox1
            // 
            resources.ApplyResources(this.hexBox1, "hexBox1");
            this.hexBox1.LineInfoForeColor = System.Drawing.Color.Empty;
            this.hexBox1.Name = "hexBox1";
            this.hexBox1.ShadowSelectionColor = System.Drawing.Color.FromArgb(((int)(((byte)(100)))), ((int)(((byte)(60)))), ((int)(((byte)(188)))), ((int)(((byte)(255)))));
            this.hexBox1.StringViewVisible = true;
            this.hexBox1.UseFixedBytesPerLine = true;
            this.hexBox1.InsertActiveChanged += new System.EventHandler(this.hexBox1_InsertActiveChanged);
            this.hexBox1.SelectionStartChanged += new System.EventHandler(this.hexBox1_SelectionStartChanged);
            // 
            // HexDataEdit
            // 
            this.AcceptButton = this.bSave;
            resources.ApplyResources(this, "$this");
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.CancelButton = this.bCancel;
            this.Controls.Add(this.bFromFile);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.tbEDID);
            this.Controls.Add(this.bCFormID);
            this.Controls.Add(this.bLookup);
            this.Controls.Add(this.tbFormID);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cbInsert);
            this.Controls.Add(this.bCWord);
            this.Controls.Add(this.bCInt);
            this.Controls.Add(this.bCFloat);
            this.Controls.Add(this.tbWord);
            this.Controls.Add(this.tbInt);
            this.Controls.Add(this.tbFloat);
            this.Controls.Add(this.hexBox1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.tbName);
            this.Controls.Add(this.bCancel);
            this.Controls.Add(this.bSave);
            this.Name = "HexDataEdit";
            this.ShowInTaskbar = false;
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button bSave;
        private System.Windows.Forms.Button bCancel;
        private System.Windows.Forms.TextBox tbName;
        private System.Windows.Forms.Label label1;
        private Be.Windows.Forms.HexBox hexBox1;
        private System.Windows.Forms.TextBox tbFloat;
        private System.Windows.Forms.TextBox tbInt;
        private System.Windows.Forms.TextBox tbWord;
        private System.Windows.Forms.Button bCFloat;
        private System.Windows.Forms.Button bCInt;
        private System.Windows.Forms.Button bCWord;
        private System.Windows.Forms.CheckBox cbInsert;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox tbFormID;
        private System.Windows.Forms.Button bLookup;
        private System.Windows.Forms.Button bCFormID;
        private System.Windows.Forms.TextBox tbEDID;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button bFromFile;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
    }
}