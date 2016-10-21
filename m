From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Bluestore performance degradation for the latest master
Date: Fri, 21 Oct 2016 16:41:21 +0000
Message-ID: <BY2PR02MB3961FB46B0CFE536B412C9EF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
References: <BY2PR02MB3966F0CF4E7F1AD850C1E2BF4D40@BY2PR02MB396.namprd02.prod.outlook.com>
 <21ba142d-7b47-3b9d-2afd-6daf7d8b13d5@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:34560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752432AbcJUQlX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 21 Oct 2016 12:41:23 -0400
In-Reply-To: <21ba142d-7b47-3b9d-2afd-6daf7d8b13d5@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Igor !
But, I think this part of the code base was working fine for me , change in=
 encoding recently is breaking stuff ?
I will try your PR.


Regards
Somnath

-----Original Message-----
From: Igor Fedotov [mailto:ifedotov@mirantis.com]=20
Sent: Friday, October 21, 2016 9:32 AM
To: Somnath Roy; Sage Weil (sweil@redhat.com)
Cc: ceph-devel@vger.kernel.org
Subject: Re: Bluestore performance degradation for the latest master

See https://github.com/ceph/ceph/pull/11597 for the fix.


On 21.10.2016 18:29, Somnath Roy wrote:
> Hi Sage,
> I am profiling yesterday's master and seeing significant performance degr=
adation both for bigger block seq write and 4K RW.
>
> See the write amp (~5X) it is introducing for 4K RW (with=20
> min_alloc_size =3D 4K)
>
> ----total-cpu-usage---- -dsk/total- -net/total- ---paging-- ---system--
> usr sys idl wai hiq siq| read  writ| recv  send|  in   out | int   csw
>   52   8  32   6   0   2|  98M  504M| 122M   81M|   0     0 | 318k  361k
>   53   8  31   6   0   2|  91M  517M| 123M   83M|   0     0 | 358k  357k
>   53   8  30   6   0   2|  90M  572M| 123M   81M|   0     0 | 339k  348k
>   53   8  30   6   0   2|  95M  560M| 123M   81M|   0     0 | 321k  354k
>   53   8  31   6   0   2|  97M  509M| 125M   82M|   0     0 | 315k  365k
>   53   8  30   6   0   2|  87M  567M| 122M   81M|   0     0 | 322k  355k
>   53   9  30   6   0   2|  92M  547M| 122M   81M|   0     0 | 345k  361k
>
> I think the reason is, it seems the extent sharding logic is broken. See =
the tx we are writing after 10 min run (4K rw on 100G image after 1M precon=
ditioning). Onode key is 18K , no shard key..
>
> 2016-10-21 08:24:35.666549 7fd3ac701700 30 submit_transaction Rocksdb tra=
nsaction:
> Put( Prefix =3D M key =3D=20
> 0x0000000000000490'.0000000016.00000000000000019834' Value size =3D 182)=
=20
> Put( Prefix =3D M key =3D 0x0000000000000490'._fastinfo' Value size =3D 1=
86)=20
> Put( Prefix =3D O key =3D=20
> 0x7f800000000000000139748c93217262'd_data.10156b8b4567.000000000000324
> c!=3D'0xfffffffffffffffeffffffffffffffff'o' Value size =3D 18616) Merge(=
=20
> Prefix =3D b key =3D 0x0000004590180000 Value size =3D 16) Merge( Prefix =
=3D b=20
> key =3D 0x00000046df380000 Value size =3D 16)
>
> Thanks & Regards
> Somnath
> PLEASE NOTE: The information contained in this electronic mail message is=
 intended only for the use of the designated recipient(s) named above. If t=
he reader of this message is not the intended recipient, you are hereby not=
ified that you have received this message in error and that any review, dis=
semination, distribution, or copying of this message is strictly prohibited=
. If you have received this communication in error, please notify the sende=
r by telephone or e-mail (as shown above) immediately and destroy any and a=
ll copies of this message in your possession (whether hard copies or electr=
onically stored copies).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html

