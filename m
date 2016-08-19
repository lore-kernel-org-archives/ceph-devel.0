From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 17:01:53 +0300
Message-ID: <20160819140151.GD17630@gmail.com>
References: <57B698D0.1050409@dachary.org>
 <20160819130529.GC17630@gmail.com>
 <57B708D0.4030109@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33256 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcHSOCQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 10:02:16 -0400
Received: by mail-lf0-f50.google.com with SMTP id b199so33694699lfe.0
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2016 07:01:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57B708D0.4030109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

"convert AioObjectRequest/AioObjectRead classes to templates" is a
part of this PR:

https://github.com/ceph/ceph/pull/10462

which fixes http://tracker.ceph.com/issues/16478 and was going to be
backported too:

http://tracker.ceph.com/issues/16903

I would prefer if we merged all necessary commits to resolve the
conflict. This would ease further backporting.

I can try to prepare a backport PR this weekend. Do we have a
deadline?

On Fri, Aug 19, 2016 at 03:25:36PM +0200, Loic Dachary wrote:
> Hi Mykola,
> 
> On 19/08/2016 15:05, Mykola Golub wrote:
> > Loic,
> > 
> > I think this regression is highly desirable to be merged to jewel
> > before the release:
> > 
> > http://tracker.ceph.com/issues/16654
> > 
> > I have just merged Jason's PR to master.
> 
> I created the backport and tried to cherry-pick but running into a conflict that is caused (I think) by the templatization
> 
> librbd: convert AioObjectRequest/AioObjectRead classes to templates
> 
> Should the templatization and all it entails be backported ? Or should the conflict be resolved by adapting the code to the non template jewel form ?
> 
> Your help would be much appreciated in that matter and I assigned http://tracker.ceph.com/issues/17080#note-2 to you for that reason. If you don't have time to deal with this, please let me know and unassign yourself.
> 
> Cheers
> 
> > 
> > On Fri, Aug 19, 2016 at 07:27:44AM +0200, Loic Dachary wrote:
> >> Hi Sage,
> >>
> >> Here are the issues that would be in jewel v10.2.3 if we decided to release it now: http://tracker.ceph.com/versions/518
> >> And here is the backport queue : http://tracker.ceph.com/projects/ceph/issues?query_id=96
> >>
> >> Do you think it is time to cut the release and ask QE to start testing ?
> >>
> >> Cheers
> >>
> >> -- 
> >> Loïc Dachary, Artisan Logiciel Libre
> >>
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
