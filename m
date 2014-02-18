From: Sage Weil <sage@inktank.com>
Subject: Re: chef cookbooks
Date: Tue, 18 Feb 2014 07:58:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402180757560.15052@cobra.newdream.net>
References: <alpine.DEB.2.00.1402031135180.10986@cobra.newdream.net> <CAMQoE_1zi=DMKdZJyck=xQ0y16sBrK2FJSyJ8Mk2+jsRryq08w@mail.gmail.com> <alpine.DEB.2.00.1402180533580.15052@cobra.newdream.net>
 <CAMQoE_25sTJ3oveSE3spZHFtnsO-9vJ10KB1O8r5=3erazFVvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33406 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299AbaBRP6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2014 10:58:35 -0500
In-Reply-To: <CAMQoE_25sTJ3oveSE3spZHFtnsO-9vJ10KB1O8r5=3erazFVvg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guilhem Lettron <guilhem@lettron.fr>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 18 Feb 2014, Guilhem Lettron wrote:
> Thank you! :)
> 
> I will do my best to keep cookbook as clean and functional as possible.
> If anyone else want to help me, I'm really open.
> 
> Last thing you can do for Ceph cookbook is to enable travis (
> https://travis-ci.org/profile/ceph ) for this repository.

I think it is enabled now.  There is no .travis.yml file yet, but the hook 
is enabled and it's switched on at travis-ci.org...

sage


> Guilhem Lettron
> 
> 
> On Tue, Feb 18, 2014 at 2:45 PM, Sage Weil <sage@inktank.com> wrote:
> > On Tue, 18 Feb 2014, Guilhem Lettron wrote:
> >> Hi Sage,
> >> Sorry I didn't see this thread until tomorrow (Loic ping me this discussion
> >> during Paris meetup).
> >>
> >> I already do a lot of work on Ceph coobook last years, when I see the
> >> inactivity on repository, I review PR, merge and add tests on my own.
> >> Here is my repo: https://github.com/guilhem/ceph-cookbook
> >>
> >> I also have registered ceph on chef community
> >> repository: http://community.opscode.com/cookbooks/ceph
> >>
> >> I will be happy to merge it back on official repository and commit new
> >> version on chef community site.
> >
> > Thank you!  This is great news.  Let me know if there's anything I can
> > help with.
> >
> > sage
> >
> >>
> >> Guilhem Lettron
> >>
> >>
> >> On Mon, Feb 3, 2014 at 8:36 PM, Sage Weil <sage@inktank.com> wrote:
> >>       Hi everyone,
> >>
> >>       We have a huge backlog of pull requests on ceph-cookbooks.git on
> >>       github.
> >>       At the moment Inktank doesn't have a lot of spare cycles to
> >>       review and
> >>       test these changes.  Are there any chef+ceph users that are
> >>       interested in
> >>       helping maintain these cookbooks?
> >>
> >>       sage
> >>       --
> >>       To unsubscribe from this list: send the line "unsubscribe
> >>       ceph-devel" in
> >>       the body of a message to majordomo@vger.kernel.org
> >>       More majordomo info at
> >>        http://vger.kernel.org/majordomo-info.html
> >>
> >>
> >>
> >>
> 
> 
