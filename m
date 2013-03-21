From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 36/39] mds: try merging subtree after clear EXPORTBOUND
Date: Wed, 20 Mar 2013 20:44:03 -0700
Message-ID: <CAPYLRzhsmvpUpAAGLk3s2Vb9x7LLN3q7Bt-g29W2-rF0mVBqXQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-37-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:57790 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753980Ab3CUDoG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:44:06 -0400
Received: by mail-we0-f169.google.com with SMTP id x56so1122566wey.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:44:03 -0700 (PDT)
In-Reply-To: <1363531902-24909-37-git-send-email-zheng.z.yan@intel.com>
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
>  src/mds/Migrator.cc | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index f563b8d..9cbad87 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -1340,10 +1340,6 @@ void Migrator::export_reverse(CDir *dir)
>    set<CDir*> bounds;
>    cache->get_subtree_bounds(dir, bounds);
>
> -  // adjust auth, with possible subtree merge.
> -  cache->adjust_subtree_auth(dir, mds->get_nodeid());
> -  cache->try_subtree_merge(dir);  // NOTE: may journal subtree_map as side-effect
> -
>    // remove exporting pins
>    list<CDir*> rq;
>    rq.push_back(dir);
> @@ -1371,6 +1367,10 @@ void Migrator::export_reverse(CDir *dir)
>      bd->state_clear(CDir::STATE_EXPORTBOUND);
>    }
>
> +  // adjust auth, with possible subtree merge.
> +  cache->adjust_subtree_auth(dir, mds->get_nodeid());
> +  cache->try_subtree_merge(dir);  // NOTE: may journal subtree_map as side-effect
> +
>    // notify bystanders
>    export_notify_abort(dir, bounds);
>
> --
> 1.7.11.7
>
