From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ubuntu 12.04 MDS tcmalloc leaks
Date: Mon, 23 Jun 2014 15:44:46 -0400
Message-ID: <CAPYLRziLYF19aamv9S3UOwrve3=5fPxbu5Er492tSHmmS2iToA@mail.gmail.com>
References: <CANP1eJGaoj6SAcMMMHGZNkZOtX5gP7sGMWXXo5Bxbzhw6DKBuw@mail.gmail.com>
	<CAPYLRzgw479qtXxuz1+==vQf9B=nqri643wh0p5WooqCVWFm6g@mail.gmail.com>
	<CANP1eJENCjmkwM-bCube2WeLWgsg6+U56z1naP3-SH-=mowHcw@mail.gmail.com>
	<CAPYLRzi0ZNWjofAhjofy0F6fQqmwQrn+0g2N0yMSH=WuanXAAw@mail.gmail.com>
	<CANP1eJF+e-ro+PVTTz1dwxuNc0ZVawwM_mtPMsBajgfcm5RUyw@mail.gmail.com>
	<CANP1eJFKftGOe5muSczfkKOACUGw5A0FZqj68Pr1tDPzuD0mrg@mail.gmail.com>
	<CAPYLRzjc3sXd4Q8jYGDGW8Nv-dvaMSiS8qW3hw+nO91pKzS9pQ@mail.gmail.com>
	<CANP1eJH74EeAFMXPZZzBwE+s9xe8zxmci2SwwXOvnJ07OHsiqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34837 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945AbaFWTor (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jun 2014 15:44:47 -0400
Received: by mail-qg0-f41.google.com with SMTP id i50so6416511qgf.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jun 2014 12:44:46 -0700 (PDT)
In-Reply-To: <CANP1eJH74EeAFMXPZZzBwE+s9xe8zxmci2SwwXOvnJ07OHsiqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Franklin Cheung <franklin.cheung@adfin.com>, Benjamin <bpflanz@adfin.com>

Okay, this might just be as simple as us creating a new root inode
without deallocating the old one (MDS::open_root_inode, called from
MDS::boot_start). Can you create a ticket?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Mon, Jun 23, 2014 at 3:31 PM, Milosz Tanski <milosz@adfin.com> wrote:
> standby-replay
>
> On Mon, Jun 23, 2014 at 3:27 PM, Gregory Farnum <greg@inktank.com> wrote:
>> Ah, excellent. What standby modes are you using?
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>
>> On Mon, Jun 23, 2014 at 2:54 PM, Milosz Tanski <milosz@adfin.com> wrote:
>>> I've spent more time looking at this over the long time frame (since my last
>>> email in April) and I think I'm closer to understanding to what's going on
>>> here. I believe I was wrong in my original assumption that this is caused by
>>> tcmalloc since I tried this without tcmalloc (using glibc) and I was still
>>> exhibiting behavior.
>>>
>>> Having said that I think came onto a suggestion what might be wrong. When
>>> doing a version upgrade my MDS server primary / standby have switched... and
>>> now the other mds sever that was never running into MDS OOM scenarios has
>>> started going it and the one that was having the issue stopped. I ended up
>>> swapping the standby a couple times and it looks like it's the standby code
>>> that's causing this leak.
>>>
>>> TL;DR Standby is the one the leak... not sure what it is, but the primary
>>> doesn't exhibit this behavior.
>>>
>>> Best
>>> - Milosz
>>>
>>>
>>> On Mon, Apr 14, 2014 at 3:11 PM, Milosz Tanski <milosz@adfin.com> wrote:
>>>>
>>>> Sorry for not including the last on last email. It was an accident.
>>>>
>>>> On Fri, Apr 11, 2014 at 6:23 PM, Gregory Farnum <greg@inktank.com> wrote:
>>>> > On Fri, Apr 11, 2014 at 11:07 AM, Milosz Tanski <milosz@adfin.com>
>>>> > wrote:
>>>> >> On Fri, Apr 11, 2014 at 1:07 PM, Gregory Farnum <greg@inktank.com>
>>>> >> wrote:
>>>> >>> On Fri, Apr 11, 2014 at 8:59 AM, Milosz Tanski <milosz@adfin.com>
>>>> >>> wrote:
>>>> >>>> I'd like to restart this debate about tcmalloc slow leaks in MDS.
>>>> >>>> This
>>>> >>>> time around I have some charts. Looking at OSDs and MONs, it doesn't
>>>> >>>> seam to affect those (as much).
>>>> >>>>
>>>> >>>> Here's the chart: http://i.imgur.com/xMCINAD.png The first two humps
>>>> >>>> are the latest stable MDS version with tcmalloc till MDS gets killed
>>>> >>>> by the OOM killer. The last restart MDS build of the same git tag
>>>> >>>> without tcmalloc linked into it.
>>>> >>>
>>>> >>> That's interesting, but your graph cuts off before we can really see
>>>> >>> the long-term behavior of the no-tcmalloc case. :) What's the
>>>> >>> longer-term pattern look like?
>>>> >>
>>>> >> I'm only about two weeks into running without the allocator. I'm going
>>>> >> to continue running it and report back in two weeks and a month. Sadly
>>>> >> it takes a long time to test / reproduce the issue.
>>>> >
>>>> > Hmm, that makes it sound to me like it's not a tcmalloc issue, but
>>>> > something changing in MDS state (a new workload that loads too much
>>>> > into memory or something).
>>>>
>>>> 13 days into last startup so far and the needle hasn't move on memory
>>>> usage (stable since 3 days in). Previously it took 20 days (twice in a
>>>> row) to get to OOM. But by now it would have grown much larger. The
>>>> workload hasn't changed.
>>>>
>>>> >
>>>> >>>> I know that older tcmalloc version have leaks when allocating larger
>>>> >>>> blocks of memory:
>>>> >>>> https://code.google.com/p/gperftools/issues/detail?id=368 So it's
>>>> >>>> possible that there is some kind of allocation pattern in MDS that
>>>> >>>> causes this behavior or exposes this tcmalloc bug.
>>>> >>>
>>>> >>> Hrm, we do use memory pools in the MDS that the OSD and monitor do
>>>> >>> not, so that could be influencing things.
>>>> >>
>>>> >> The issue I linked to is caused generally by making large allocations.
>>>> >> It's my understanding that prior to the fix was very bad
>>>> >> fragmenetation with large allocations.
>>>> >>
>>>> >>>
>>>> >>>> Last time I bought it up there was resistance to tossing tcmalloc,
>>>> >>>> which is fine. What I'd like to see is not linking against tcmalloc
>>>> >>>> on
>>>> >>>> systems that are know to have a buggy tcmalloc (in this case ubuntu
>>>> >>>> 12.04, older Debian systems).
>>>> >>>
>>>> >>> The issue is that back when we did the investigation and testing (on
>>>> >>> older Debian systems) that made us switch to tcmalloc:
>>>> >>> 1) Memory growth without tcmalloc on the OSDs and monitor was so bad
>>>> >>> as to make them essentially unusable,
>>>> >>> 2) the MDS also behaved better with it (though I don't remember how
>>>> >>> much)
>>>> >>> 3) tcmalloc supplies some really nice memory analysis tools that I'd
>>>> >>> like to keep around.
>>>> >>>
>>>> >>> So we'd need to do something like find a different allocator that
>>>> >>> works for all three processes, or link the OSD and monitor with it but
>>>> >>> not the MDS *and* demonstrate that the default allocators in each of
>>>> >>> our platforms work for the MDS without issue (or go down the rat's
>>>> >>> nest of selecting allocator based on platform). Before we embark on
>>>> >>> that I'd like to get more data about what's causing the memory growth.
>>>> >>> Can you gather some heap dumps and stats? Have you tried just
>>>> >>> instructing the MDS to release unused memory when it passes some
>>>> >>> threshold?
>>>> >>
>>>> >> For another internal project we started off with tcmalloc and switched
>>>> >> to jemalloc. We ran into the same kind of pattern with tcmalloc on
>>>> >> ubuntu 12.04.
>>>> >>
>>>> >> Now in our case doing database equivalent of sorting 10s to low 100s
>>>> >> of gigabytes in background process (maintenance jobs for compacting
>>>> >> and dup removal) we did this in blocks of 0.25g using merge sort.
>>>> >> After about a day of runtime (when a lot of these jobs ran) we would
>>>> >> start running into OOM cases. I enabled the tcmalloc debugger (via
>>>> >> flags) and it would log every 1gb allocated. Tcmalloc reported that
>>>> >> the app was using low gigabytes of working memory during busy times
>>>> >> and and going into the low 10s of megabytes at idle times. Yet despite
>>>> >> those the memory consumed by the process was reaching 40 gigs.
>>>> >
>>>> > Did you try using the HeapRelease() command (or whatever it's called)?
>>>> > A few users have reported that tcmalloc was broken in one way or
>>>> > another on their platform (though usually on something like Gentoo
>>>> > rather than Ubuntu Precise!) and that call has invariably dealt with
>>>> > the issue. *shrug*
>>>>
>>>> For our use case I did end up playing with the various configuration
>>>> knobs for TCMALLOC (via environmental variables.) None of them ended
>>>> up helping (release rate, etc). We did not end up calling the tcmalloc
>>>> functions directly (like HeapRelease) because we didn't want to have
>>>> our app depend on tcmalloc. And, quite frankly I thought it was silly
>>>> for us to jump through a lot of hoops in order to make the allocator
>>>> not explode.
>>>>
>>>> >
>>>> >> We considered building tcmalloc from source, but noticed that redis in
>>>> >> ubuntu/debian jemalloc and switched to using it. In this case, yes I'm
>>>> >> shilling for jemalloc because it solved similar issues with
>>>> >> experienced. And after doing significant testing on performance to
>>>> >> compare the two it was within margin of error. Recent version of
>>>> >> jemalloc support can output heap profiling information in a format
>>>> >> understood by pprof (the google perftools).
>>>> >
>>>> > Interesting. Next time we wrangle some time to look at these issues
>>>> > I'll check jemalloc out.
>>>> > -Greg
>>>> > Software Engineer #42 @ http://inktank.com | http://ceph.com
>>>>
>>>>
>>>>
>>>> --
>>>> Milosz Tanski
>>>> CTO
>>>> 10 East 53rd Street, 37th floor
>>>> New York, NY 10022
>>>>
>>>> p: 646-253-9055
>>>> e: milosz@adfin.com
>>>
>>>
>>>
>>>
>>> --
>>> Milosz Tanski
>>> CTO
>>> 16 East 34th Street, 15th floor
>>> New York, NY 10016
>>>
>>> p: 646-253-9055
>>> e: milosz@adfin.com
>
>
>
> --
> Milosz Tanski
> CTO
> 16 East 34th Street, 15th floor
> New York, NY 10016
>
> p: 646-253-9055
> e: milosz@adfin.com
