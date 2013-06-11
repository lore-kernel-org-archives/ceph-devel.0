From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 9/9] ceph: move inode to proper flushing list when auth
 MDS changes
Date: Mon, 10 Jun 2013 23:17:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306102314310.18349@cobra.newdream.net>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com> <1370315998-10418-10-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1306102307090.18349@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54271 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab3FKGRh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jun 2013 02:17:37 -0400
In-Reply-To: <alpine.DEB.2.00.1306102307090.18349@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, elder@inktank.com

On Mon, 10 Jun 2013, Sage Weil wrote:
> Hi Yan-
> 
> On Tue, 4 Jun 2013, Yan, Zheng wrote:
> 
> > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > 
> > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> > ---
> >  fs/ceph/caps.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 790f88b..458a66e 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -1982,8 +1982,14 @@ static void kick_flushing_inode_caps(struct ceph_mds_client *mdsc,
> >  	cap = ci->i_auth_cap;
> >  	dout("kick_flushing_inode_caps %p flushing %s flush_seq %lld\n", inode,
> >  	     ceph_cap_string(ci->i_flushing_caps), ci->i_cap_flush_seq);
> > +
> >  	__ceph_flush_snaps(ci, &session, 1);
> 
> This function does funny things to the local session pointer... did you 
> consider this when using it below?  It can change to the auth cap mds if 
> it is different than the value passed in...

I wonder if we screwed something up here, but I just got a crash inside 
remove_session_caps() that might be explained by a corrupt list.  I don't 
think I've seen this before..

0xffff880214aabf20      753        2  1    3   R  0xffff880214aac3a8 
*kworker/3:2
 ffff880224a33ae8 0000000000000018 ffffffffa0814d63 ffff880224f85800
 ffff88020b277790 ffff880224f85800 ffff88020c04e800 ffff880224a33c08
 ffffffffa081a1cf ffffffffffffffff ffff880224a33fd8 ffffffffffffffff
Call Trace:
 [<ffffffffa0814d63>] ? remove_session_caps+0x33/0x140 [ceph]
 [<ffffffffa081a1cf>] ? dispatch+0x7ff/0x1740 [ceph]
 [<ffffffff81510b66>] ? kernel_recvmsg+0x46/0x60
 [<ffffffffa07c4e38>] ? ceph_tcp_recvmsg+0x48/0x60 [libceph]
 [<ffffffff810a317d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffffa07c81f8>] ? con_work+0x1948/0x2d50 [libceph]
 [<ffffffff81080c93>] ? idle_balance+0x133/0x180
 [<ffffffff81071c58>] ? finish_task_switch+0x48/0x110
 [<ffffffff81071c58>] ? finish_task_switch+0x48/0x110
 [<ffffffff8105f44f>] ? process_one_work+0x16f/0x540
 [<ffffffff8105f4ba>] ? process_one_work+0x1da/0x540
 [<ffffffff8105f44f>] ? process_one_work+0x16f/0x540
 [<ffffffff8106069c>] ? worker_thread+0x11c/0x370
 [<ffffffff81060580>] ? manage_workers.isra.20+0x2e0/0x2e0
 [<ffffffff8106735a>] ? kthread+0xea/0xf0



> 
> > +
> >  	if (ci->i_flushing_caps) {
> > +		spin_lock(&mdsc->cap_dirty_lock);
> > +		list_move_tail(&ci->i_flushing_item, &session->s_cap_flushing);
> > +		spin_unlock(&mdsc->cap_dirty_lock);
> > +
> >  		delayed = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH,
> >  				     __ceph_caps_used(ci),
> >  				     __ceph_caps_wanted(ci),
> > -- 
> > 1.8.1.4
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
