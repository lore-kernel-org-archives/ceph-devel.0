From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 33/39] mds: notify bystanders if export aborts
Date: Wed, 20 Mar 2013 20:34:50 -0700
Message-ID: <CAPYLRzg1rh4vxZYBUYwXHpjticfmtuEJS8zKFfBoe=Gs13tyyQ@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-34-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:37427 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624Ab3CUDev (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 23:34:51 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so2580574wib.3
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 20:34:50 -0700 (PDT)
In-Reply-To: <1363531902-24909-34-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Reviewed-by: Greg Farnum <greg@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> So bystanders know the subtree is single auth earlier.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/Migrator.cc | 34 ++++++++++++++++++++++++++--------
>  src/mds/Migrator.h  |  1 +
>  2 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 40a5394..0672d03 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -251,25 +251,28 @@ void Migrator::handle_mds_failure_or_stop(int who)
>           mds->send_message_mds(new MExportDirCancel(dir->dirfrag()), export_peer[dir]);
>         break;
>
> -       // NOTE: state order reversal, warning comes after loggingstart+prepping
> +       // NOTE: state order reversal, warning comes after prepping
>        case EXPORT_WARNING:
>         dout(10) << "export state=warning : unpinning bounds, unfreezing, notifying" << dendl;
>         // fall-thru
>
>        case EXPORT_PREPPING:
>         if (p->second != EXPORT_WARNING)
> -         dout(10) << "export state=loggingstart|prepping : unpinning bounds, unfreezing" << dendl;
> +         dout(10) << "export state=prepping : unpinning bounds, unfreezing" << dendl;
>         {
>           // unpin bounds
>           set<CDir*> bounds;
>           cache->get_subtree_bounds(dir, bounds);
> -         for (set<CDir*>::iterator p = bounds.begin();
> -              p != bounds.end();
> -              ++p) {
> -           CDir *bd = *p;
> +         for (set<CDir*>::iterator q = bounds.begin();
> +              q != bounds.end();
> +              ++q) {
> +           CDir *bd = *q;
>             bd->put(CDir::PIN_EXPORTBOUND);
>             bd->state_clear(CDir::STATE_EXPORTBOUND);
>           }
> +         // notify bystanders
> +         if (p->second == EXPORT_WARNING)
> +           export_notify_abort(dir, bounds);
>         }
>         dir->unfreeze_tree();
>         export_state.erase(dir); // clean up
> @@ -1307,9 +1310,21 @@ void Migrator::handle_export_ack(MExportDirAck *m)
>    m->put();
>  }
>
> +void Migrator::export_notify_abort(CDir *dir, set<CDir*>& bounds)
> +{
> +  dout(7) << "export_notify_abort " << *dir << dendl;
>
> -
> -
> +  for (set<int>::iterator p = export_notify_ack_waiting[dir].begin();
> +       p != export_notify_ack_waiting[dir].end();
> +       ++p) {
> +    MExportDirNotify *notify = new MExportDirNotify(dir->dirfrag(), false,
> +                                                   pair<int,int>(mds->get_nodeid(),export_peer[dir]),
> +                                                   pair<int,int>(mds->get_nodeid(),CDIR_AUTH_UNKNOWN));
> +    for (set<CDir*>::iterator i = bounds.begin(); i != bounds.end(); ++i)
> +      notify->get_bounds().push_back((*i)->dirfrag());
> +    mds->send_message_mds(notify, *p);
> +  }
> +}
>
>  /*
>   * this happens if hte dest failes after i send teh export data but before it is acked
> @@ -1356,6 +1371,9 @@ void Migrator::export_reverse(CDir *dir)
>      bd->state_clear(CDir::STATE_EXPORTBOUND);
>    }
>
> +  // notify bystanders
> +  export_notify_abort(dir, bounds);
> +
>    // process delayed expires
>    cache->process_delayed_expire(dir);
>
> diff --git a/src/mds/Migrator.h b/src/mds/Migrator.h
> index 2889a74..f395bc1 100644
> --- a/src/mds/Migrator.h
> +++ b/src/mds/Migrator.h
> @@ -227,6 +227,7 @@ public:
>    void export_go(CDir *dir);
>    void export_go_synced(CDir *dir);
>    void export_reverse(CDir *dir);
> +  void export_notify_abort(CDir *dir, set<CDir*>& bounds);
>    void handle_export_ack(MExportDirAck *m);
>    void export_logged_finish(CDir *dir);
>    void handle_export_notify_ack(MExportDirNotifyAck *m);
> --
> 1.7.11.7
>
