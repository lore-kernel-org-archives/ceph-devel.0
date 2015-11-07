From: Haomai Wang <haomai@xsky.com>
Subject: Re: ceph encoding optimization
Date: Sat, 7 Nov 2015 21:40:15 +0800
Message-ID: <CACJqLyZdBw_xVoXUfqoKYdrQj3606EWBRowzDdyP0DqWLG7KZg@mail.gmail.com>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
	<CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
	<34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
	<CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0130.outbound.protection.outlook.com ([104.47.126.130]:9376
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753199AbbKGNkd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Nov 2015 08:40:33 -0500
Received: by oiww189 with SMTP id w189so56023947oiw.3
        for <ceph-devel@vger.kernel.org>; Sat, 07 Nov 2015 05:40:15 -0800 (PST)
In-Reply-To: <CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Cc: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi sage,

Could we know about your progress to refactor MSubOP and hobject_t,
pg_stat_t decode problem?

We could work on this based on your work if any.


On Thu, Nov 5, 2015 at 1:29 AM, Haomai Wang <haomai@xsky.com> wrote:
> On Thu, Nov 5, 2015 at 1:19 AM, Piotr.Dalek@ts.fujitsu.com
> <Piotr.Dalek@ts.fujitsu.com> wrote:
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of ???
>>> Sent: Wednesday, November 04, 2015 4:34 PM
>>> To: Gregory Farnum
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: ceph encoding optimization
>>>
>>> I agree with pg_stat_t (and friends) is a good first start.
>>> The eversion_t and utime_t are also good choice to start because th=
ey are
>>> used at many places.
>>
>> On Ceph Hackathon, Josh Durgin made initial steps in right direction=
 in terms of pg_stat_t encoding and decoding optimization, with the end=
ianness-awareness thing left out. Even in that state, performance impro=
vements offered by this change were huge enough to make it worthwhile. =
I'm attaching the patch, but please note that this is prototype and bas=
ed on mid-August state of code, so you might need to take that into acc=
ount when applying the patch.
>
> Cool, it's exactly we want to see.
>
>>
>>
>> With best regards / Pozdrawiam
>> Piotr Da=C5=82ek
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
