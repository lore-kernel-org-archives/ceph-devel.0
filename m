From: Manali Kulkarni <Manali.Kulkarni@sandisk.com>
Subject: delta parity method for EC
Date: Tue, 12 Jul 2016 04:50:01 +0000
Message-ID: <SN1PR02MB13571B6ACC52D3C545E7FEF7F9300@SN1PR02MB1357.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:10784
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750743AbcGLEuI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Jul 2016 00:50:08 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel (ceph-devel@vger.kernel.org)" <ceph-devel@vger.kernel.org>
Cc: Samuel Just <sjust@redhat.com>, Tomy Cheru <Tomy.Cheru@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>

Hi,
I could code and test delta parity method for Jerasure reed Solomon coding.
Below are the details of the experiment.
 As, I was not able to attach .docx file, pasting the contents in the mail itself.
Do let me know if this looks good.


Thanks
Manali

Background:
----------------
Consider this example:
P = A + B + C

Where Parity P is XOR of A, B and C.

If, A changes to A', Modified parity P' can be calculated as
P' = A' + B + C    [Read -Modify- Write method]
Or
P' = P + A + A'  [Delta Parity method]

We can come up with a scheme for choosing between these two methods. For example, for smaller modified chunks, we can use delta parity approach, and when most of the chunks are modified, we can go with read modify write method.
Currently, only read-modify-write method is possible with Erasure Coding Plugins in Ceph, mostly because no interface is present for delta parity method. The encode function typically takes all data chunks, and encodes the coding chunks. So, even for small number of modified chunks, we need to read all the data chunks resulting in increased number of reads.
So, goal of this experiment was to enable delta parity method for Erasure coding plugins. To start with, I made changes to Reed Solomon code of Jerasure plugin to provide this interface. And I could also test this piece of logic. This delta parity interface can then be used by ECBackend code, while writing partial writes.

Code Logic:
---------------
Current basic algorithm [Reed Solomon Van] works as follows:
1. First step is to create a coding matrix which is fixed matrix for given k, m and w values.
     matrix = reed_sol_vandermonde_coding_matrix(k, m, w);

2. To encode, that is given k data chunks, we would like to add m coding chunks using reed solomon van coding technique. This is nothing but matrix multiplication of coding matrix calculated above and k data chunks to get m coding chunks.
     jerasure_matrix_encode(k, m, w, matrix, data, coding, blocksize);

Here, encoding takes all data chunks as input. We need one more interface which can take new and old changed data chunks for delta parity method.

3. //for decoding
i = jerasure_matrix_decode(k, m, w, matrix, 1, erasures, data, coding, blocksize);

Summary of changes made:
---------------------------------
1.Added routine jerasure_delta_matrix_encode() which calls jerasure_delta_matrix_dotprod() for each row of the encode matrix.
                void jerasure_delta_matrix_encode(int k, int m, int w, int *matrix, int j, char **data_ptrs, char **new_data_ptrs, char **coding_ptrs, int size)
                 Currently, this function only takes one data chunk being modified. Int j specifies the data chunk being modified. It can be easily extended to take a list of modified chunks by making j as ptr or array.

2.Tested the changes by modifying "reed_sol_01.c" Example file

Unit test results:
---------------------
I modified already present unit test case for reed Solomon to test my changes.

Usage: reed_sol_01 k m w seed - Does a simple Reed-Solomon coding example in GF(2^w).
w must be 8, 16 or 32.  k+m must be <= 2^w.  It sets up a classic Vandermonde-based generator matrix and encodes k devices of 8 bytes each with it.  Then it changes one data device value. It then encodes it using both the classic method and the new parity delta method.  See that both the methods encode same values, ie have identical coding devices.

root@FDFIND:~/manali/ceph/src/erasure-code/jerasure/jerasure/Examples# ./reed_sol_01 4 1 8 1

Encoding Complete:

Data                                            Coding
D0 : 82 01 ea 48 ca 69 41 f4    C0 : 64 db 2c 50 52 38 aa 44
D1 : 06 d3 2d ec c9 f6 15 c1
D2 : 7a cb 0c 45 e4 db 71 ec
D3 : 9a c2 e7 b1 b5 7c 8f 9d

//change one data chunk

Encoding Complete after changing one data element using read-modify-write method:
Data                                             Coding
D0 : 82 01 ea 48 ca 69 41 f4    C0 : de 44 41 50 d9 00 8f f6
D1 : bc 4c 40 ec 42 ce 30 73
D2 : 7a cb 0c 45 e4 db 71 ec
D3 : 9a c2 e7 b1 b5 7c 8f 9d

Encoding Complete after changing one data element using delta parity method:
Data                                            Coding
D0 : 82 01 ea 48 ca 69 41 f4    C0 : de 44 41 50 d9 00 8f f6
D1 : bc 4c 40 ec 42 ce 30 73
D2 : 7a cb 0c 45 e4 db 71 ec
D3 : 9a c2 e7 b1 b5 7c 8f 9d

Code snippet:
----------------
+void jerasure_delta_matrix_encode(int k, int m, int w, int *matrix, int j,
+                          char **data_ptrs, char **new_data_ptrs, char **coding_ptrs, int size)
+{
+  int I;
+  if (w != 8 && w != 16 && w != 32) {
+    fprintf(stderr, "ERROR: jerasure_matrix_encode() and w is not 8, 16 or 32\n");
+    assert(0);
+  }
+  for (i = 0; i < m; i++) {
+    jerasure_delta_matrix_dotprod(k, w, matrix+(i*k), j, NULL, k+i, data_ptrs, new_data_ptrs, coding_ptrs, size);
+  }
+}
+//New function to calculate delta dot product.
+void jerasure_delta_matrix_dotprod(int k, int w, int *matrix_row, int j,
+                          int *src_ids, int dest_id,
+                          char **old_data_ptrs, char **new_data_ptrs, char **coding_ptrs, int size)
+{
+  char *dptr, *sptr, *new_sptr;
+  if (w != 1 && w != 8 && w != 16 && w != 32) {
+    fprintf(stderr, "ERROR: jerasure_matrix_dotprod() called and w is not 1, 8, 16 or 32\n");
+    assert(0);
+  }
+  dptr = (dest_id < k) ? new_data_ptrs[dest_id] : coding_ptrs[dest_id-k];
+  /* First xor any data that does not need to be multiplied by a factor */
+  // check the column j of given matrix row, if any of them are 1, do following
+    if (matrix_row[j] == 1) {
+      if (src_ids == NULL) {
+        sptr = old_data_ptrs[j];
+        new_sptr = new_data_ptrs[j];
+      }
+        galois_region_xor(sptr, dptr, size);
+        galois_region_xor(new_sptr, dptr, size);
+        jerasure_total_xor_bytes += size; //change this.
+    return;
+    }
+  /* Now do the data that needs to be multiplied by a factor */
+    if (matrix_row[j] != 0 && matrix_row[j] != 1) {
+      if (src_ids == NULL) {
+        sptr = old_data_ptrs[j];
+        new_sptr = new_data_ptrs[j];
+      }
+      switch (w) {
+        case 8:
+               galois_w08_region_multiply(sptr, matrix_row[j], size, dptr, 1);
+               galois_w08_region_multiply(new_sptr, matrix_row[j], size, dptr, 1);
+               break;
+        case 16:
+               galois_w16_region_multiply(sptr, matrix_row[j], size, dptr, 1);
+               galois_w16_region_multiply(new_sptr, matrix_row[j], size, dptr, 1);
+               break;
+        case 32:
+               galois_w32_region_multiply(sptr, matrix_row[j], size, dptr, 1);
+               galois_w32_region_multiply(new_sptr, matrix_row[j], size, dptr, 1);
+               break;
+      }
+      jerasure_total_gf_bytes += size;//change this
+    }
+}
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
