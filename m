From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [RFC] add rocksdb support
Date: Tue, 04 Mar 2014 05:48:55 +0100 (CET)
Message-ID: <da48b138-6098-4d76-9631-c6128137a196@mailpro>
References: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:51190 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaCDEtE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 23:49:04 -0500
In-Reply-To: <75674D092A819E4189E91166C74CB90D0131CB27@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xinxin Shu <xinxin.shu@intel.com>
Cc: ceph-devel@vger.kernel.org

>>Performance Test=20
>>Attached file is the performance comparison of rocksdb and leveldb on=
 four nodes with 40 osds, using 'rados bench' as the test tool. The per=
formance results is quite promising.=20

Thanks for your work, indeed performance seem to be promising !

>>Any comments or suggestions are greatly appreciated.=20

Could you do test with random io write with last fio (with rbd support)=
 ?

http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-February/00818=
2.html
> The fio command: fio -direct=3D1 -iodepth=3D64 -thread -rw=3Drandwrit=
e
>> -ioengine=3Drbd -bs=3D4k -size=3D19G -numjobs=3D1 -runtime=3D100
>> -group_reporting -name=3Debs_test -pool=3Dopenstack -rbdname=3Dimage
>> -clientname=3Dfio -invalidate=3D0


----- Mail original -----=20

De: "Xinxin Shu" <xinxin.shu@intel.com>=20
=C3=80: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Lundi 3 Mars 2014 03:07:18=20
Objet: [RFC] add rocksdb support=20

Hi all,=20

This patch added rocksdb support for ceph, enabled rocksdb for omap dir=
ectory. Rocksdb source code can be get from link. To use use rocksdb, C=
++11 standard should be enabled, gcc version >=3D 4.7 is required to ge=
t C++11 support. Rocksdb can be installed with instructions described i=
n the INSTALL.md file, and rocksdb header files (include/rocksdb/*) and=
 library (librocksdb.so*) need to be copied to corresponding directorie=
s.=20
To enable rocksdb, add "--with-librocksdb" option to configure. The roc=
ksdb branch is here(https://github.com/xinxinsh/ceph/tree/rocksdb).=20


Performance Test=20
Attached file is the performance comparison of rocksdb and leveldb on f=
our nodes with 40 osds, using 'rados bench' as the test tool. The perfo=
rmance results is quite promising.=20

Any comments or suggestions are greatly appreciated.=20

Rados bench BandWidth(MB/s) Average latency=20
Leveldb rocksdb Leveldb rocksdb=20
write 4 threads 263.762 272.549 0.061 0.059=20
write 8 threads 449.834 457.811 0.071 0.070=20
write 16 threads 642.100 638.972 0.100 0.100=20
write 32 threads 705.897 717.598 0.181 0.178=20
write 64 threads 705.011 717.204 0.370 0.362=20
read 4 threads 873.588 841.704 0.073 0.076=20
read 8 threads 816.699 818.451 0.078 0.078=20
read 16 threads 808.810 798.053 0.079 0.080=20
read 32 threads 798.394 802.796 0.080 0.080=20
read 64 threads 792.848 790.593 0.081 0.081=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
