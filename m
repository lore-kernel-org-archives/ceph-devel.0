From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 23:16:11 +0300
Message-ID: <20160819201610.GA7970@gmail.com>
References: <57B698D0.1050409@dachary.org>
 <20160819130529.GC17630@gmail.com>
 <57B708D0.4030109@dachary.org>
 <20160819140151.GD17630@gmail.com>
 <57B71B0D.1010202@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35112 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbcHSUQa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 16:16:30 -0400
Received: by mail-lf0-f48.google.com with SMTP id f93so40379587lfi.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2016 13:16:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57B71B0D.1010202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

Loic, I have created backport PRs:

https://github.com/ceph/ceph/pull/10797
https://github.com/ceph/ceph/pull/10798

It is not tested yet though. I will be able to start testing tomorrow.

On Fri, Aug 19, 2016 at 04:43:25PM +0200, Loic Dachary wrote:
> 
> 
> On 19/08/2016 16:01, Mykola Golub wrote:
> > "convert AioObjectRequest/AioObjectRead classes to templates" is a
> > part of this PR:
> > 
> > https://github.com/ceph/ceph/pull/10462
> > 
> > which fixes http://tracker.ceph.com/issues/16478 and was going to be
> > backported too:
> > 
> > http://tracker.ceph.com/issues/16903
> > 
> > I would prefer if we merged all necessary commits to resolve the
> > conflict. This would ease further backporting.
> 
> That makes sense.
> 
> > I can try to prepare a backport PR this weekend. 
> 
> It would be great, thank you !
> 
> > Do we have a deadline?
> 
> Not yet. Given this blocks a few rbd backports, it would be good to wait until it is resolved anyway.
> 
> Cheers
> 
> > On Fri, Aug 19, 2016 at 03:25:36PM +0200, Loic Dachary wrote:
> >> Hi Mykola,
> >>
> >> On 19/08/2016 15:05, Mykola Golub wrote:
> >>> Loic,
> >>>
> >>> I think this regression is highly desirable to be merged to jewel
> >>> before the release:
> >>>
> >>> http://tracker.ceph.com/issues/16654
> >>>
> >>> I have just merged Jason's PR to master.
> >>
> >> I created the backport and tried to cherry-pick but running into a conflict that is caused (I think) by the templatization
> >>
> >> librbd: convert AioObjectRequest/AioObjectRead classes to templates
> >>
> >> Should the templatization and all it entails be backported ? Or should the conflict be resolved by adapting the code to the non template jewel form ?
> >>
> >> Your help would be much appreciated in that matter and I assigned http://tracker.ceph.com/issues/17080#note-2 to you for that reason. If you don't have time to deal with this, please let me know and unassign yourself.
> >>
> >> Cheers
> >>
> >>>
> >>> On Fri, Aug 19, 2016 at 07:27:44AM +0200, Loic Dachary wrote:
> >>>> Hi Sage,
> >>>>
> >>>> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
> >>>> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
> >>>>
> >>>> Do you think it is time to cut the release and ask QE to start testing ?
> >>>>
> >>>> Cheers
> >>>>
> >>>> -- 
> >>>> Loïc Dachary, Artisan Logiciel Libre
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> -- 
> >> Loïc Dachary, Artisan Logiciel Libre
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Mykola Golub
