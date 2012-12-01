From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH V2] mds: fix CDir::_commit_partial() bug
Date: Sat, 1 Dec 2012 12:56:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212011252430.9862@cobra.newdream.net>
References: <1353603165-1724-1-git-send-email-zheng.z.yan@intel.com> <50BA0CF4.60203@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56251 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab2LAU4o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Dec 2012 15:56:44 -0500
In-Reply-To: <50BA0CF4.60203@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Sat, 1 Dec 2012, Yan, Zheng wrote:
> Hi Sage,
> 
> This patch is buggy, please drop it from wip-mds.

Done.
 
> On 11/23/2012 12:52 AM, Yan, Zheng wrote:
> > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > 
> > When a null dentry is encountered, CDir::_commit_partial() adds
> > a OSD_TMAP_RM command to delete the dentry. But if the dentry is
> > new, the osd will not find the dentry when handling the command
> > and the tmap update operation will fail totally.
> > 
> > This patch also makes sure dentries are properly marked as new
> > when preparing new dentries and exporting dentries.
> > 
> > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> > ---
> SNIP
> > diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> > index ec0d5d5..228fede 100644
> > --- a/src/mds/Server.cc
> > +++ b/src/mds/Server.cc
> > @@ -1685,6 +1685,9 @@ CDentry* Server::prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dn
> >        }
> >      }
> >  
> > +    if (!dn->is_dirty())
> > +      dn->mark_new();
> > +
> This should be something like 'else if (!dn->is_dirty())'. This issue
> has been fixed on the osd side, this patch is no longer needed.

Yeah.  It would still be nice to avoid including those ops in the osd 
request, as an optimization, but that can happen later.

Repushed wip-mds, and scheduled the fs suite to run against it.  That 
only covers single mds configurations still, but as long as there aren't 
regressions there I'm happy relying on your testing for now.

Real Soon Now we need to flesh out that suite to include clustered mds 
tests, export thrashing, and build a mds_thrasher teuthology task that 
restarts, adds, and stops mds's to exercise the failure paths.  Eventually 
we'll want to hook that into the failure injection sites in Migration.cc 
as well so we deliberatel exercise each failure point...

sage
