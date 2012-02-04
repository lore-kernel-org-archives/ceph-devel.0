From: Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>
Subject: Re: [RFC PATCH 0/6] Understanding delays due to throttling under very
 heavy write load
Date: Fri, 3 Feb 2012 16:04:16 -0800
Message-ID: <CAC-hyiFDnhXTj7snXcjweNxyqMnXudScGqJFNkBAGgmh=J2JYw@mail.gmail.com>
References: <1328111668-10068-1-git-send-email-jaschut@sandia.gov>
	<CAF3hT9DV46n0TwWOVC0LsCdd921uus3kzQfPLuMNEATjpYzT3g@mail.gmail.com>
	<4F29CDAA.408@sandia.gov>
	<CAF3hT9BZEP_FWS=qt8ivA++aDpPGGFzuD_PtMcvDRS2aDEN+hw@mail.gmail.com>
	<4F2AABF5.6050803@sandia.gov>
	<CAF3hT9BNc4n4HBNEqsf+d6-Rjv7TC8nJ1VponJCBVpLB8=_F5Q@mail.gmail.com>
	<4F2ADEAE.8010403@sandia.gov>
	<CAF3hT9CFkxnWR4zoTRPtyGU5CbfV_PvL+=dqnvZcr7G0HBOb+w@mail.gmail.com>
	<4F2AF085.6000405@sandia.gov>
	<CAF3hT9AcxxNtscFczP8fShSsaBm_4zhLQZ2F5c7h1YswVaXHkA@mail.gmail.com>
	<4F2C08A7.2050507@sandia.gov>
	<3032884323297001561@unknownmsgid>
	<4F2C6EE6.4050008@sandia.gov>
	<CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43800 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab2BDAER convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 19:04:17 -0500
Received: by ggnh1 with SMTP id h1so2151571ggn.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Feb 2012 16:04:16 -0800 (PST)
In-Reply-To: <CAC-hyiHSNv_VgLcyVCrJ66HxTGFNBONrmmBddJk5326dLTKgkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

(resending to list)

On Fri, Feb 3, 2012 at 3:33 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>
> On 02/03/2012 10:06 AM, Gregory Farnum wrote:
>>
>> On Feb 3, 2012, at 8:18 AM, Jim Schutt<jaschut@sandia.gov> =A0wrote:
>>
>>> On 02/02/2012 05:28 PM, Gregory Farnum wrote:
>>>>
>>>> On Thu, Feb 2, 2012 at 12:22 PM, Jim Schutt<jaschut@sandia.gov> =A0=
 wrote:
>>>>>
>>>>> I found 0 instances of "waiting for commit" in all my OSD logs fo=
r my last
>>>>> run.
>>>>>
>>>>> So I never waited on the journal?
>>>>
>>>>
>>>> Looks like it. Interesting.
>>>>
>>>>
>>>>>>> So far I'm looking at two behaviours I've noticed that seem ano=
malous to
>>>>>>> me.
>>>>>>>
>>>>>>> One is that I instrumented ms_dispatch(), and I see it take
>>>>>>> a half-second or more several hundred times, out of several
>>>>>>> thousand messages. =A0Is that expected?
>>>>>>
>>>>>>
>>>>>>
>>>>>> How did you instrument it? If you wrapped the whole function it'=
s
>>>>>> possible that those longer runs are actually chewing through sev=
eral
>>>>>> messages that had to get waitlisted for some reason previously.
>>>>>> (That's the call to do_waiters().)
>>>>>
>>>>>
>>>>>
>>>>> Yep, I wrapped the whole function, and also instrumented taking o=
sd_lock
>>>>> while I was there. =A0About half the time that ms_dispatch() take=
s more than
>>>>> 0.5 seconds, taking osd_lock is responsible for the delay. =A0The=
re's two
>>>>> dispatch threads, one for ops and one for rep_ops, right? =A0So o=
ne's
>>>>> waiting on the other?
>>>>
>>>>
>>>> There's just one main dispatcher; no split for the ops and rep_ops=
 .
>>>> The reason for that "dispatch_running" is that if there are reques=
ts
>>>> waiting then the tick() function will run through them if the
>>>> messenger dispatch thread is currently idle.
>>>> But it is possible for the Messenger to try and dispatch, and for =
that
>>>> to be blocked while some amount of (usually trivial) work is being
>>>> done by a different thread, yes. I don't think we've ever observed=
 it
>>>> being a problem for anything other than updating OSD maps, though.=
=2E.
>>>
>>>
>>> Ah, OK.
>>>
>>> I guess I was confused by my log output, e.g.:
>>
>>
>> D'oh. Sorry, you confused me with your reference to repops, which
>> aren't special-cased or anything. But there are two messengers on th=
e
>> OSD, each with their own dispatch thread. One of those messengers is
>> for clients and one is for other OSDs.
>>
>> And now that you point that out, I wonder if the problem is lack of
>> Cond signaling in ms_dispatch. I'm on my phone right now but I belie=
ve
>> there's a chunk of commented-out code (why commented instead of
>> deleted? I don't know) that we want to uncomment for reasons that wi=
ll
>> become clear when you look at it. :)
>> Try that and see how many of your problems disappear?
>>
>
> So I cherry-picked Sage's commit 7641a0e171f onto the code
> I've been running (1fe75ee6419 + some debug stuff), and saw
> no obvious difference in behaviour.
>
> I also tested Sage's suggestion of separating journals and
> data, by putting two journal partitions on half my disks,
> and two data partitions on the other half. =A0I made the data
> partitions relatively small (~200 GiB each on a 1 TiB drive)
> to minimize the effect of inner vs. outer tracks.
>
> That didn't seem to help either.
>

You can try running 'iostat -t -kx -d 1' on the osds, and see whether
%util reaches 100%, and when it happens whether it's due to number of
io operations that are thrashing, or whether it's due to high amount
of data.
=46WIW, you may try setting =A0'filestore flusher =3D false', and set
/proc/sys/vm/dirty_background_ratio' to a small number (e.g., 1M).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
