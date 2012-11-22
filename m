From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: fix CDir::_commit_partial() bug
Date: Thu, 22 Nov 2012 07:33:36 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211220733000.9963@cobra.newdream.net>
References: <1353570527-10834-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44351 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab2KVTbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 14:31:10 -0500
In-Reply-To: <1353570527-10834-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 22 Nov 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> When a null dentry is encountered, CDir::_commit_partial() adds
> a OSD_TMAP_RM command to delete the dentry. But if the dentry is
> new, the osd will not find the dentry when handling the command
> and the tmap update operation will fail totally.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

This could explain all manner of corruptions and problems we've seen!  
Great catch.

sage


> ---
>  src/mds/CDir.cc | 17 +++++++++--------
>  src/mds/CDir.h  |  2 +-
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index c5220ed..4896f01 100644
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
> @@ -1801,14 +1801,14 @@ CDir::map_t::iterator CDir::_commit_partial(ObjectOperation& m,
>      if (!dn->is_dirty())
>        continue;  // skip clean dentries
>  
> -    if (dn->get_linkage()->is_null()) {
> -      dout(10) << " rm " << dn->name << " " << *dn << dendl;
> -      finalbl.append(CEPH_OSD_TMAP_RM);
> -      dn->key().encode(finalbl);
> -    } else {
> +    if (!dn->get_linkage()->is_null()) {
>        dout(10) << " set " << dn->name << " " << *dn << dendl;
>        finalbl.append(CEPH_OSD_TMAP_SET);
>        _encode_dentry(dn, finalbl, snaps);
> +    } else if (!dn->is_new()) {
> +      dout(10) << " rm " << dn->name << " " << *dn << dendl;
> +      finalbl.append(CEPH_OSD_TMAP_RM);
> +      dn->key().encode(finalbl);
>      }
>    }
>  
> @@ -1997,10 +1997,11 @@ void CDir::_commit(version_t want)
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
> -- 
> 1.7.11.7
> 
> 
