From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 29/39] mds: avoid double auth pin for file recovery
Date: Wed, 20 Mar 2013 21:20:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303202117390.7109@cobra.newdream.net>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com> <1363531902-24909-30-git-send-email-zheng.z.yan@intel.com> <CAPYLRzigAZ5Omf5aU2sDLU6_Dzc9+6B5GRLvL9cti_tme5d+_Q@mail.gmail.com> <514A7F7F.5060007@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56821 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab3CUEUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Mar 2013 00:20:15 -0400
In-Reply-To: <514A7F7F.5060007@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 21 Mar 2013, Yan, Zheng wrote:
> On 03/21/2013 11:20 AM, Gregory Farnum wrote:
> > This looks good on its face but I haven't had the chance to dig
> > through the recovery queue stuff yet (it's on my list following some
> > issues with recovery speed). How'd you run across this? If it's being
> > added to the recovery queue multiple times I want to make sure we
> > don't have some other machinery trying to dequeue it multiple times,
> > or a single waiter which needs to be a list or something.
> > -Greg
> 
> Two clients that were writing the same file crashed successively.

Hmm, I would love to have a test case for this.  It should be pretty easy 
to construct some tests with libcephfs that fork, connect and do some 
operations, and are then killed by the parent, who verifies the resulting 
recovery occurs.  This is some of the more fragile, not just because it is 
rarely tested.

sage



> 
> Thanks,
> Yan, Zheng
> 
> > 
> > On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>
> >> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> >> ---
> >>  src/mds/MDCache.cc | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> >> index 973a4d0..e9a79cd 100644
> >> --- a/src/mds/MDCache.cc
> >> +++ b/src/mds/MDCache.cc
> >> @@ -5502,8 +5502,10 @@ void MDCache::_queue_file_recover(CInode *in)
> >>    dout(15) << "_queue_file_recover " << *in << dendl;
> >>    assert(in->is_auth());
> >>    in->state_clear(CInode::STATE_NEEDSRECOVER);
> >> -  in->state_set(CInode::STATE_RECOVERING);
> >> -  in->auth_pin(this);
> >> +  if (!in->state_test(CInode::STATE_RECOVERING)) {
> >> +    in->state_set(CInode::STATE_RECOVERING);
> >> +    in->auth_pin(this);
> >> +  }
> >>    file_recover_queue.insert(in);
> >>  }
> >>
> >> --
> >> 1.7.11.7
> >>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
