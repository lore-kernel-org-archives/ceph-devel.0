From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 13/39] mds: don't send resolve message between active MDS
Date: Wed, 20 Mar 2013 14:56:12 -0700
Message-ID: <CAPYLRzj0BYniL2g21qhFFV0OvhZU-O+btnTFAfsj7=qPR-b_mw@mail.gmail.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
	<1363531902-24909-14-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:50418 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab3CTV4N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 17:56:13 -0400
Received: by mail-qc0-f179.google.com with SMTP id b40so1088100qcq.38
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 14:56:12 -0700 (PDT)
In-Reply-To: <1363531902-24909-14-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Sun, Mar 17, 2013 at 7:51 AM, Yan, Zheng <zheng.z.yan@intel.com> wro=
te:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> When MDS cluster is resolving, current behavior is sending subtree re=
solve
> message to all other MDS and waiting for all other MDS' resolve messa=
ge.
> The problem is that active MDS can have diffent subtree map due to re=
name.
> Besides gathering active MDS's resolve messages are also racy. The on=
ly
> function for these messages is disambiguate other MDS' import. We can
> replace it by import finish notification.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/MDCache.cc  | 12 +++++++++---
>  src/mds/Migrator.cc | 25 +++++++++++++++++++++++--
>  src/mds/Migrator.h  |  3 ++-
>  3 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index c455a20..73c1d59 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -2517,7 +2517,8 @@ void MDCache::send_subtree_resolves()
>         ++p) {
>      if (*p =3D=3D mds->whoami)
>        continue;
> -    resolves[*p] =3D new MMDSResolve;
> +    if (mds->is_resolve() || mds->mdsmap->is_resolve(*p))
> +      resolves[*p] =3D new MMDSResolve;
>    }
>
>    // known
> @@ -2837,7 +2838,7 @@ void MDCache::handle_resolve(MMDSResolve *m)
>           migrator->import_reverse(dir);
>         } else {
>           dout(7) << "ambiguous import succeeded on " << *dir << dend=
l;
> -         migrator->import_finish(dir);
> +         migrator->import_finish(dir, true);
>         }
>         my_ambiguous_imports.erase(p);  // no longer ambiguous.
>        }
> @@ -3432,7 +3433,12 @@ void MDCache::rejoin_send_rejoins()
>         ++p) {
>      CDir *dir =3D p->first;
>      assert(dir->is_subtree_root());
> -    assert(!dir->is_ambiguous_dir_auth());
> +    if (dir->is_ambiguous_dir_auth()) {
> +      // exporter is recovering, importer is survivor.

The importer has to be the MDS this code is running on, right?

> +      assert(rejoins.count(dir->authority().first));
> +      assert(!rejoins.count(dir->authority().second));
> +      continue;
> +    }
>
>      // my subtree?
>      if (dir->is_auth())
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 5e53803..833df12 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -2088,6 +2088,23 @@ void Migrator::import_reverse(CDir *dir)
>    }
>  }
>
> +void Migrator::import_notify_finish(CDir *dir, set<CDir*>& bounds)
> +{
> +  dout(7) << "import_notify_finish " << *dir << dendl;
> +
> +  for (set<int>::iterator p =3D import_bystanders[dir].begin();
> +       p !=3D import_bystanders[dir].end();
> +       ++p) {
> +    MExportDirNotify *notify =3D
> +      new MExportDirNotify(dir->dirfrag(), false,
> +                          pair<int,int>(import_peer[dir->dirfrag()],=
 mds->get_nodeid()),
> +                          pair<int,int>(mds->get_nodeid(), CDIR_AUTH=
_UNKNOWN));

I don't think this is quite right =97 we're notifying them that we've
just finished importing data from somebody, right? And so we know that
we're the auth node...

> +    for (set<CDir*>::iterator i =3D bounds.begin(); i !=3D bounds.en=
d(); i++)
> +      notify->get_bounds().push_back((*i)->dirfrag());
> +    mds->send_message_mds(notify, *p);
> +  }
> +}
> +
>  void Migrator::import_notify_abort(CDir *dir, set<CDir*>& bounds)
>  {
>    dout(7) << "import_notify_abort " << *dir << dendl;
> @@ -2183,11 +2200,11 @@ void Migrator::handle_export_finish(MExportDi=
rFinish *m)
>    CDir *dir =3D cache->get_dirfrag(m->get_dirfrag());
>    assert(dir);
>    dout(7) << "handle_export_finish on " << *dir << dendl;
> -  import_finish(dir);
> +  import_finish(dir, false);
>    m->put();
>  }
>
> -void Migrator::import_finish(CDir *dir)
> +void Migrator::import_finish(CDir *dir, bool notify)
>  {
>    dout(7) << "import_finish on " << *dir << dendl;
>
> @@ -2205,6 +2222,10 @@ void Migrator::import_finish(CDir *dir)
>    // remove pins
>    set<CDir*> bounds;
>    cache->get_subtree_bounds(dir, bounds);
> +
> +  if (notify)
> +    import_notify_finish(dir, bounds);
> +
>    import_remove_pins(dir, bounds);
>
>    map<CInode*, map<client_t,Capability::Export> > cap_imports;
> diff --git a/src/mds/Migrator.h b/src/mds/Migrator.h
> index 7988f32..2889a74 100644
> --- a/src/mds/Migrator.h
> +++ b/src/mds/Migrator.h
> @@ -273,12 +273,13 @@ protected:
>    void import_reverse_unfreeze(CDir *dir);
>    void import_reverse_final(CDir *dir);
>    void import_notify_abort(CDir *dir, set<CDir*>& bounds);
> +  void import_notify_finish(CDir *dir, set<CDir*>& bounds);
>    void import_logged_start(dirfrag_t df, CDir *dir, int from,
>                            map<client_t,entity_inst_t> &imported_clie=
nt_map,
>                            map<client_t,uint64_t>& sseqmap);
>    void handle_export_finish(MExportDirFinish *m);
>  public:
> -  void import_finish(CDir *dir);
> +  void import_finish(CDir *dir, bool notify);
>  protected:
>
>    void handle_export_caps(MExportCaps *m);
> --
> 1.7.11.7
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
