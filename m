From: Christian Brunner <c.m.brunner@gmail.com>
Subject: Re: claims to be ... - wrong node!
Date: Mon, 15 Nov 2010 17:52:41 +0100
Message-ID: <AANLkTikfaRpW+M5YXG1+TRawFtjrfvUDrR=z7b2hCBFk@mail.gmail.com>
References: <AANLkTikN49QYMDw4WhatqtcQjBn_8cFsDfm+VPjyud0x@mail.gmail.com>
	<Pine.LNX.4.64.1011121005350.13140@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57988 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682Ab0KOQwn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Nov 2010 11:52:43 -0500
Received: by ywc21 with SMTP id 21so1789483ywc.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Nov 2010 08:52:43 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1011121005350.13140@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

I'm sorry I can't reproduce this at the moment, but I think I've found
the cause. Our servers have a second interface for administrative
purpose. When I disable this interface some other weired problems go
away, too.

Thanks for looking at this.

Christian

2010/11/12 Sage Weil <sage@newdream.net>:
> On Fri, 12 Nov 2010, Christian Brunner wrote:
>> Presumably I'm doing something wrong here, but I don't have clue wha=
t to...
>>
>> After restarting one of our osd-servers I get the following messages
>> in the cosd-log:
>>
>> 2010-11-12 10:24:31.965058 7f5bac380710 -- 10.255.0.60:6802/17175 >>
>> 10.255.0.60:6800/15859 pipe(0x7f5b98089300 sd=3D26 pgs=3D0 cs=3D0
>> l=3D0).connect claims to be 0.0.0.0:6800/17108 not
>> 10.255.0.60:6800/15859 - wrong node!
>> 2010-11-12 10:24:32.489423 7f5b955ea710 -- 10.255.0.60:6803/17175 >>
>> 10.255.0.60:6801/17108 pipe(0x7f5b98000d40 sd=3D30 pgs=3D0 cs=3D0
>> l=3D0).connect claims to be 0.0.0.0:6801/17108 not
>> 10.255.0.60:6801/17108 - presumably this is the same node!
>
> Hmm. =A0Some of these messages come up normally, but this sequence do=
esn't
> look quite right. =A0What usually happens is:
>
> B restarts.
> A's connection to B drops.
> A reconnects to B's old address, reaches the new B, and gets 'wrong n=
ode!'
> A gets a new osdmap with B's new address
> A connects to new B.
>
> What doesn't make sense to me here is that we then get 0.0.0.0:6801/1=
7108,
> because B doesn't yet know it's address. =A0But in fact B must, becau=
se it's
> address was published in the map.
>
> Is this reproducible? =A0Can you reproduce with
> =A0 =A0 =A0 =A0debug ms =3D 20
> =A0 =A0 =A0 =A0debug osd =3D 20
> on the OSD, and
> =A0 =A0 =A0 =A0debug mon =3D 20
> =A0 =A0 =A0 =A0debug ms =3D 1
> on the monitor, and send the logs from the mon and both OSDs?
>
> Thanks!
> sage
>
>
>>
>> The wrong node message is repeated a vew more times.
>>
>> After this every write to the osd seems to block. What is the right
>> way to handle this?
>>
>> Thanks,
>> Christian
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
