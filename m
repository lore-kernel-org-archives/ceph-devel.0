From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: More questions about the thesis.
Date: Thu, 2 Feb 2012 18:43:56 -0800
Message-ID: <CAF3hT9A+2ccRwaa-2aURqDoPAaaoVX+OjeQxbbTjxnmqKaZcpA@mail.gmail.com>
References: <CALwGbPL=FuZDdnt7xnGVw7ygA0Zr0EwLDSqHnWj6z+KdCkzESQ@mail.gmail.com>
	<CAF3hT9CuiSt3a7GpYgk_mNxYExiioCeLfiZHVwBRgMTk9NifZw@mail.gmail.com>
	<CALwGbPKUg=RNZteL_782BR5n3Yqfj-V_9-RXjLBSsBc4oPCqVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45224 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2BCCn5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2012 21:43:57 -0500
Received: by iacb35 with SMTP id b35so4029948iac.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Feb 2012 18:43:57 -0800 (PST)
In-Reply-To: <CALwGbPKUg=RNZteL_782BR5n3Yqfj-V_9-RXjLBSsBc4oPCqVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Thu, Feb 2, 2012 at 5:35 PM, =E8=83=A1=E7=80=9A=E6=A3=AE <softrank.n=
et@gmail.com> wrote:
> Thanks a lot.
> But I still don't know what does the word "probabilistically" in the =
sentence.
>>>...thus defining a sequence of candidates for each replica rank that=
 are [[probabilistically]] independent of others' failures.
> That seems to be expressing that there is a chance to be independent,
> not 100% independent, and in some certain conditions they could be
> dependent. Am I right?
> If I'm right, what kind of situation can it be?

Sage can correct me if I'm wrong, but I think the use of
"probabilistically" there is more a reminder of the domain you're
working in than a word that changes the meaning. CRUSH is a
probabilistic algorithm and the choice of replacements is
probabilistically independent =E2=80=94 but that doesn't mean that the =
choice
of replacements for your storage replicas is necessarily independent
if there are physical failure correlations that aren't reflected in
your CRUSH model. Does that make sense?


> On Fri, Feb 3, 2012 at 3:43 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Thu, Feb 2, 2012 at 12:35 AM, =E8=83=A1=E7=80=9A=E6=A3=AE <softra=
nk.net@gmail.com> wrote:
>>> Hi everyone.
>>>
>>> I've received a nice and welcome response last time. Thank you. I'v=
e
>>> got some other questions this time.
>>>
>>> thesis can be found: http://www.ssrc.ucsc.edu/Papers/weil-sc06.pdf
>>>
>>> at page 4, chapter 3.2.2 Replica Ranks, under Figure 2.
>>>>>...thus defining a sequence of candidates for each replica rank th=
at are probabilistically independent of others' failures.
>>> Here, why "probabilistically" instead of "certainly"? and what's
>>> others' failure?
>>
>> The statement means that the sequence of replacement choices for
>> position 2 is independent of whether position 1 has failed =E2=80=94=
=C2=A0the
>> current node occupying position 1 isn't part of the function's input=
;
>> there isn't a roundabout way that it influences the input, etc.
>>
>>>>>...making it unweildly for parity schemes.
>>> Here, what does "unweildly" mean? is it "unwieldy" or something els=
e?
>>
>> Yep, that's a typo. It should say "unwieldy"! :)
>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
