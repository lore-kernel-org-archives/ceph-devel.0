From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <slawomir.skowron@gmail.com>
Subject: Re: RadosGW problems with copy in s3
Date: Mon, 5 Mar 2012 11:23:56 +0100
Message-ID: <CAMwB3Tg3e7dKpves54sFag6BTp5PAfYwOgYQ4PHW0gs2oDkTJw@mail.gmail.com>
References: <CAMwB3ThF2kTWNDJM9zYOVh0ud29nAoib4yTwNRgiJuacDKh=7w@mail.gmail.com>
	<CAC-hyiHSUYv-Mk7RxB-_a8ObePrf9osLRFjj-G2_9Dz6z8v6Vw@mail.gmail.com>
	<CAMwB3ThZ4jPis_Bb9tsf=HTnh3gLd6CNkn2XMr4xo09bO3hEiQ@mail.gmail.com>
	<CAC-hyiHB0aDsEO8ES8pqhcXB38MR1QNZLMB=jyRm2p_Yp7V8Aw@mail.gmail.com>
	<CAC-hyiFL429jjfi7J7fiwoshdRQRq9_1AhECJ+sg2=nV+5NpZw@mail.gmail.com>
	<CAMwB3Tje2tgruL8yP29Q1eYTON5kuS3neetA=6zXed4OriJefg@mail.gmail.com>
	<CAC-hyiHFUAGWJf1MxGS=MBcdsHSYrtpjcPo6di3MOK=S=6Hj0g@mail.gmail.com>
	<CAMwB3TjuDhRfTheJvTKx7yiTy7JSiTp2h795fuNS-mjFeJP=Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42046 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756472Ab2CEKX5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Mar 2012 05:23:57 -0500
Received: by wgbdr13 with SMTP id dr13so3358451wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Mar 2012 02:23:56 -0800 (PST)
In-Reply-To: <CAMwB3TjuDhRfTheJvTKx7yiTy7JSiTp2h795fuNS-mjFeJP=Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

2012/3/1 S=C5=82awomir Skowron <slawomir.skowron@gmail.com>:
> 2012/2/29 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>> On Wed, Feb 29, 2012 at 5:06 AM, S=C5=82awomir Skowron
>> <slawomir.skowron@gmail.com> wrote:
>>>
>>> Ok, it's intentional.
>>>
>>> We are checking meta info about files, then, checking md5 of file
>>> content. In parallel, updating object that have change, and then
>>> archiving this objects in another key, and last thing is deleting
>>> objects that expires.
>>>
>>> This happens over and over, because, this site is changing many tim=
es.
>>>
>>> Now i don't have any idea, how to workaround this problem, without
>>> shutdown this app :(
>>
>> I looked at your osd log again, and there are other things that don'=
t
>> look right. I'll also need you to turn on 'debug osd =3D 20' and 'de=
bug
>> filestore =3D 20'.
>
> osd.24 almost 10 minutes of log in debug, as above in attachment.
>
>> Other than that, I just pushed a workaround that might improve thing=
s.
>> It's on the wip-rgw-atomic-no-retry branch on github (based on
>> 0.42.2), so you might want to give it a spin and let us know whether
>> it actually improved things.
>
> Ok i will try, and let you know soon.

Unfortunately, no improvment after upgrade for this version.

Ningx reports growing time for radosgw backend, and after increase
this time to 33 seconds, changing into timeout.

10.177.8.11 - - - [05/Mar/2012:10:14:10 +0100] "PUT
/test/_x/sidebar2/_d/widgets/sym/button_bw.png HTTP/1.1" rlength: 1049
bsent: 232 rtime: 2.487 urtime: 2.485 status: 200 bbsent: 25 httpref:
"-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.12 - - - [05/Mar/2012:10:14:10 +0100] "PUT
/test/_x/sidebar2/_d/widgets/sym/button_bw.png?acl HTTP/1.1" rlength:
353 bsent: 157 rtime: 0.013 urtime: 0.013 status: 200 bbsent: 5
httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:13 +0100] "PUT
/test/_x/sidebar2/_d/widgets/newmail/list.png?acl HTTP/1.1" rlength:
352 bsent: 157 rtime: 0.006 urtime: 0.006 status: 200 bbsent: 5
httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:17 +0100] "PUT
/test/_x/sidebar2/_d/widgets/zumisearch/button.png?acl HTTP/1.1"
rlength: 357 bsent: 157 rtime: 0.006 urtime: 0.006 status: 200 bbsent:
5 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:21 +0100] "PUT
/test/_g/sidebar/_d/widgets/globaltime/city_point_green.gif HTTP/1.1"
rlength: 1297 bsent: 232 rtime: 13.427 urtime: 13.426 status: 200
bbsent: 25 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:26 +0100] "PUT
/test/_x/sidebar2/_d/widgets/zum/zumikombw.png HTTP/1.1" rlength: 4278
bsent: 232 rtime: 18.384 urtime: 18.383 status: 200 bbsent: 25
httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.12 - - - [05/Mar/2012:10:14:29 +0100] "PUT
/test/_x/sidebar2/_d/widgets/allegro/allegro.png HTTP/1.1" rlength:
4129 bsent: 232 rtime: 21.963 urtime: 21.962 status: 200 bbsent: 25
httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:32 +0100] "PUT
/test/_g/sidebar/_d/popover/mdcbtn.gif HTTP/1.1" rlength: 1532 bsent:
232 rtime: 25.105 urtime: 25.104 status: 200 bbsent: 25 httpref: "-"
useragent: "Boto/2.2.2 (linux2)"
10.177.8.12 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/40622%2Cserwisy.html HTTP/1.1" rlength: 18178 bsent: 232 rtime:
32.651 urtime: 32.648 status: 200 bbsent: 25 httpref: "-" useragent:
"Boto/2.2.2 (linux2)"
10.177.8.12 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/_x/sidebar/cssb/popover/btn-nrm.gif HTTP/1.1" rlength: 539
bsent: 25 rtime: 33.003 urtime: - status: 499 bbsent: 25 httpref: "-"
useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/DaneAjax%2CWiadomosciLokalne%2Cajax.json%3Fmiasto%3Dslask%26z%3D0=
%26v%3D201203051014
HTTP/1.1" rlength: 1572 bsent: 25 rtime: 33.002 urtime: - status: 499
bbsent: 25 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.12 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/37828%2Cserwisy.html HTTP/1.1" rlength: 18363 bsent: 25 rtime:
33.003 urtime: - status: 499 bbsent: 25 httpref: "-" useragent:
"Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/DaneAjax%2CWiadomosciLokalne%2Cajax.json%3Fmiasto%3Dpoznan%26z%3D=
0%26v%3D201203051014
HTTP/1.1" rlength: 1602 bsent: 25 rtime: 33.004 urtime: - status: 499
bbsent: 25 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/DaneAjax%2CWiadomosciLokalne%2Cajax.json%3Fmiasto%3Dbydgoszcz%26z=
%3D0%26v%3D201203051014
HTTP/1.1" rlength: 1738 bsent: 25 rtime: 33.005 urtime: - status: 499
bbsent: 25 httpref: "-" useragent: "Boto/2.2.2 (linux2)"
10.177.8.11 - - - [05/Mar/2012:10:14:40 +0100] "PUT
/test/_x/sidebar2/_d/widgets/sym/button.png HTTP/1.1" rlength: 1398
bsent: 25 rtime: 33.001 urtime: - status: 499 bbsent: 25 httpref: "-"
useragent: "Boto/2.2.2 (linux2)"

>
>>
>>
>>>
>>> Another question is, why data from radosgw writing almost everythin=
g
>>> only on one osd, and copies to 2 others, and only those. Is anyone =
can
>>> explain this to me ??
>>>
>>> /dev/sdu =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.18
>>> /dev/sdw =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
608M =C2=A0260G =C2=A0 1% /vol0/data/osd.21
>>> /dev/sdz =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
638M =C2=A0260G =C2=A0 1% /vol0/data/osd.24
>>> /dev/sde =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.3
>>> /dev/sdr =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.16
>>> /dev/sdaa =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 275G =C2=A0696M=
 =C2=A0260G =C2=A0 1% /vol0/data/osd.25
>>> /dev/sdp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.14
>>> /dev/sdd =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.2
>>> /dev/sdk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.8
>>> /dev/sdh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
608M =C2=A0260G =C2=A0 1% /vol0/data/osd.6
>>> /dev/sds =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.17
>>> /dev/sdf =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
638M =C2=A0260G =C2=A0 1% /vol0/data/osd.4
>>> /dev/sdj =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
637M =C2=A0260G =C2=A0 1% /vol0/data/osd.9
>>> /dev/sdc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
604M =C2=A0260G =C2=A0 1% /vol0/data/osd.1
>>> /dev/sdv =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
2.7G =C2=A0258G =C2=A0 2% /vol0/data/osd.20
>>> /dev/sdn =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
607M =C2=A0260G =C2=A0 1% /vol0/data/osd.12
>>> /dev/sdo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.13
>>> /dev/sdg =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.5
>>> /dev/sdy =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
633M =C2=A0260G =C2=A0 1% /vol0/data/osd.23
>>> /dev/sdm =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.11
>>> /dev/sdx =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.22
>>> /dev/sdb =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
608M =C2=A0260G =C2=A0 1% /vol0/data/osd.0
>>> /dev/sdq =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.15
>>> /dev/sdl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.10
>>> /dev/sdi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
605M =C2=A0260G =C2=A0 1% /vol0/data/osd.7
>>> /dev/sdt =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0275G =C2=A0=
604M =C2=A0260G =C2=A0 1% /vol0/data/osd.19
>>>
>> That's probably because you're overwriting the same object over and
>> over. When you do that the old object is still being kept so that an=
y
>> pending readers may complete reading it. You should run a maintenanc=
e
>> utility in order to remove those (radosgw-admin temp remove --date=3D=
=2E.
>> to remove all temp objects that were created before a specific date)=
=2E
>
> Nice, useful advice, thanks.
>
>>
>> Yehuda
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek Skowron



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
