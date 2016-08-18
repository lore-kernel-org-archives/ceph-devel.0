From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: BlueStore metadata write overhead
Date: Thu, 18 Aug 2016 23:10:04 +0000
Message-ID: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:23296
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754244AbcHSCqR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 18 Aug 2016 22:46:17 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage,
Here is some estimate probably how much extra (space wise) we are writing w=
ith Bluestore. Considering Rocksdb has not much space amp for level style c=
ompaction , these are mostly the metadata Bluestore is writing.

BlueStore:
----------------
root@stormeap-1:~/fio_rbd/fio/examples# ceph df
2016-08-17 11:00:57.936952 7f5c39a2b700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
2016-08-17 11:00:57.939969 7f5c39a2b700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
2016-08-17 11:00:57.941269 7f5c39a2b700 -1 WARNING: the following dangerous=
 and experimental features are enabled: bluestore,rocksdb
GLOBAL:
    SIZE     AVAIL      RAW USED     %RAW USED
    106T     22411G       86867G         79.49
POOLS:
    NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
    recovery_test     1      39062G     71.49         6290G     10000003


So, if we trust the statfs implementation of Bluestore , it is  writing ~87=
43 GB more.  Total data  =3D image size of 39062 GB * replication 2 =3D ~78=
124 GB. So, ~11.19% more.
BTW, this is after 1MB image preconditioning only, filling with 4K blocksiz=
e will be adding more metadata.

Filestore:
-----------
GLOBAL:
    SIZE     AVAIL      RAW USED     %RAW USED
    109T     34443G       78147G         69.41
POOLS:
    NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
    recovery_test     2      39062G     69.39        12930G     10000003

So, in the similar setup , filestore is writing only ~23GB extra and i.e ~0=
.029%

Thanks & Regards
Somnath
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
