From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Random blocks when accessing rbd images
Date: Fri, 16 Dec 2011 13:17:02 -0800
Message-ID: <CACLRD_3pvKUmS+qtEPvQLi1hL71+4jUDMTT8mUaHpB8pYn09kQ@mail.gmail.com>
References: <1404301.on6okQVZ04@pc10>
	<4EEA1309.9030602@grnet.gr>
	<3807778.ycpoZxnZL4@pc10>
	<CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
	<4EEA2174.2060002@widodh.nl>
	<4EEA2299.6070601@tuxadero.com>
	<4EEA23F8.10209@tuxadero.com>
	<4EEB6F31.2050109@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47297 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760696Ab1LPVRE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 16:17:04 -0500
Received: by werm1 with SMTP id m1so611620wer.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 13:17:02 -0800 (PST)
In-Reply-To: <4EEB6F31.2050109@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In master, 061e7619aacf60a828e0ce84a108d5a0bea247c6 may fix the
problem.  If not, 5274e88d2cb8c0449a4ecd1ff0cf8bb0af2cfc97 includes
some asserts that may give us a clue as to how this is happening.
-Sam

On Fri, Dec 16, 2011 at 8:17 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
> Hi,
>
>
> On 12/15/2011 05:44 PM, Martin Mailand wrote:
>>
>> Hi,
>> at least there is a patch that should have fixed it.
>>
>> http://marc.info/?l=3Dceph-devel&m=3D131955913203561&w=3D2
>>
>
> I'm still seeing this one:
>
> 2011-12-16 17:14:53.638722 =C2=A0 =C2=A0pg v1170309: 7808 pgs: 7807 a=
ctive+clean, 1
> active+clean+scrubbing; 15279 MB data, 47262 MB used, 73838 GB / 7452=
0 GB
> avail
>
> In this case PG "2.688" is in scrubbing state and is staying that way=
=2E
>
> I'm running v0.39, not the latest master.
>
> Any suggestions to trace this one down?
>
> Wido
>
>
>> Am 15.12.2011 17:38, schrieb Martin Mailand:
>>>
>>> Hi Wido,
>>> but wasn't that fixed a few weeks ago?
>>>
>>> -martin
>>>
>>> Am 15.12.2011 17:33, schrieb Wido den Hollander:
>>>>
>>>> Yes, from what I've seen it will block indefinitely until you rest=
art
>>>> one of the OSDs who are member of the PG.
>>>>
>>>> Wido
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
