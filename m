From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 4/4] mds: Allow evaluating locks in replica object.
Date: Fri, 26 Oct 2012 15:49:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210261548020.26041@cobra.newdream.net>
References: <1351168012-4981-1-git-send-email-zheng.z.yan@intel.com> <1351168012-4981-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45930 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932188Ab2JZWtt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 18:49:49 -0400
In-Reply-To: <1351168012-4981-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

On Thu, 25 Oct 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> We should allow Locker::try_eval(MDSCacheObject *, int) to evaluate
> locks in replica objects. Otherwise the locks in replica objects
> may stuck on unstable states forever.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Locker.cc | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
> index a03789f..2c840a9 100644
> --- a/src/mds/Locker.cc
> +++ b/src/mds/Locker.cc
> @@ -834,12 +834,7 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
>      return;
>    }
>  
> -  if (!p->is_auth()) {
> -    dout(7) << "try_eval not auth for " << *p << dendl;
> -    return;
> -  }
> -
> -  if (!p->can_auth_pin()) {
> +  if (p->is_auth() && !p->can_auth_pin()) {
>      dout(7) << "try_eval can't auth_pin, waiting on " << *p << dendl;
>      p->add_waiter(MDSCacheObject::WAIT_UNFREEZE, new C_Locker_Eval(this, p, mask));
>      return;
> @@ -847,9 +842,11 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
>  
>    if (mask & CEPH_LOCK_DN) {
>      assert(mask == CEPH_LOCK_DN);
> -    bool need_issue = false;  // ignore this, no caps on dentries
> -    CDentry *dn = (CDentry *)p;
> -    simple_eval(&dn->lock, &need_issue);
> +    if (p->is_auth()) {
> +      bool need_issue = false;  // ignore this, no caps on dentries
> +      CDentry *dn = (CDentry *)p;
> +      simple_eval(&dn->lock, &need_issue);
> +    }
>    } else {
>      CInode *in = (CInode *)p;
>      eval(in, mask);
> -- 
> 1.7.11.7

I handled this one a bit differently.  I think we should still consider 
the non-auth eval_gather() case on the dentry.  I applied the below to the 
wip-mds branch.. look okay?  Notably, eval(CInode*,...) calls eval_any() 
on all of the masked locks, so the path is symmetrical.

Thanks!
sage



diff --git a/src/mds/Locker.cc b/src/mds/Locker.cc
index a03789f..e033bbe 100644
--- a/src/mds/Locker.cc
+++ b/src/mds/Locker.cc
@@ -834,12 +834,7 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
     return;
   }
 
-  if (!p->is_auth()) {
-    dout(7) << "try_eval not auth for " << *p << dendl;
-    return;
-  }
-
-  if (!p->can_auth_pin()) {
+  if (p->is_auth() && !p->can_auth_pin()) {
     dout(7) << "try_eval can't auth_pin, waiting on " << *p << dendl;
     p->add_waiter(MDSCacheObject::WAIT_UNFREEZE, new C_Locker_Eval(this, p, mask));
     return;
@@ -849,7 +844,7 @@ void Locker::try_eval(MDSCacheObject *p, int mask)
     assert(mask == CEPH_LOCK_DN);
     bool need_issue = false;  // ignore this, no caps on dentries
     CDentry *dn = (CDentry *)p;
-    simple_eval(&dn->lock, &need_issue);
+    eval_any(&dn->lock, &need_issue);
   } else {
     CInode *in = (CInode *)p;
     eval(in, mask);
