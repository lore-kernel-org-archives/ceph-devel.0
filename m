From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: Store test BluestoreStatFSTest failure
Date: Fri, 2 Sep 2016 11:42:33 +0000
Message-ID: <CY1PR0201MB1820E737B99E2655DC28620085E50@CY1PR0201MB1820.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:27968
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751836AbcIBLmg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Sep 2016 07:42:36 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I am trying to run ceph_test_objectstore with my changes and I see this int=
ermittent failure.


Store_test.cc At line 1187:

1174     ObjectStore::Transaction t;
1175     bufferlist bl;
1176     bl.append("abcde");
1177     t.write(cid, hoid, 0, 5, bl);
1178     cerr << "Append 5 bytes" << std::endl;
1179     r =3D apply_transaction(store, &osr, std::move(t));
1180     ASSERT_EQ(r, 0);
1181
1182     struct store_statfs_t statfs;
1183     int r =3D store->statfs(&statfs);
1184     ASSERT_EQ(r, 0);
1185     ASSERT_EQ(5, statfs.stored);
1186     ASSERT_EQ(0x10000, statfs.allocated);
1187     ASSERT_EQ(available0 - 0x10000, statfs.available);

The total allocated are 1MB more than expected by this test.

(gdb) p statfs
$50 =3D {total =3D 10737418240, available =3D 10722672640, allocated =3D 65=
536, stored =3D 5, compressed =3D 0, compressed_allocated =3D 0, compressed=
_original =3D 0}
(gdb) p available0
$51 =3D 10723786752
(gdb) p 10723786752-10722672640
$52 =3D 1114112
(gdb) p 1114112-65536
$53 =3D 1048576
(gdb) p $53 / 1024
$54 =3D 1024
(gdb) list

I traced call and looks like there is really a 1MB allocation from BlueFS: =
_flush_range function.

Is it possible that when we write an object BlueFS also allocated another 1=
MB block and causing this difference?

How to avoid this failure? Is it test case issue ?

-Ramesh
PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
