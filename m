From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Bluestore performance degradation for the latest master
Date: Fri, 21 Oct 2016 15:29:04 +0000
Message-ID: <BY2PR02MB3966F0CF4E7F1AD850C1E2BF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-cys01nam02on0058.outbound.protection.outlook.com ([104.47.37.58]:3570
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935168AbcJUP3G (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Oct 2016 11:29:06 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
I am profiling yesterday's master and seeing significant performance degrad=
ation both for bigger block seq write and 4K RW.

See the write amp (~5X) it is introducing for 4K RW (with min_alloc_size =
=3D 4K)

----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
 52   8  32   6   0   2|  98M  504M| 122M   81M|   0     0 | 318k  361k
 53   8  31   6   0   2|  91M  517M| 123M   83M|   0     0 | 358k  357k
 53   8  30   6   0   2|  90M  572M| 123M   81M|   0     0 | 339k  348k
 53   8  30   6   0   2|  95M  560M| 123M   81M|   0     0 | 321k  354k
 53   8  31   6   0   2|  97M  509M| 125M   82M|   0     0 | 315k  365k
 53   8  30   6   0   2|  87M  567M| 122M   81M|   0     0 | 322k  355k
 53   9  30   6   0   2|  92M  547M| 122M   81M|   0     0 | 345k  361k

I think the reason is, it seems the extent sharding logic is broken. See th=
e tx we are writing after 10 min run (4K rw on 100G image after 1M precondi=
tioning). Onode key is 18K , no shard key..

2016-10-21 08:24:35.666549 7fd3ac701700 30 submit_transaction Rocksdb trans=
action:
Put( Prefix =3D M key =3D 0x0000000000000490'.0000000016.000000000000000198=
34' Value size =3D 182)
Put( Prefix =3D M key =3D 0x0000000000000490'._fastinfo' Value size =3D 186=
)
Put( Prefix =3D O key =3D 0x7f800000000000000139748c93217262'd_data.10156b8=
b4567.000000000000324c!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size=
 =3D 18616)
Merge( Prefix =3D b key =3D 0x0000004590180000 Value size =3D 16)
Merge( Prefix =3D b key =3D 0x00000046df380000 Value size =3D 16)

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
