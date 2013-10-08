From: "hjwsm1989-gmail" <hjwsm1989@gmail.com>
Subject: =?utf-8?Q?=E7=AD=94=E5=A4=8D:_ceph_on_ubuntu_and_centos?=
Date: Tue, 8 Oct 2013 10:37:30 +0800
Message-ID: <001a01cec3cf$5aad0c60$10072520$@gmail.com>
References: <h1bx0us4fo0wk19p44aeacb9.1381184213956@email.android.com> <CA+4uBUaCeK8+kDg-GCf+C2UVeo9Kah=732J1B++S0EZHUqYdXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37025 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab3JHChp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Oct 2013 22:37:45 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so7910523pde.23
        for <ceph-devel@vger.kernel.org>; Mon, 07 Oct 2013 19:37:44 -0700 (PDT)
In-Reply-To: <CA+4uBUaCeK8+kDg-GCf+C2UVeo9Kah=732J1B++S0EZHUqYdXA@mail.gmail.com>
Content-Language: zh-cn
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: 'Samuel Just' <sam.just@inktank.com>
Cc: 'huangyellowhuang' <huangyellowhuang@163.com>, 'ceph-devel' <ceph-devel@vger.kernel.org>

Thanks
We tried the settings you recommened.
=46or my cluster on Ubuntu 13.10, I have 4 OSDs on one host, I set :
osd client message size cap =3D 52428800
osd client message cap =3D 50
=46rom client side, the write speed between 50~100MB/s, avg is 79MB/s.

But on the centos 6.4 cluster, I upgrade the kernel to 3.8, it seems no=
 performance improve:
I have 2 hosts and each runs 3 OSDs(total 6 OSDs)
The write speed is smooth, but speed is less than that run on Ubuntu.
I think the replica write may result to this difference.

-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
=E5=8F=91=E4=BB=B6=E4=BA=BA: Samuel Just [mailto:sam.just@inktank.com]=20
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B410=E6=9C=888=E6=97=A5=
 7:55
=E6=94=B6=E4=BB=B6=E4=BA=BA: hjwsm1989@gmail.com
=E6=8A=84=E9=80=81: huangyellowhuang; ceph-devel
=E4=B8=BB=E9=A2=98: Re: ceph on ubuntu and centos

You might try
osd client message size cap =3D 26214400
osd client message cap =3D 25.

osd op threads =3D 8 and filestore op threads =3D 8 might also be good.
Let us know what you find!

Sounds like the the kernel is the most obvious candidate for slowness o=
n Centos 6.4, is there a 3.0+ kernel around for Centos 6.4 you could tr=
y?
-Sam

On Mon, Oct 7, 2013 at 3:16 PM, hjwsm1989@gmail.com <hjwsm1989@gmail.co=
m> wrote:
> thanks for your reply !
> the ubuntu is 3.8,centos kernel version is 2.6.32.
> which setting item should we change to get  the smoth write speed ?
> we tried tune  some parameters:
> osd op threads=3D 8
> filestore op threads =3D 8
> filestore max op queue =3D 30
> which one will have the largest effect on performance?
>
> thanks
>
> Samuel Just <sam.just@inktank.com>=E7=BC=96=E5=86=99=EF=BC=9A
>
>>Interesting!  What kernel versions were running on the 13.10 and=20
>>centos 6.4 clusters?
>>-Sam
>>
>>On Fri, Oct 4, 2013 at 6:33 PM, huangyellowhuang=20
>><huangyellowhuang@163.com> wrote:
>>> Hi,all
>>> We test the ceph version 0.69=20
>>> (6ca6f2f9f754031f4acdb971b71c92c9762e18c3) on Ubuntu server 13.10=20
>>> and centos 6.4 final Our cluster configuration:
>>> 3 host machine, each runs 3 OSDs(use XFS as backend fs),MON and MDS=
=20
>>> runs on one of the three host, We have one KClient on Ubuntu server=
=20
>>> 13.10
>>>
>>> The cluster runs on Ubuntu works fine and a few =E2=80=98slow reque=
sts=E2=80=99=20
>>> msgs, about 100MB/s write speed.
>>> But the cluster runs on centos is very bad, avg 30MB/s write speed,=
=20
>>> many osd requests slow:
>>> 2013-10-05 08:35:09.931145 mon.0 [INF] pgmap v928: 192 pgs: 192=20
>>> active+clean ; 50873 MB data, 101716 MB used, 13857 GB / 13956 GB=20
>>> avail; 115 MB/s wr, 28 op/s
>>> 2013-10-05 08:35:12.087614 mon.0 [INF] pgmap v929: 192 pgs: 192=20
>>> active+clean ; 50901 MB data, 101780 MB used, 13857 GB / 13956 GB=20
>>> avail; 32593 KB/s wr, 8  op/s
>>> 2013-10-05 08:35:03.963979 osd.0 [WRN] 37 slow requests, 1 included=
=20
>>> below; o ldest blocked for > 798.235962 secs
>>> 2013-10-05 08:35:03.963984 osd.0 [WRN] slow request 240.831078=20
>>> seconds old, received at 2013-10-05 08:31:03.132836:=20
>>> osd_op(mds.0.1:375 200.00000000 [wri tefull 0~84] 1.844f3494 e47) v=
4=20
>>> currently no flag points reached
>>> 2013-10-05 08:35:08.965134 osd.0 [WRN] 37 slow requests, 1 included=
=20
>>> below; o ldest blocked for > 803.237127 secs
>>> 2013-10-05 08:35:08.965139 osd.0 [WRN] slow request 480.312618=20
>>> seconds old, received at 2013-10-05 08:27:08.652461:=20
>>> osd_op(mds.0.1:307 200.00000000 [wri tefull 0~84] 1.844f3494 e47) v=
4=20
>>> currently no flag points reached
>>> 2013-10-05 08:35:10.965619 osd.0 [WRN] 37 slow requests, 1 included=
=20
>>> below; o ldest blocked for > 805.237600 secs
>>> 2013-10-05 08:35:10.965624 osd.0 [WRN] slow request 120.946652=20
>>> seconds old, received at 2013-10-05 08:33:10.018900:=20
>>> osd_op(mds.0.1:404 200.00000000 [wri tefull 0~84] 1.844f3494 e47) v=
4=20
>>> currently no flag points reached
>>> 2013-10-05 08:35:11.965986 osd.0 [WRN] 37 slow requests, 1 included=
=20
>>> below; o ldest blocked for > 806.237800 secs
>>> 2013-10-05 08:35:11.965992 osd.0 [WRN] slow request 60.474314=20
>>> seconds old, r eceived at 2013-10-05 08:34:11.491438:=20
>>> osd_op(mds.0.1:430 200.00000000 [writ efull 0~84] 1.844f3494 e47) v=
4=20
>>> currently no flag points reached
>>>
>>> And we need to build a cluster have 4 hosts, each has 18 OSDs and 1=
=20
>>> kclient, every kclient server as samba server that serves 4 samba c=
lients.
>>> 1) Which linux distrubtion should we used? Centos or Ubuntu?
>>> 2) What results in ceph performances so large on different distribu=
tion?
>>> 3) It seems the bottleneck is underlayer fs can not handle requests=
=20
>>> fast as ceph expect, bc the =E2=80=98slow requests=E2=80=99 shows i=
f a request does=20
>>> not handle after 30s.
>>>
>>> Thanks!
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org=20
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>--
>>To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
>>in the body of a message to majordomo@vger.kernel.org More majordomo=20
>>info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
