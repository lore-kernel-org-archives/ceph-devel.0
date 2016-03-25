From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph watchdog-like thing to reduce IO block during process goes
 down by abort()
Date: Fri, 25 Mar 2016 08:54:21 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603250846500.26068@cpach.fuggernut.com>
References: <27d3bfba39234f83b8441abc4e9aea92@R01UKEXCASM222.r01.fujitsu.local> <CACJqLyax9Nntz09qJF2E_jjtoVa2moJxzW5T42bHVFGLop31Ug@mail.gmail.com> <6845351a143d41a3932b37efddcc1f75@R01UKEXCASM222.r01.fujitsu.local> <alpine.DEB.2.11.1603241646390.18774@cpach.fuggernut.com>
 <CAOi1vP8pDCbNej9a_5-THG_Dp70jG+_T6vzT36quBzsu4hiJgQ@mail.gmail.com> <CAJ4mKGbvi+RUxZUnK0HmQ8c886KUdiykXaqc7mZ=6E=TO7Jt8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46431 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbcCYMyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 08:54:35 -0400
In-Reply-To: <CAJ4mKGbvi+RUxZUnK0HmQ8c886KUdiykXaqc7mZ=6E=TO7Jt8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 24 Mar 2016, Gregory Farnum wrote:
> On Thu, Mar 24, 2016 at 2:15 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > Ultimately, this is about shrinking the time it takes for a MON to
> > notice the "oops".  Do we expect those things to be common and frequent
> > enough to justify an external daemon, however small and simple, on each
> > OSD node?
> 
> Let's not forget that extra daemons aren't free quite apart from
> having to build them. There's a lot of user education to happen.
> There's more stuff to install; we'll have extra cephx keys for them
> that need to get placed; we need to update all our install and
> management tools to set them up. We'll probably run into new kinds of
> resource exhaustion, and we'll hit new errors around the local
> communication setup. :/ I'm uneasy about creating *any* mechanism that
> automatically marks down OSDs, but isn't directed by the OSD in
> question.
> 
> Plus, I think there are other benefits of annotating our asserts more
> carefully. They're kind of a mess right now and if we were able to do
> more than crash on disk errors, it'd be nice when we move on to
> gathering statistics and things...

Yep, I'm sold!  :)

Going back to Igor's PR...

	https://github.com/ceph/ceph/pull/7740

I think perhaps the first thing to do is to make a function like 
Ilya suggested that is

	ceph_abort_markmedown()

and then sort out where/when to call it (instead of tackling signal 
handlers immediately).  It seems like the semantics need to be something 
like

 - queue the markdown message for the mon
 - wait for N seconds (where N=5 or so?)
 - ceph_abort()

There are maybe three call sites that come to mind that will probably 
catch most issues:

 - the do_transaction (or equivalent) error code checks on write
 - a new helper that wraps up the checks/asserts about getting EIO on read
 - the internal heartbeat that goes off when a thread pool gets stuck

What else?

We could also go for an OSD signal handler, but it would have to be a 
best-effort sort of thing (obviuosly won't work if the messenger is 
busted), and it worries me a bit: what happens if there is a segv in the 
memory allocator, we try to stay alive longer so that we can send 
MarkMeDown, and as a result continue processing some IO but in the 
meantime let something corrupt reach disk or clients or otherwise get 
worse and propogate?

sage
