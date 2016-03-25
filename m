From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Fri, 25 Mar 2016 15:30:51 +0100
Message-ID: <CAOi1vP9u1FSE_xyckVLo3sNzALv1AdcsHdLnbPWvcsa+h8JY2A@mail.gmail.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local>
	<CACJqLyax9Nntz09qJF2E_jjtoVa2moJxzW5T42bHVFGLop31Ug@mail.gmail.com>
	<6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local>
	<alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
	<CAOi1vP8pDCbNej9a_5-THG_Dp70jG+_T6vzT36quBzsu4hiJgQ@mail.gmail.com>
	<CAJ4mKGbvi+RUxZUnK0HmQ8c886KUdiykXaqc7mZ=6E=TO7Jt8Q@mail.gmail.com>
	<alpine.DEB.2.11.1603250846500.26068@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36742 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbcCYOay (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 10:30:54 -0400
Received: by mail-lb0-f177.google.com with SMTP id qe11so48993742lbc.3
        for <ceph-devel@vger.kernel.org>; Fri, 25 Mar 2016 07:30:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603250846500.26068@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gfarnum@redhat.com>, "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Mar 25, 2016 at 1:54 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 24 Mar 2016, Gregory Farnum wrote:
>> On Thu, Mar 24, 2016 at 2:15 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
>> >
>> > Ultimately, this is about shrinking the time it takes for a MON to
>> > notice the "oops".  Do we expect those things to be common and frequent
>> > enough to justify an external daemon, however small and simple, on each
>> > OSD node?
>>
>> Let's not forget that extra daemons aren't free quite apart from
>> having to build them. There's a lot of user education to happen.
>> There's more stuff to install; we'll have extra cephx keys for them
>> that need to get placed; we need to update all our install and
>> management tools to set them up. We'll probably run into new kinds of
>> resource exhaustion, and we'll hit new errors around the local
>> communication setup. :/ I'm uneasy about creating *any* mechanism that
>> automatically marks down OSDs, but isn't directed by the OSD in
>> question.
>>
>> Plus, I think there are other benefits of annotating our asserts more
>> carefully. They're kind of a mess right now and if we were able to do
>> more than crash on disk errors, it'd be nice when we move on to
>> gathering statistics and things...
>
> Yep, I'm sold!  :)
>
> Going back to Igor's PR...
>
>         https://github.com/ceph/ceph/pull/7740
>
> I think perhaps the first thing to do is to make a function like
> Ilya suggested that is
>
>         ceph_abort_markmedown()
>
> and then sort out where/when to call it (instead of tackling signal
> handlers immediately).  It seems like the semantics need to be something
> like
>
>  - queue the markdown message for the mon
>  - wait for N seconds (where N=5 or so?)
>  - ceph_abort()

Is it to wait for the message to go out?  If so, maybe request
a MarkMeDown ack and have an N second Cond timeout?  Modidying
OSD::dispatch() or wiring it up through the service abstraction
shouldn't be hard - an ack would take a lot less than a second.

>
> There are maybe three call sites that come to mind that will probably
> catch most issues:
>
>  - the do_transaction (or equivalent) error code checks on write
>  - a new helper that wraps up the checks/asserts about getting EIO on read
>  - the internal heartbeat that goes off when a thread pool gets stuck
>
> What else?
>
> We could also go for an OSD signal handler, but it would have to be a
> best-effort sort of thing (obviuosly won't work if the messenger is
> busted), and it worries me a bit: what happens if there is a segv in the
> memory allocator, we try to stay alive longer so that we can send
> MarkMeDown, and as a result continue processing some IO but in the
> meantime let something corrupt reach disk or clients or otherwise get
> worse and propogate?

IMHO it's entirely unnecessary.  An "oops" assert should just abort() -
we are not the kernel, after all.

Thanks,

                Ilya
