From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 24/39] mds: take object's versionlock when rejoinning xlock
Date: Wed, 20 Mar 2013 17:37:31 -0700
Message-ID: <CAPYLRzi=aDcA88YjUPXn0jMeOW-8Wz0pX3eGZuiWWLckAXhS3g@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-25-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f50.google.com ([209.85.128.50]:45781 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529Ab3CUAhc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 20:37:32 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so1481035qej.23
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 17:37:31 -0700 (PDT)
In-Reply-To: <1363531902-24909-25-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index f4622de..194f983 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -4327,6 +4327,12 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>         dout(10) << " dn xlock by " << r << " on " << *dn << dendl;
>         MDRequest *mdr = request_get(r.reqid);  // should have this from auth_pin above.
>         assert(mdr->is_auth_pinned(dn));
> +       if (!mdr->xlocks.count(&dn->versionlock)) {
> +         assert(dn->versionlock.can_xlock_local());
> +         dn->versionlock.get_xlock(mdr, mdr->get_client());
> +         mdr->xlocks.insert(&dn->versionlock);
> +         mdr->locks.insert(&dn->versionlock);
> +       }
>         if (dn->lock.is_stable())
>           dn->auth_pin(&dn->lock);
>         dn->lock.set_state(LOCK_XLOCK);
> @@ -4421,6 +4427,12 @@ void MDCache::handle_cache_rejoin_strong(MMDSCacheRejoin *strong)
>         dout(10) << " inode xlock by " << q->second << " on " << *lock << " on " << *in << dendl;
>         MDRequest *mdr = request_get(q->second.reqid);  // should have this from auth_pin above.
>         assert(mdr->is_auth_pinned(in));
> +       if (!mdr->xlocks.count(&in->versionlock)) {
> +         assert(in->versionlock.can_xlock_local());
> +         in->versionlock.get_xlock(mdr, mdr->get_client());
> +         mdr->xlocks.insert(&in->versionlock);
> +         mdr->locks.insert(&in->versionlock);
> +       }
>         if (lock->is_stable())
>           in->auth_pin(lock);
>         lock->set_state(LOCK_XLOCK);
> --
> 1.7.11.7
>
