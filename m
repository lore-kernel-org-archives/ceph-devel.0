From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Two questions
Date: Thu, 28 Jul 2011 11:43:28 +0200
Message-ID: <CAMwB3ThOv4dU_PyCY-rsO47kM6953or8CSRGP8UiMSciCHPNOw@mail.gmail.com>
References: <8685614628192678277@unknownmsgid>
	<Pine.LNX.4.64.1107270854580.23984@cobra.newdream.net>
	<680021437521473788@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44698 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab1G1Jn3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 05:43:29 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1101881fxh.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 02:43:28 -0700 (PDT)
In-Reply-To: <680021437521473788@unknownmsgid>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2011/7/28 S=C5=82awomir Skowron <szibis@gmail.com>:
> Dnia 27 lip 2011 o godz. 17:52 Sage Weil <sage@newdream.net> napisa=C5=
=82(a):
>
>> On Wed, 27 Jul 2011, S?awomir Skowron wrote:
>>> Hello. I have some questions.
>>>
>>> 1. Is there any chance to change default 4MB object size to for
>>> example 1MB or less ??
>>
>> Yeah. =C2=A0You can use the cephfs to set the default layout on the =
root
>> directory, which will apply to any new files. =C2=A0See 'man cephfs'=
=2E
>
> Ok. Thanks.
>
>>> 2. I have create cluster of two mons, and 32 osd (1TB each) on two
>>> machines. At this radosgw with apache2 for test. When i putting dat=
a
>>> from s3 client to rados, everything is ok, but when one of osd is
>>> going down all s3 clients going to be freeze for some seconds, befo=
re
>>> ceph sign this osd as down, and then everything is starting working
>>> again wit degraded osd. How can i tune this marking as a down for m=
s
>>> or 0 :) and not for seconds freeze ??
>>
>> The 'osd heartbeat grace' defualt is 20. =C2=A0Stick something like
>>
>> =C2=A0 =C2=A0osd heartbeat grace =3D 5
>>
>> in the [osd] section of your ceph.conf
>
> Thanks, i will check this in work.

It works perfect thanks a lot

>
>> sage
>>
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
