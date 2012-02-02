From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: More questions about the thesis.
Date: Thu, 2 Feb 2012 11:43:00 -0800
Message-ID: <CAF3hT9CuiSt3a7GpYgk_mNxYExiioCeLfiZHVwBRgMTk9NifZw@mail.gmail.com>
References: <CALwGbPL=FuZDdnt7xnGVw7ygA0Zr0EwLDSqHnWj6z+KdCkzESQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34090 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932573Ab2BBTnB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 14:43:01 -0500
Received: by ggnh1 with SMTP id h1so1456651ggn.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 11:43:00 -0800 (PST)
In-Reply-To: <CALwGbPL=FuZDdnt7xnGVw7ygA0Zr0EwLDSqHnWj6z+KdCkzESQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 2, 2012 at 12:35 AM, =E8=83=A1=E7=80=9A=E6=A3=AE <softrank.=
net@gmail.com> wrote:
> Hi everyone.
>
> I've received a nice and welcome response last time. Thank you. I've
> got some other questions this time.
>
> thesis can be found: http://www.ssrc.ucsc.edu/Papers/weil-sc06.pdf
>
> at page 4, chapter 3.2.2 Replica Ranks, under Figure 2.
>>>...thus defining a sequence of candidates for each replica rank that=
 are probabilistically independent of others' failures.
> Here, why "probabilistically" instead of "certainly"? and what's
> others' failure?

The statement means that the sequence of replacement choices for
position 2 is independent of whether position 1 has failed =E2=80=94=C2=
=A0the
current node occupying position 1 isn't part of the function's input;
there isn't a roundabout way that it influences the input, etc.

>>>...making it unweildly for parity schemes.
> Here, what does "unweildly" mean? is it "unwieldy" or something else?

Yep, that's a typo. It should say "unwieldy"! :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
