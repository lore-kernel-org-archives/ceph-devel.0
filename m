From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Two questions
Date: Wed, 27 Jul 2011 12:19:16 +0200
Message-ID: <CAMwB3Ti66BpfdfwPx3XgmVQv2GAQ_Gc2beHRc6pBcWwphf_bhQ@mail.gmail.com>
References: <8685614628192678277@unknownmsgid>
	<1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46297 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1G0KTS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jul 2011 06:19:18 -0400
Received: by fxd18 with SMTP id 18so241667fxd.11
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jul 2011 03:19:17 -0700 (PDT)
In-Reply-To: <1311750865.2751.4.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks.

2011/7/27 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Wed, 2011-07-27 at 07:58 +0200, S=C5=82awomir Skowron wrote:
>> Hello. I have some questions.
>>
>> 1. Is there any chance to change default 4MB object size to for
>> example 1MB or less ??
>
> If you are using the filesystem, you can change the stripe-size per
> directory with the "cephfs" tool.

Unfortunately i only use rados layer in this case, and i even don't
have any mds :) is there any chance to change this in rados layer ??

>>
>> 2. I have create cluster of two mons, and 32 osd (1TB each) on two
>> machines. At this radosgw with apache2 for test. When i putting data
>> from s3 client to rados, everything is ok, but when one of osd is
>> going down all s3 clients going to be freeze for some seconds, befor=
e
>> ceph sign this osd as down, and then everything is starting working
>> again wit degraded osd. How can i tune this marking as a down for ms
>> or 0 :) and not for seconds freeze ??
>
> Normally a OSD should be down within about 10 seconds and shouldn't
> affect all I/O operations.
>
> By default it takes 300 seconds before a OSD gets marked as "out", th=
is
> is handled by "mon osd down out interval"
>
> If you want to change the "down" reporting behaviour you could do thi=
s
> with "osd min down reporters" and "osd min down reports". I'm not sur=
e
> you really want to do this, as the default values should be ok.

Ok. I will check this.

> Wido
>
>>
>> My setup is debian 6.0, kernel 2.6.37.6 =C2=A0x86_64 and ceph versio=
n
>> 0.31-10 from stable repo.
>>
>> Best regards
>>
>> Slawomir Skowron
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
>
>

--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
