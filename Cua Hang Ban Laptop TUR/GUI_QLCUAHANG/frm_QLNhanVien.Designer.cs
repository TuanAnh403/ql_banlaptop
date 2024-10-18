namespace GUI_QLCUAHANG
{
    partial class frm_QLNhanVien
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.Button button3;
            System.Windows.Forms.Button button2;
            System.Windows.Forms.Button button1;
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            button3 = new System.Windows.Forms.Button();
            button2 = new System.Windows.Forms.Button();
            button1 = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // button3
            // 
            button3.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            button3.Font = new System.Drawing.Font("Times New Roman", 13.84615F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            button3.ForeColor = System.Drawing.SystemColors.ControlText;
            button3.Location = new System.Drawing.Point(1066, 285);
            button3.Name = "button3";
            button3.Size = new System.Drawing.Size(142, 57);
            button3.TabIndex = 7;
            button3.Text = "Xóa";
            button3.UseVisualStyleBackColor = false;
            // 
            // button2
            // 
            button2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            button2.Font = new System.Drawing.Font("Times New Roman", 13.84615F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            button2.ForeColor = System.Drawing.SystemColors.ControlText;
            button2.Location = new System.Drawing.Point(1066, 222);
            button2.Name = "button2";
            button2.Size = new System.Drawing.Size(142, 57);
            button2.TabIndex = 6;
            button2.Text = "Sửa";
            button2.UseVisualStyleBackColor = false;
            // 
            // button1
            // 
            button1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            button1.Font = new System.Drawing.Font("Times New Roman", 13.84615F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            button1.ForeColor = System.Drawing.SystemColors.ControlText;
            button1.Location = new System.Drawing.Point(1066, 159);
            button1.Name = "button1";
            button1.Size = new System.Drawing.Size(142, 57);
            button1.TabIndex = 5;
            button1.Text = "Thêm";
            button1.UseVisualStyleBackColor = false;
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(12, 12);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 56;
            this.dataGridView1.RowTemplate.Height = 24;
            this.dataGridView1.Size = new System.Drawing.Size(1048, 532);
            this.dataGridView1.TabIndex = 4;
            // 
            // frm_QLNhanVien
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1216, 591);
            this.Controls.Add(button3);
            this.Controls.Add(button2);
            this.Controls.Add(button1);
            this.Controls.Add(this.dataGridView1);
            this.Name = "frm_QLNhanVien";
            this.Text = "frm_QLNhanVien";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView dataGridView1;
    }
}