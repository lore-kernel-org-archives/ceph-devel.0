From: Wido den Hollander <wido@42on.com>
Subject: Re: Proposal to rename ceph-qa-suite project in tracker.ceph.com
Date: Thu, 16 Feb 2017 23:00:06 +0100 (CET)
Message-ID: <1067332094.10199.1487282406614@ox.pcextreme.nl>
References: <d7e1ef80-56ad-63f9-cbf8-a4ef1ada8be8@suse.cz>
 <alpine.DEB.2.11.1702132224320.7782@piezo.novalocal>
 <CALe9h7cNKpPUq0iLk9UOj1tgXkSY7NKADCkaZibTY5Y4OR1ZhA@mail.gmail.com>
 <14347117-bd77-96af-950a-c3bea0b6df7d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:54284 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPWAK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 17:00:10 -0500
In-Reply-To: <14347117-bd77-96af-950a-c3bea0b6df7d@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <jspray@redhat.com>, Nathan Cutler <ncutler@suse.cz>
Cc: ceph-devel@vger.kernel.org


> Op 16 februari 2017 om 22:50 schreef Nathan Cutler <ncutler@suse.cz>:
> 
> 
> I haven't done anything on this yet, because it didn't quite feel right, 
> and today I realized what was missing - the "devops" project. What is 
> that for, and can it be merged with the "testing infrastructure" 
> project? I.e., do we need two?
> 
> And, while we're in "spring cleaning" mode/mood, what about the 
> "phprados" and "rados-java" projects?
> 

Well, they are not active in the tracker. On Github they receive a few PRs per year. So maybe enable Github issues for them and not use the tracker?

Wido

> On 02/14/2017 01:10 AM, John Spray wrote:
> > On Mon, Feb 13, 2017 at 10:25 PM, Sage Weil <sage@newdream.net> wrote:
> >> On Mon, 13 Feb 2017, Nathan Cutler wrote:
> >>> Now that ceph-qa-suite has been assimilated into ceph/ceph.git, shall we
> >>> rename http://tracker.ceph.com/projects/ceph-qa-suite ?
> >>>
> >>> If nobody objects, I'd like to rename it to "tests" so it would cover both
> >>> teuthology tests and make check tests.
> >>
> >> Go for it.  I'd say that many of the tests can actually go in the relevant
> >> projects directly, though; we can use 'tests' for the underlying
> >> infrastructure (like ceph.py, ceph_manager.py, an so on)?
> >
> > Yes -- for actual test cases we have the relevant category/component
> > fields within e.g. the 'fs' subproject.
> >
> > Maybe the rename should be to "test infrastructure" or something like
> > that, so that anyone looking at it doesn't think they're looking at
> > all test-related stuff.
> >
> > John
> >
> >>
> >> sage
> >>
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
