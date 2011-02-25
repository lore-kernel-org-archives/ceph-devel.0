From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: [ceph-commit] ceph.git branch librados_api updated.
 v0.24.3-788-gd15fe7f
Date: Fri, 25 Feb 2011 06:34:21 -0800
Message-ID: <87AD89F7CCC04A709286360DDD9F65F1@gmail.com>
References: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51322 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab1BYOeo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Feb 2011 09:34:44 -0500
Received: by iyb26 with SMTP id 26so933756iyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 Feb 2011 06:34:44 -0800 (PST)
In-Reply-To: <20110225021914.ED8EE485C515@ceph-tracker.dreamhostps.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Thursday, February 24, 2011 at 6:19 PM, Colin McCabe wrote:
The branch, librados_api has been updated
>  via d15fe7f90bf488c6251be4633b104a822ebd134f (commit)
>  from e3f3177febf07bf3b311414167fdf4ccbf07c472 (commit)
> 
> Those revisions listed above that are new to this repository have
> not appeared on any other notification email; so we list those
> revisions in full, below.
> 
> http://ceph.newdream.net/git/?p=ceph.git;a=commit;h=d15fe7f90bf488c6251be4633b104a822ebd134f
> 
> - Log -----------------------------------------------------------------
> commit d15fe7f90bf488c6251be4633b104a822ebd134f
> Author: Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
> Date: Thu Feb 24 10:13:09 2011 -0800
> 
>  rollback rename
> 
> ---
> 
>  src/include/rados/librados.h | 4 ++--
>  src/librados.cc | 5 ++---
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/src/include/rados/librados.h b/src/include/rados/librados.h
> index d220cad..f63b58a 100644
> --- a/src/include/rados/librados.h
> +++ b/src/include/rados/librados.h
> @@ -120,8 +120,8 @@ void rados_objects_list_close(rados_list_ctx_t ctx);
>  /* snapshots */
>  int rados_pool_snap_create(rados_pool_t pool, const char *snapname);
>  int rados_pool_snap_remove(rados_pool_t pool, const char *snapname);
> -int rados_pool_snap_rollback_object(rados_pool_t pool, const char *oid,
> - const char *snapname);
> +int rados_rollback(rados_pool_t pool, const char *oid,
> + const char *snapname);
>  void rados_pool_snap_set_read(rados_pool_t pool, rados_snap_t snap);
>  int rados_pool_selfmanaged_snap_create(rados_pool_t pool, uint64_t *snapid);
>  int rados_pool_selfmanaged_snap_remove(rados_pool_t pool, uint64_t snapid);
> diff --git a/src/librados.cc b/src/librados.cc
> index a819ebb..c1e81b2 100644
> --- a/src/librados.cc
> +++ b/src/librados.cc
> @@ -2674,9 +2674,8 @@ extern "C" int rados_pool_snap_remove(rados_pool_t pool, const char *snapname)
>  return ctx->client->snap_remove(ctx, snapname);
>  }
> 
> -extern "C" int rados_pool_snap_rollback_object(rados_pool_t pool,
> - const char *oid,
> - const char *snapname)
> +extern "C" int rados_rollback(rados_pool_t pool, const char *oid,
> + const char *snapname)
>  {
>  RadosClient::PoolCtx *ctx = (RadosClient::PoolCtx *)pool;
>  return ctx->client->snap_rollback_object(ctx, oid, snapname);
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream.net
> 
I think you guys talked about this yesterday -- sorry I missed it -- but what's the logic behind this new name "rados_rollback"? It's not quite working for me -- I think because it lacks the noun. :) Could we at least do rados_object_rollback()? Or even rados_object_rollback_to_snap()? 
