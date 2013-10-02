From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/3] ceph: fixes for directory fragment
Date: Wed, 2 Oct 2013 15:09:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310021508361.12714@cobra.newdream.net>
References: <1379717080-15626-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1309212100010.19555@cobra.newdream.net> <CAAM7YA=72+BuSsvUWGeQKYQBJLrKPtkoDL5MLq2CyLQ-kjF9iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32912 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3JBWJj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 18:09:39 -0400
In-Reply-To: <CAAM7YA=72+BuSsvUWGeQKYQBJLrKPtkoDL5MLq2CyLQ-kjF9iQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel@vger.kernel.org

On Sun, 22 Sep 2013, Yan, Zheng wrote:
> On Sun, Sep 22, 2013 at 12:01 PM, Sage Weil <sage@inktank.com> wrote:
> > These look good.
> >
> > I would *really* like to get some tests into ceph-qa-suite that cover
> > multi-mds, multi-mds thrashing, and mds frag = true.  Eventulaly also 'mds
> > thrash frags = true' (is this what you're testing with?).
> >
> > sage
> 
> my conf for the directory fragment feaure
> ---
> mds bal_frag = 1
> mds bal_split_bits = 2
> mds bal_split_size = 256
> mds bal_merge_size = 32
> 
> I test these patches by running blogbench and a script that
> create/delete 500k file in a directory.

Can you add the script to qa/workunits/ somewhere?  Then we can add 
some tests to ceph-qa-suite.git/suites/fs/frag so that this gets nightly 
coverage.

Thanks!
sage


> Besides the mds is restarted every two miniutes.
> 
> Regards
> Yan, Zheng
> 
> >
> >
> > On Sat, 21 Sep 2013, Yan, Zheng wrote:
> >
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>
> >> This patch series is also in:
> >>   https://github.com/ceph/ceph-client.git wip-dirfrag
> >>
> >> The MDS counterpart is in:
> >>   https://github.com/ceph/ceph.git wip-dirfrag
> >>
> >> Regards
> >> Yan, Zheng
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
