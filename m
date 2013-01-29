From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 07/25] mds: don't early reply rename
Date: Mon, 28 Jan 2013 18:23:29 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301281821310.16431@cobra.newdream.net>
References: <1358910541-15535-1-git-send-email-zheng.z.yan@intel.com> <1358910541-15535-8-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1301281342130.2055@cobra.newdream.net> <51072969.1040705@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57997 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab3A2CXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jan 2013 21:23:30 -0500
In-Reply-To: <51072969.1040705@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 29 Jan 2013, Yan, Zheng wrote:
> On 01/29/2013 05:44 AM, Sage Weil wrote:
> > On Wed, 23 Jan 2013, Yan, Zheng wrote:
> >> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> >>
> >> _rename_finish() does not send dentry link/unlink message to replicas.
> >> We should prevent dentries that are modified by the rename operation
> >> from getting new replicas when the rename operation is committing. So
> >> don't mark xlocks "done" and early reply for rename
> > 
> > Can we change this to only skip early reply if there are replicas?  Or 
> > change things so we do send thos messages (or something isilar) early?  As 
> > is this will kill workloads like rsync that rename every file.
> > 
> 
> How about not mark xlocks on dentries done.

Yeah, I like that if we do that just in the rename case.

The other patches look okay to me (from a quick review).  With that change 
I'd like to pull the whole branch in.  I assume your current wip-mds 
branch include sthe fix or squashes the problem from the previous series?

Thanks!
sage

> 
> Regards
> Yan, Zheng
> 
> 
> > Thanks!
> > s
> > 
> >>
> >> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> >> ---
> >>  src/mds/Server.cc | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> >> index eced76f..4492341 100644
> >> --- a/src/mds/Server.cc
> >> +++ b/src/mds/Server.cc
> >> @@ -796,6 +796,14 @@ void Server::early_reply(MDRequest *mdr, CInode *tracei, CDentry *tracedn)
> >>      return;
> >>    }
> >>  
> >> +  // _rename_finish() does not send dentry link/unlink message to replicas.
> >> +  // so do not mark xlocks "done", the xlocks prevent srcdn and destdn from
> >> +  // getting new replica.
> >> +  if (mdr->client_request->get_op() == CEPH_MDS_OP_RENAME) {
> >> +    dout(10) << "early_reply - rename, not allowed" << dendl;
> >> +    return;
> >> +  }
> >> +
> >>    MClientRequest *req = mdr->client_request;
> >>    entity_inst_t client_inst = req->get_source_inst();
> >>    if (client_inst.name.is_mds())
> >> -- 
> >> 1.7.11.7
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
