From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 32/39] mds: fix export cancel notification
Date: Wed, 20 Mar 2013 20:31:41 -0700
Message-ID: <CAPYLRzjMLQKAaqD22BbPxo3s2kX-W3-QtFJhURTRu3FdxB5u8w@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-33-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37090 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3CUDbn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:31:43 -0400
Received: by mail-wg0-f52.google.com with SMTP id 15so1901091wgd.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:31:42 -0700 (PDT)
In-Reply-To: <1363531902-24909-33-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> The comment says that if the importer is dead, bystanders thinks the
> exporter is the only auth, as per mdcache->handle_mds_failure(). But
> there is no such code in MDCache::handle_mds_failure().
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Migrator.cc | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 963706c..40a5394 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -1390,17 +1390,9 @@ void Migrator::export_logged_finish(CDir *dir)
>    for (set<int>::iterator p = export_notify_ack_waiting[dir].begin();
>         p != export_notify_ack_waiting[dir].end();
>         ++p) {
> -    MExportDirNotify *notify;
> -    if (mds->mdsmap->is_clientreplay_or_active_or_stopping(export_peer[dir]))
> -      // dest is still alive.
> -      notify = new MExportDirNotify(dir->dirfrag(), true,
> -                                   pair<int,int>(mds->get_nodeid(), dest),
> -                                   pair<int,int>(dest, CDIR_AUTH_UNKNOWN));
> -    else
> -      // dest is dead.  bystanders will think i am only auth, as per mdcache->handle_mds_failure()
> -      notify = new MExportDirNotify(dir->dirfrag(), true,
> -                                   pair<int,int>(mds->get_nodeid(), CDIR_AUTH_UNKNOWN),
> -                                   pair<int,int>(dest, CDIR_AUTH_UNKNOWN));
> +    MExportDirNotify *notify = new MExportDirNotify(dir->dirfrag(), true,
> +                                                   pair<int,int>(mds->get_nodeid(), dest),
> +                                                   pair<int,int>(dest, CDIR_AUTH_UNKNOWN));
>
>      for (set<CDir*>::iterator i = bounds.begin(); i != bounds.end(); i++)
>        notify->get_bounds().push_back((*i)->dirfrag());
> @@ -2115,11 +2107,9 @@ void Migrator::import_notify_abort(CDir *dir, set<CDir*>& bounds)
>    for (set<int>::iterator p = import_bystanders[dir].begin();
>         p != import_bystanders[dir].end();
>         ++p) {
> -    // NOTE: the bystander will think i am _only_ auth, because they will have seen
> -    // the exporter's failure and updated the subtree auth.  see mdcache->handle_mds_failure().
> -    MExportDirNotify *notify =
> +    MExportDirNotify *notify =
>        new MExportDirNotify(dir->dirfrag(), true,
> -                          pair<int,int>(mds->get_nodeid(), CDIR_AUTH_UNKNOWN),
> +                          pair<int,int>(import_peer[dir->dirfrag()], mds->get_nodeid()),
>                            pair<int,int>(import_peer[dir->dirfrag()], CDIR_AUTH_UNKNOWN));
>      for (set<CDir*>::iterator i = bounds.begin(); i != bounds.end(); i++)
>        notify->get_bounds().push_back((*i)->dirfrag());
> --
> 1.7.11.7
>
