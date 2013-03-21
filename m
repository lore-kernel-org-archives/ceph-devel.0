From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 35/39] mds: clear dirty inode rstat if import fails
Date: Wed, 20 Mar 2013 20:40:43 -0700
Message-ID: <CAPYLRzhazJ1-rFzh3_pjAbKk_9uoGK3=JAc8nvZbJ5-kkaDiaA@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-36-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:59358 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142Ab3CUDko (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:40:44 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so6060174wid.5
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:40:43 -0700 (PDT)
In-Reply-To: <1363531902-24909-36-git-send-email-zheng.z.yan@intel.com>
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
>  src/mds/CDir.cc     | 1 +
>  src/mds/Migrator.cc | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 34bd8d3..47b6753 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -1022,6 +1022,7 @@ void CDir::assimilate_dirty_rstat_inodes()
>    for (elist<CInode*>::iterator p = dirty_rstat_inodes.begin_use_current();
>         !p.end(); ++p) {
>      CInode *in = *p;
> +    assert(in->is_auth());
>      if (in->is_frozen())
>        continue;
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 0672d03..f563b8d 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -2052,6 +2052,8 @@ void Migrator::import_reverse(CDir *dir)
>         in->clear_replica_map();
>         if (in->is_dirty())
>           in->mark_clean();
> +       in->clear_dirty_rstat();
> +
>         in->authlock.clear_gather();
>         in->linklock.clear_gather();
>         in->dirfragtreelock.clear_gather();
> --
> 1.7.11.7
>
