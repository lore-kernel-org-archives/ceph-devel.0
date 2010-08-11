From: Christian Brunner <chb@muc.de>
Subject: Re: cosd dying after start
Date: Wed, 11 Aug 2010 22:07:57 +0200
Message-ID: <AANLkTi=rYmFBg=SR-XBeCqu2V67tH9Fw1g7H3Rq7TE4V@mail.gmail.com>
References: <AANLkTi=zkYni8xgp5aMQ6Q52RmDnu3eAqZ-8-DO-_6n_@mail.gmail.com>
	<AANLkTi=_kCreuSdkywt2xgcPrHebR6tBODvNnguhXFrU@mail.gmail.com>
	<Pine.LNX.4.64.1008101358280.9792@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63028 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557Ab0HKUH7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Aug 2010 16:07:59 -0400
Received: by wwj40 with SMTP id 40so554048wwj.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Aug 2010 13:07:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1008101358280.9792@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

2010/8/10 Sage Weil <sage@newdream.net>:
> On Tue, 10 Aug 2010, Christian Brunner wrote:
>
>> After a bit more debuging I've found out that there seems to be a fi=
le
>> missing from the filestore:
>>
>> 10.08.10_18:14:07.862190 7f568d3e5710 filestore(/ceph/osd/osd02)
>> getattr /ceph/osd/osd02/current/3.f2_head/rb.0.1d6.00000000000e_head
>> '_' =3D -2
>
> There was a bug last week in the kernel client rbd branch that was
> improperly encoding osd write operation payloads. =A0Can you check th=
at your
> rbd client is running 79c49720, which fixes it?

I'm not using the kernel client. - The problem started after a crash
of the cosd. If you want me to, I can try to analyse the coredump.

> That error above was probably just because that object hadn't been wr=
itten
> yet, and isn't a fatal error. =A0There is a 'scrub' function that ver=
ifies
> that most of the osd metadata is in order and replication is accurate=
:
> 'ceph osd scrub <osdnum>' and watch 'ceph -w' to see the success or e=
rror
> messages go by for each pg (or tail $mon_data/log on any monitor)

I was not able to start the osd, so the scrub didn't run either. Every
time I tried to start it, it died with the message
"terminate called after throwing an instance of
'ceph::buffer::end_of_buffer*'" after 3 seconds.

The only thing that worked was to set up a whole new filesystem.

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
