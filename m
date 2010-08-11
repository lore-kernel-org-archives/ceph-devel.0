From: Xiaoguang Liu <syslxg@gmail.com>
Subject: Re: RBD performance is not good
Date: Wed, 11 Aug 2010 13:57:12 +0800
Message-ID: <AANLkTimQr4q3=+mY4F2i+vT12NYr5ynPAMEvVvRbWcPd@mail.gmail.com>
References: <C88708CC.5980%haifeng@yahoo-inc.com>
	<341848787.2318972.1281428284840.JavaMail.fmail@mwmweb029>
	<1281428860.2436.6.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45394 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0HKF5N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 01:57:13 -0400
Received: by qwh6 with SMTP id 6so9093976qwh.19
        for <ceph-devel@vger.kernel.org>; Tue, 10 Aug 2010 22:57:12 -0700 (PDT)
In-Reply-To: <1281428860.2436.6.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Ulrich Oelmann <ulrich.oelmann@web.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

the benchmark on both node is about 30MB/s. But I can only get 10MB/s
on /dev/rbd0. this is confusing.
the performance on ceph fs is affected by cache buffer very much. If I
write twice the size of system memory on ceph fs using dd(I suppose
buffer cache effect will be minor) the rate is about 30 MB/s, which
matchs the single osd benchmark very well.






964 1 : [INF] bench: wrote 1024 MB in blocks of 4096 KB in 34.203317
sec at 30657 KB/sec
10.08.11_13:25:41.370628   log 10.08.11_13:25:40.319855 osd0
172.16.12.1:6801/23964 2 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 33.138057 sec at 31642 KB/sec
10.08.11_13:26:32.776497   log 10.08.11_13:27:07.812769 osd1
172.16.12.2:6800/31012 1 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 33.503103 sec at 31297 KB/sec
10.08.11_13:27:10.954734   log 10.08.11_13:27:46.003163 osd1
172.16.12.2:6800/31012 2 : [INF] bench: wrote 1024 MB in blocks of
4096 KB in 34.287723 sec at 30581 KB/sec



On Tue, Aug 10, 2010 at 4:27 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
> It might be usefull to benchmark your individual OSD's first.
>
> Wiki: http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance
>
> There might be a slow OSD in your cluster which slows down the cluste=
r.
>
> With some test with the Ceph filesystem i was able to reach speeds up=
 to
> 150MB/sec (dd with conv=3Dsync) writing to my Ceph filesystem.
>
> Haven't tried RBD yet on the cluster, but in my previous setup i was
> reaching about 30 ~ 35MB/sec with RBD.
>
> Wido
>
> On Tue, 2010-08-10 at 10:18 +0200, Ulrich Oelmann wrote:
>> Hi there,
>>
>> I don't think that Xiaoguang saw the speed of 30-60 MB/s because of =
cache
>> effects as the speed should be in the order of at least some hundred=
 MB/s
>> then. Do you agree?
>>
>> Could perhaps someone having an rbd-setup running confirm or reject
>> Xiaoguangs measurements?
>>
>> Best regards
>> Ulrich
>>
>>
>> -----Urspr=C3=BCngliche Nachricht-----
>> Von: Haifeng Liu <haifeng@yahoo-inc.com>
>> Gesendet: Aug 10, 2010 7:46:52 AM
>> An: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
>> Betreff: Re: RBD performance is not good
>>
>> >Xiaoguang,
>> >
>> >This should be a normal result =E2=80=93 the client=E2=80=99s pagec=
ache buffered the write
>> >when you dd onto a ceph fs, while no buffering when dd to a rbd. Wh=
at do you
>> >think?
>> >
>> >Thanks
>> >-haifeng
>> >
>> >
>> >On 8/10/10 11:23 AM, "Xiaoguang Liu" =C2=A0wrote:
>> >
>> >> on my 2-ods-node cluster, dd can only reach 13MB/s on rbd device.=
 this
>> >> is much lower than what I expected.
>> >> I can get 30-60 MB/s on a ceph filesystem over the same cluster.
>> >>
>> >> any idea?
>> >>
>> >>
>> >>
>> >>
>> >> [root@ceph-1 ~]# dd if=3D/dev/zero of=3D/dev/rbd0 =C2=A0bs=3D1M c=
ount=3D5000
>> >> 5000+0 records in
>> >> 5000+0 records out
>> >> 5242880000 bytes (5.2 GB) copied, 391.508 s, 13.4 MB/s
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-inf=
o.html
>> >>
>> >
>> >N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD =CA=87=DA=99=EF=BF=BD,j =EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD =EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j=
"=EF=BF=BD=EF=BF=BD
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
