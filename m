From: Sage Weil <sage@newdream.net>
Subject: Re: ceph v10.2.4 QE validation status
Date: Wed, 30 Nov 2016 16:57:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611301656070.2097@piezo.novalocal>
References: <CAMMFjmEkMUBCnZFqMr_kcfZgB5jm3CjVNfXpSAXT7ZCwMLQEfg@mail.gmail.com> <CAMMFjmGRO7F30WwU8NwMU=t3bEXEhz1G6bwZwqyQJrp7mceZdQ@mail.gmail.com> <87r362tr92.fsf@suse.com> <alpine.DEB.2.11.1611231441130.21102@piezo.us.to> <87mvgia7if.fsf@suse.com>
 <87zikh3tj3.fsf@suse.com> <alpine.DEB.2.11.1611301601010.2097@piezo.novalocal> <87y4013pmw.fsf@suse.com> <87vav53p8u.fsf@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-429468212-1480525031=:2097"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34515 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbcK3Q5N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Nov 2016 11:57:13 -0500
In-Reply-To: <87vav53p8u.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Dachary, Loic" <loic@dachary.org>, "Dillaman, Jason" <dillaman@redhat.com>, Nathan Cutler <ncutler@suse.cz>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>, Yuri Weinstein <yweinste@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-429468212-1480525031=:2097
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 30 Nov 2016, Abhishek L wrote:
> Abhishek L writes:
> 
> > Sage Weil writes:
> >
> >> On Wed, 30 Nov 2016, Abhishek L wrote:
> >>>
> >>> Abhishek L writes:
> >>>
> >>> > Sage Weil writes:
> >>> >
> >>> >> On Wed, 23 Nov 2016, Abhishek L wrote:
> >>> >>>
> >>> >>> Hi Sage, Greg,
> >>> >>>
> >>> >>>
> >>> >>> Yuri Weinstein writes:
> >>> >>>
> >>> >>> > See updated status - http://tracker.ceph.com/issues/17487#note-32
> >>> >>> >
> >>> >>> > Outstanding issues:
> >>> >>> >
> >>> >>> > knfs - http://tracker.ceph.com/issues/16397 (same as in v10.2.3, Greg
> >>> >>> > pls review/approve, assumed Approved ?)
> >>> >>> >
> >>> >>> > upgrade/hammer-x (jewel) - http://tracker.ceph.com/issues/17847 ((Sage
> >>> >>> > pls review/approve, seems persistent, but maybe not a showstopper)
> >>> >>> >
> >>> >>> > upgrade/infernalis-x (jewel) - deprecated (Nathan is still working
> >>> >>> > to make it pass, see issues in the tacker summary above)
> >>> >>> >
> >>> >>> > Sage, jewel 10.2.4 can be released as soon as you agree with the
> >>> >>> > findings/summary.
> >>> >>>
> >>> >>> Do you think we're ready to release 10.2.4 yet?
> >>> >>
> >>> >> I'm reproducing http://tracker.ceph.com/issues/17847 with logs to make
> >>> >> sure this isn't a regression.
> >>> >>
> >>> >> We can ignore the infernalis runs.
> >>> >>
> >>> >> I think we can ignore the knfs selinux issue too.. Greg, can you confirm?
> >>> >>
> >>> > Added the prs 12001 & 12167 on top of the jewel branch and scheduled rados runs
> >>> > at
> >>> > http://pulpito.ceph.com/abhi-2016-11-29_10:22:25-rados-wip-jewel-10-2-4-distro-basic-smithi/ &
> >>
> >> https://github.com/ceph/ceph-qa-suite/pull/1292
> >>
> >> avoids xenial for the rados upgrade tests (in jewel branch).
> 
> Ah alright, maybe this was the cause after all, let's get this in (or
> push a branch to ceph-qa-suite so that I can schedule against that)

I added a patch for the client-upgrade tests to the same branch. You 
should be able to just schedule with --suite-branch jewel-avoid-xenial 
instead of --suite-branch jewel (for both rados and 
upgrade/client-upgrade).

sage


> >>
> >> The upgrade tests already explicitly call out trusty, so they should be
> >> fine.
> >>
> >>> > updated the tracker at http://tracker.ceph.com/issues/17851#note-17,
> >>> > with details of the test. I'll update the progress once the suite goes
> >>> > through
> >>>
> >>> Had around 11 tests fail from 296 scheduled, there were a couple of
> >>> valgrind issues on ceph-mon (which were seen at earlier runs on jewel as
> >>> well) and an s3test failure, rest of the issues were looking related to
> >>> infrastructure as they were failing to get specific version numbers from
> >>> gitbuilders.
> >>>
> >>> Reported this issue as:
> >>>
> >>> http://tracker.ceph.com/issues/18089
> >>>
> >>> subsequent re runs are still failing with similar errors. The details
> >>> are updated at
> >>>
> >>> http://tracker.ceph.com/issues/17487#note-37
> >>>
> >>> The upgrade suite has also failed with similar errors.
> >>
> >> Which one?
> > The upgrade/client-upgrade suite (I hope this is the right upgrade
> > suite), the errors are the same failed to fetch package version errors
> > seen for the rados suite, so not actual test run errors yet.
> >
> > http://pulpito.ceph.com/abhi-2016-11-30_09:58:50-upgrade:client-upgrade-wip-jewel-10-2-4-distro-basic-smithi/
> > is the run
> >
> > Best,
> > Abhishek
> 
> 
> --
> Abhishek Lekshmanan
> SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-429468212-1480525031=:2097--
