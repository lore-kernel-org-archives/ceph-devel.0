From: Haomai Wang <haomai@xsky.com>
Subject: Re: ceph encoding optimization
Date: Thu, 5 Nov 2015 01:29:51 +0800
Message-ID: <CACJqLyYOcRNa4xXj5FDB74XVtBZwN_TqoNzMXBdZV7HJB2DC3w@mail.gmail.com>
References: <CANE=7sURCs6VHCGAYMjXr2LMD7E6CfwqWkjYQopCOaQ-OzW65g@mail.gmail.com>
	<CAJ4mKGYeEHiVL+6V0BQFq4bcZU1nP9Q0YAd2_OkiP8ZR9h+9Jw@mail.gmail.com>
	<CANE=7sVGYGX1fPoHETWnXCBDtGEB2DivQVowor77CEKVtXH1Ew@mail.gmail.com>
	<34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0106.outbound.protection.outlook.com ([104.47.126.106]:3963
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756130AbbKDRpH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Nov 2015 12:45:07 -0500
Received: by wmff134 with SMTP id f134so47662508wmf.0
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2015 09:29:52 -0800 (PST)
In-Reply-To: <34ee94ce6bc34f318148d87490880bb3@R01UKEXCASM111.r01.fujitsu.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Cc: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 5, 2015 at 1:19 AM, Piotr.Dalek@ts.fujitsu.com
<Piotr.Dalek@ts.fujitsu.com> wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of ???
>> Sent: Wednesday, November 04, 2015 4:34 PM
>> To: Gregory Farnum
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: ceph encoding optimization
>>
>> I agree with pg_stat_t (and friends) is a good first start.
>> The eversion_t and utime_t are also good choice to start because the=
y are
>> used at many places.
>
> On Ceph Hackathon, Josh Durgin made initial steps in right direction =
in terms of pg_stat_t encoding and decoding optimization, with the endi=
anness-awareness thing left out. Even in that state, performance improv=
ements offered by this change were huge enough to make it worthwhile. I=
'm attaching the patch, but please note that this is prototype and base=
d on mid-August state of code, so you might need to take that into acco=
unt when applying the patch.

Cool, it's exactly we want to see.

>
>
> With best regards / Pozdrawiam
> Piotr Da=C5=82ek
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
