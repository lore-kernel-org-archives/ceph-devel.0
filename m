From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH V2] mds: fix CDir::_commit_partial() bug
Date: Sat, 24 Nov 2012 19:05:38 +0800
Message-ID: <50B0AA02.4050502@intel.com>
References: <1353603165-1724-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7426 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab2KXLFo (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 24 Nov 2012 06:05:44 -0500
In-Reply-To: <1353603165-1724-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "sage@inktank.com >> Sage Weil" <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi, Sage

I found this fix is still not enough because we don't know if a dentry has been
successfully deleted from the directory fragment after MDS restart. There are several
options to fix this, which one do you like?

1. Make OSD ignore the TMAP_RM commands if it can't the find items.

2. Add a new item deletion command for tmap, the new command doesn't make whole tmap
   update operation fail if it can't the item. When committing directory fragments,
   use the new command for null dentries that were added by MDS log replay.

3. When committing a directory fragment, Re-fetch it if it contains dirty+null dentries
   that were added by MDS log replay. Find already deleted items and mark corresponding
   dentries as new.

Regards
Yan, Zheng

On 11/23/2012 12:52 AM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When a null dentry is encountered, CDir::_commit_partial() adds
> a OSD_TMAP_RM command to delete the dentry. But if the dentry is
> new, the osd will not find the dentry when handling the command
> and the tmap update operation will fail totally.
> 
> This patch also makes sure dentries are properly marked as new
> when preparing new dentries and exporting dentries.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDentry.h  |  2 ++
>  src/mds/CDir.cc    | 11 ++++++++---
>  src/mds/CDir.h     |  2 +-
>  src/mds/MDCache.cc |  9 ++++++---
>  src/mds/Server.cc  |  3 +++
>  5 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/src/mds/CDentry.h b/src/mds/CDentry.h
> index 480e562..5755c55 100644
> --- a/src/mds/CDentry.h
> +++ b/src/mds/CDentry.h
> @@ -347,6 +347,8 @@ public:
>      // twiddle
>      state = 0;
>      state_set(CDentry::STATE_AUTH);
> +    if (nstate & STATE_NEW)
> +      mark_new();
>      if (nstate & STATE_DIRTY)
>        _mark_dirty(ls);
>      if (!replica_map.empty())
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index c5220ed..411d864 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -1696,7 +1696,7 @@ class C_Dir_Committed : public Context {
>  public:
>    C_Dir_Committed(CDir *d, version_t v, version_t lrv) : dir(d), version(v), last_renamed_version(lrv) { }
>    void finish(int r) {
> -    dir->_committed(version, last_renamed_version);
> +    dir->_committed(version, last_renamed_version, r);
>    }
>  };
>  
> @@ -1802,6 +1802,10 @@ CDir::map_t::iterator CDir::_commit_partial(ObjectOperation& m,
>        continue;  // skip clean dentries
>  
>      if (dn->get_linkage()->is_null()) {
> +      if (dn->is_new()) {
> +	dn->mark_clean();
> +	continue;
> +      }
>        dout(10) << " rm " << dn->name << " " << *dn << dendl;
>        finalbl.append(CEPH_OSD_TMAP_RM);
>        dn->key().encode(finalbl);
> @@ -1997,10 +2001,11 @@ void CDir::_commit(version_t want)
>   *
>   * @param v version i just committed
>   */
> -void CDir::_committed(version_t v, version_t lrv)
> +void CDir::_committed(version_t v, version_t lrv, int ret)
>  {
> -  dout(10) << "_committed v " << v << " (last renamed " << lrv << ") on " << *this << dendl;
> +  dout(10) << "_committed ret " << ret << " v " << v << " (last renamed " << lrv << ") on " << *this << dendl;
>    assert(is_auth());
> +  assert(ret == 0);
>  
>    bool stray = inode->is_stray();
>  
> diff --git a/src/mds/CDir.h b/src/mds/CDir.h
> index 2222418..274e38b 100644
> --- a/src/mds/CDir.h
> +++ b/src/mds/CDir.h
> @@ -487,7 +487,7 @@ private:
>                         unsigned max_write_size=-1,
>                         map_t::iterator last_committed_dn=map_t::iterator());
>    void _encode_dentry(CDentry *dn, bufferlist& bl, const set<snapid_t> *snaps);
> -  void _committed(version_t v, version_t last_renamed_version);
> +  void _committed(version_t v, version_t last_renamed_version, int ret);
>    void wait_for_commit(Context *c, version_t v=0);
>  
>    // -- dirtyness --
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index f8b1c8f..e69a49f 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -657,12 +657,15 @@ CDentry *MDCache::get_or_create_stray_dentry(CInode *in)
>    CDir *straydir = strayi->get_dirfrag(fg);
>    assert(straydir);
>    CDentry *straydn = straydir->lookup(straydname);
> -  if (!straydn) {
> +
> +  if (!straydn)
>      straydn = straydir->add_null_dentry(straydname);
> -    straydn->mark_new();
> -  } else 
> +  else
>      assert(straydn->get_projected_linkage()->is_null());
>  
> +  if (!straydn->is_dirty())
> +    straydn->mark_new();
> +
>    return straydn;
>  }
>  
> diff --git a/src/mds/Server.cc b/src/mds/Server.cc
> index ec0d5d5..228fede 100644
> --- a/src/mds/Server.cc
> +++ b/src/mds/Server.cc
> @@ -1685,6 +1685,9 @@ CDentry* Server::prepare_null_dentry(MDRequest *mdr, CDir *dir, const string& dn
>        }
>      }
>  
> +    if (!dn->is_dirty())
> +      dn->mark_new();
> +
>      return dn;
>    }
>  
> 

