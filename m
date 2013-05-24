From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 25/30] mds: bring back old style backtrace handling
Date: Thu, 23 May 2013 18:01:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305231801070.29396@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-26-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231549010.29396@cobra.newdream.net> <519EBB15.30203@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46836 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150Ab3EXBBs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 21:01:48 -0400
In-Reply-To: <519EBB15.30203@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On Fri, 24 May 2013, Yan, Zheng wrote:
> On 05/24/2013 06:58 AM, Sage Weil wrote:
> > On Thu, 23 May 2013, Yan, Zheng wrote:
> > [snip]
> >> +
> >> +void CInode::store_backtrace(Context *fin)
> >> +{
> >> +  dout(10) << "store_backtrace on " << *this << dendl;
> >> +  assert(is_dirty_parent());
> >> +
> >> +  auth_pin(this);
> >> +
> >> +  int64_t pool;
> >> +  if (is_dir())
> >> +    pool = mdcache->mds->mdsmap->get_metadata_pool();
> >> +  else
> >> +    pool = inode.layout.fl_pg_pool;
> >> +
> >> +  inode_backtrace_t bt;
> >> +  build_backtrace(pool, &bt);
> >> +  bufferlist bl;
> >> +  ::encode(bt, bl);
> >> +
> >> +  // write it.
> >> +  SnapContext snapc;
> >> +  object_t oid = get_object_name(ino(), frag_t(), "");
> >> +  object_locator_t oloc(pool);
> >> +  Context *fin2 = new C_Inode_StoredBacktrace(this, inode.backtrace_version, fin);
> >> +
> >> +  if (!state_test(STATE_DIRTYPOOL)) {
> >> +    mdcache->mds->objecter->setxattr(oid, oloc, "parent", snapc, bl,
> >> +				     ceph_clock_now(g_ceph_context),
> >> +				     0, NULL, fin2);
> >> +    return;
> >> +  }
> >> +
> >> +  C_GatherBuilder gather(g_ceph_context, fin2);
> >> +  mdcache->mds->objecter->setxattr(oid, oloc, "parent", snapc, bl,
> >> +				   ceph_clock_now(g_ceph_context),
> >> +				   0, NULL, gather.new_sub());
> >> +  for (set<int64_t>::iterator p = bt.old_pools.begin();
> >> +       p != bt.old_pools.end();
> >> +       ++p) {
> >> +    object_locator_t oloc2(*p);
> >> +    mdcache->mds->objecter->setxattr(oid, oloc2, "parent", snapc, bl,
> >> +				     ceph_clock_now(g_ceph_context),
> >> +				     0, NULL, gather.new_sub());
> >> +  }
> > 
> > I think for both of theese operations we need an ObjectWriteOperation that 
> > does a touch() and then tsetxattr to ensure the object actually exists.
> > 
> will add it
> 
> > Also, if one mds has a backtrace write in flight, exports teh inode, and 
> > the second mds needs to update it, we need to make sure they don't race 
> > and overwrite a newer trace with an older one.  That could be done with a 
> > parent_version xattr with the backttrace_version in it and a generic rados 
> > cmpxattr guard, I believe.  Even then we may race with an unlink, but that 
> > may be something we just tolerate...
> > 
> my code calls auth_pin() in CInode::store_backtrace(). I think it also avoid
> the race.

even better.  sounds good!

sage

