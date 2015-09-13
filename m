From: huang jun <hjwsm1989@gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E7=AD=94=E5=A4=8D=3A_2_replications=2Cflapping_can_not_stop_for?=
	=?UTF-8?Q?_a_very_long_time?=
Date: Sun, 13 Sep 2015 17:46:08 +0800
Message-ID: <CABAwU-YFhMbrvT7ao6c605aJXi2kLiC7wjr3eSAQvAqrNNzCmg@mail.gmail.com>
References: <1CB94550540AE44E9CAAE8CD5AF40BF846CEB60D@H3CMLB12-EX.srv.huawei-3com.com>
	<CABAwU-bw_65HXAxNCVMkmCXZw4c5F0UBNwNUQwf9wOXbCt=VeA@mail.gmail.com>
	<1CB94550540AE44E9CAAE8CD5AF40BF846CEB6A5@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35857 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbbIMJqJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 13 Sep 2015 05:46:09 -0400
Received: by vkfp126 with SMTP id p126so44652180vkf.3
        for <ceph-devel@vger.kernel.org>; Sun, 13 Sep 2015 02:46:08 -0700 (PDT)
In-Reply-To: <1CB94550540AE44E9CAAE8CD5AF40BF846CEB6A5@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "zhao.mingyue@h3c.com" <zhao.mingyue@h3c.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2015-09-13 14:07 GMT+08:00 zhao.mingyue@h3c.com <zhao.mingyue@h3c.com>:
> hi, do you set both public_network and cluster_network, but just cut =
off the cluster_network?
> And do you have not only one osd on the same host?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3Dyes,public network+cluster network,and I cut off the =
cluster network; 2 node ,each node has serveral osds;
>
> If so, maybe you can not get stable, now the osd have peers in the pr=
ev and next osd id, they can exchange ping message.
> you cut off the cluster_network, the outbox peer osds can not detect =
the ping, they reports the osd failure to MON, and MON gather enough re=
porters and reports, then the osd will be marked down.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3Dwhen osd recv a new map and it is marked down,it thin=
k MON wrongly mark me down,what will it do,join the cluster again or ot=
her actions?can you give me some more detailed explanation?

It will send a boot message to MON, and will be marked UP by MON.
>
> But the osd can reports to MON bc the public_network is ok,  MON thin=
ks the osd wronly marked down, mark it to UP.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3Dyou mean that MON recv message ONE TIME from this osd=
 then it will mark this osd up?
>

> So flapping happens again and again.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D I tried 3 replications,(public network + cluster net=
work,3 node,each node has serveral osds),although it will occur flappin=
g,but after serveral minutes it will be stable,
> compared with 2 replications situation, I wait for the same intervals=
,the cluster can not be stable;
> so I'm confused about the machnism that how monitor can decide which =
osd is actually down?
>
It's weird, if you cut off the cluster_network, the osds in other node
can not get the ping messages, and naturally think the osd is failed.

> thanks
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: huang jun [mailto:hjwsm1989@gmail.com]
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B49=E6=9C=8813=E6=97=
=A5 10:39
> =E6=94=B6=E4=BB=B6=E4=BA=BA: zhaomingyue 09440 (RD)
> =E6=8A=84=E9=80=81: ceph-devel@vger.kernel.org
> =E4=B8=BB=E9=A2=98: Re: 2 replications,flapping can not stop for a ve=
ry long time
>
> hi, do you set both public_network and cluster_network, but just cut =
off the cluster_network?
> And do you have not only one osd on the same host?
> If so, maybe you can not get stable, now the osd have peers in the pr=
ev and next osd id, they can exchange ping message.
> you cut off the cluster_network, the outbox peer osds can not detect =
the ping, they reports the osd failure to MON, and MON gather enough re=
porters and reports, then the osd will be marked down.
> But the osd can reports to MON bc the public_network is ok,  MON thin=
ks the osd wronly marked down, mark it to UP.
> So flapping happens again and again.
>
> 2015-09-12 20:26 GMT+08:00 zhao.mingyue@h3c.com <zhao.mingyue@h3c.com=
>:
>>
>> Hi,
>> I'm testing reliability of ceph recently, and I have met the flappin=
g problem.
>> I have 2 replications, and cut off the cluster network ,now  flappin=
g can not stop,I have wait more than 30min, but status of osds are stil=
l not stable;
>>     I want to know about  when monitor recv reports from osds ,how i=
t can mark one osd down?
>>     (reports && reporter && grace) need to satisfied some conditions=
, how to calculate the grace?
>> and how long will the flapping  stop?Does the flapping must be stopp=
ed by configure,such as configure an osd lost?
>> Can someone help me ?
>> Thanks~
>> --------------------------------------------------------------------=
--
>> ---------------------------------------------------------------
>> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
>> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
>> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
>> =E9=82=AE=E4=BB=B6=EF=BC=81
>> This e-mail and its attachments contain confidential information fro=
m
>> H3C, which is intended only for the person or entity whose address i=
s
>> listed above. Any use of the information contained herein in any way
>> (including, but not limited to, total or partial disclosure,
>> reproduction, or dissemination) by persons other than the intended
>> recipient(s) is prohibited. If you receive this e-mail in error,
>> please notify the sender by phone or email immediately and delete it=
!
>
>
>
> --
> thanks
> huangjun



--=20
thanks
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
