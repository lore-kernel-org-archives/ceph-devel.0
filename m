From: Sage Weil <sage@newdream.net>
Subject: Re: osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
Date: Wed, 16 Nov 2011 13:12:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111161311220.6368@cobra.newdream.net>
References: <4EC11FF2.1030109@tuxadero.com>
 <CAF3hT9BZh8cFy+weYxuRSH+B36mf0z18ai4whqtcfyCAUPAu1Q@mail.gmail.com>
 <4EC16FF1.1080002@tuxadero.com> <CAF3hT9AqayxNCSKNZ8TfYMhOhPk0uEmGNKjJz+TTYAGMHfK3Jw@mail.gmail.com>
 <Pine.LNX.4.64.1111141220460.29742@cobra.newdream.net> <4EC2F026.7000109@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59233 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1KPVMc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 16:12:32 -0500
In-Reply-To: <4EC2F026.7000109@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, ceph-devel@vger.kernel.org

Hi Martin,

I've reread the code twice now and it's really not clear to me how 
pending_ops could get out of sync with the actual queue size.  I've pushed 
a couple of patches that remove surrounding dead code and add an 
additional assert sanity check to master.    Have you seen this again, or 
just that once?

Opened http://tracker.newdream.net/issues/1727

Thanks-
sage


On Wed, 16 Nov 2011, Martin Mailand wrote:

> Hi,
> so after a little help from greg.
> 
> (gdb) print pending_ops
> $1 = 0
> 
> -martin
> 
> Sage Weil schrieb:
> > On Mon, 14 Nov 2011, Gregory Farnum wrote:
> > > It's not a big deal; logging is expensive. :) Just a backtrace isn't a
> > > lot to go on, but it's better than nothing!
> > > 
> > > On Mon, Nov 14, 2011 at 11:45 AM, Martin Mailand <martin@tuxadero.com>
> > > wrote:
> > > > Hi Gregory,
> > > > I do not have more at the moment. As I cannot have the debug log always
> > > > on,
> > > > a core dump would be the best solution?
> > 
> > I'm mainly interested in whether pending_ops is 0 or < 0.  A 'thread apply
> > all bt' may also be useful.
> > 
> > Thanks!
> > sage
> > 
> > 
> > > > -martin
> > > > 
> > > > Gregory Farnum schrieb:
> > > > > Do you have any other system state? (More logs, core dumps.)
> > > > > 
> > > > > Make a bug in the tracker either way so it doesn't get lost track of.
> > > > > :)
> > > > > -Greg
> > > > > 
> > > > > On Mon, Nov 14, 2011 at 6:04 AM, Martin Mailand <martin@tuxadero.com>
> > > > > wrote:
> > > > > > Hi,
> > > > > > today one of my ods died, the log is.
> > > > > > 
> > > > > > sd/OSD.cc: In function 'void OSD::dequeue_op(PG*)', in thread
> > > > > > '7faeb6139700'
> > > > > > osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
> > > > > >  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
> > > > > >  1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> > > > > >  2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> > > > > >  3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> > > > > >  4: (()+0x6d8c) [0x7faec4d12d8c]
> > > > > >  5: (clone()+0x6d) [0x7faec355404d]
> > > > > >  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
> > > > > >  1: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> > > > > >  2: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> > > > > >  3: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> > > > > >  4: (()+0x6d8c) [0x7faec4d12d8c]
> > > > > >  5: (clone()+0x6d) [0x7faec355404d]
> > > > > > *** Caught signal (Aborted) **
> > > > > >  in thread 7faeb6139700
> > > > > >  ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9)
> > > > > >  1: /usr/bin/ceph-osd() [0x5b8b52]
> > > > > >  2: (()+0xfc60) [0x7faec4d1bc60]
> > > > > >  3: (gsignal()+0x35) [0x7faec34a1d05]
> > > > > >  4: (abort()+0x186) [0x7faec34a5ab6]
> > > > > >  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d)
> > > > > > [0x7faec3d586dd]
> > > > > >  6: (()+0xb9926) [0x7faec3d56926]
> > > > > >  7: (()+0xb9953) [0x7faec3d56953]
> > > > > >  8: (()+0xb9a5e) [0x7faec3d56a5e]
> > > > > >  9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > > > const*)+0x396) [0x5bddb6]
> > > > > >  10: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> > > > > >  11: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> > > > > >  12: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> > > > > >  13: (()+0x6d8c) [0x7faec4d12d8c]
> > > > > >  14: (clone()+0x6d) [0x7faec355404d]
> > > > > > 
> > > > > > Anything else needed to debug this?
> > > > > > 
> > > > > > -martin
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > > ceph-devel" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
