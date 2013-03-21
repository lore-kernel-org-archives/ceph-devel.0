From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 30/39] mds: check MDS peer's state through mdsmap
Date: Wed, 20 Mar 2013 20:24:32 -0700
Message-ID: <CAPYLRzhpVK5t7DwehKUbVc6ysPaLyjDYaeGsWa5Dn=otNOZmgw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-31-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54030 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3CUDYd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:24:33 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so6053797wid.5
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:24:32 -0700 (PDT)
In-Reply-To: <1363531902-24909-31-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Yep.
Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Migrator.cc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index d626cb1..143d71e 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -238,7 +238,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
>         export_unlock(dir);
>         export_locks.erase(dir);
>         dir->state_clear(CDir::STATE_EXPORTING);
> -       if (export_peer[dir] != who) // tell them.
> +       if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
>           mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
>         break;
>
> @@ -247,7 +247,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
>         dir->unfreeze_tree();  // cancel the freeze
>         export_state.erase(dir); // clean up
>         dir->state_clear(CDir::STATE_EXPORTING);
> -       if (export_peer[dir] != who) // tell them.
> +       if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
>           mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
>         break;
>
> @@ -278,7 +278,7 @@ void Migrator::handle_mds_failure_or_stop(int who)
>         export_unlock(dir);
>         export_locks.erase(dir);
>         dir->state_clear(CDir::STATE_EXPORTING);
> -       if (export_peer[dir] != who) // tell them.
> +       if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir])) // tell them.
>           mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
>         break;
>
> --
> 1.7.11.7
>
