From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 7/8] mds: fix race between scatter gather and dirfrag
 export
Date: Wed, 19 Jun 2013 08:23:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306190822400.26222@cobra.newdream.net>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com> <1371471029-10589-8-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51657 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab3FSPXP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 11:23:15 -0400
In-Reply-To: <1371471029-10589-8-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 17 Jun 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> If we gather dirty scatter lock state while corresponding dirfrag
> is been exporting, we may receive different dirfrag states from
> two MDS and we need to find which one is the newest. The solution
> is adding a new variable "migrate seq" to dirfrag, increase it by
> one when dirfrag's auth MDS changes. When gathering dirty scatter
> lock state, use "migrate seq" to find the newest dirfrag state.

This should bump the CEPH_MDS_PROTOCOL #define in MDS.h

Otherwise, looks godo!
sage

> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.cc    |  4 ++++
>  src/mds/CDir.h     |  4 +++-
>  src/mds/CInode.cc  | 18 ++++++++++++++++++
>  src/mds/MDCache.cc | 13 +++++++++++--
>  4 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 8c83eba..2b991d7 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -154,6 +154,7 @@ ostream& CDir::print_db_line_prefix(ostream& out)
>  // CDir
>  
>  CDir::CDir(CInode *in, frag_t fg, MDCache *mdcache, bool auth) :
> +  mseq(0),
>    dirty_rstat_inodes(member_offset(CInode, dirty_rstat_item)),
>    item_dirty(this), item_new(this),
>    pop_me(ceph_clock_now(g_ceph_context)),
> @@ -2121,6 +2122,8 @@ void CDir::_committed(version_t v)
>  void CDir::encode_export(bufferlist& bl)
>  {
>    assert(!is_projected());
> +  ceph_seq_t seq = mseq + 1;
> +  ::encode(seq, bl);
>    ::encode(first, bl);
>    ::encode(fnode, bl);
>    ::encode(dirty_old_rstat, bl);
> @@ -2150,6 +2153,7 @@ void CDir::finish_export(utime_t now)
>  
>  void CDir::decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls)
>  {
> +  ::decode(mseq, blp);
>    ::decode(first, blp);
>    ::decode(fnode, blp);
>    ::decode(dirty_old_rstat, blp);
> diff --git a/src/mds/CDir.h b/src/mds/CDir.h
> index 87c79c2..11f4a76 100644
> --- a/src/mds/CDir.h
> +++ b/src/mds/CDir.h
> @@ -170,6 +170,7 @@ public:
>  
>    fnode_t fnode;
>    snapid_t first;
> +  ceph_seq_t mseq; // migrate sequence
>    map<snapid_t,old_rstat_t> dirty_old_rstat;  // [value.first,key]
>  
>    // my inodes with dirty rstat data
> @@ -547,7 +548,8 @@ public:
>    // -- import/export --
>    void encode_export(bufferlist& bl);
>    void finish_export(utime_t now);
> -  void abort_export() { 
> +  void abort_export() {
> +    mseq += 2;
>      put(PIN_TEMPEXPORTING);
>    }
>    void decode_import(bufferlist::iterator& blp, utime_t now, LogSegment *ls);
> diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
> index 8936acd..c1ce8a1 100644
> --- a/src/mds/CInode.cc
> +++ b/src/mds/CInode.cc
> @@ -1222,6 +1222,7 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
>  	  dout(20) << fg << "           fragstat " << pf->fragstat << dendl;
>  	  dout(20) << fg << " accounted_fragstat " << pf->accounted_fragstat << dendl;
>  	  ::encode(fg, tmp);
> +	  ::encode(dir->mseq, tmp);
>  	  ::encode(dir->first, tmp);
>  	  ::encode(pf->fragstat, tmp);
>  	  ::encode(pf->accounted_fragstat, tmp);
> @@ -1255,6 +1256,7 @@ void CInode::encode_lock_state(int type, bufferlist& bl)
>  	  dout(10) << fg << " " << pf->rstat << dendl;
>  	  dout(10) << fg << " " << dir->dirty_old_rstat << dendl;
>  	  ::encode(fg, tmp);
> +	  ::encode(dir->mseq, tmp);
>  	  ::encode(dir->first, tmp);
>  	  ::encode(pf->rstat, tmp);
>  	  ::encode(pf->accounted_rstat, tmp);
> @@ -1404,10 +1406,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
>        dout(10) << " ...got " << n << " fragstats on " << *this << dendl;
>        while (n--) {
>  	frag_t fg;
> +	ceph_seq_t mseq;
>  	snapid_t fgfirst;
>  	frag_info_t fragstat;
>  	frag_info_t accounted_fragstat;
>  	::decode(fg, p);
> +	::decode(mseq, p);
>  	::decode(fgfirst, p);
>  	::decode(fragstat, p);
>  	::decode(accounted_fragstat, p);
> @@ -1420,6 +1424,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
>  	  assert(dir);                // i am auth; i had better have this dir open
>  	  dout(10) << fg << " first " << dir->first << " -> " << fgfirst
>  		   << " on " << *dir << dendl;
> +	  if (dir->fnode.fragstat.version == inode.dirstat.version &&
> +	      ceph_seq_cmp(mseq, dir->mseq) < 0) {
> +	    dout(10) << " mseq " << mseq << " < " << dir->mseq << ", ignoring" << dendl;
> +	    continue;
> +	  }
> +	  dir->mseq = mseq;
>  	  dir->first = fgfirst;
>  	  dir->fnode.fragstat = fragstat;
>  	  dir->fnode.accounted_fragstat = accounted_fragstat;
> @@ -1462,11 +1472,13 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
>        ::decode(n, p);
>        while (n--) {
>  	frag_t fg;
> +	ceph_seq_t mseq;
>  	snapid_t fgfirst;
>  	nest_info_t rstat;
>  	nest_info_t accounted_rstat;
>  	map<snapid_t,old_rstat_t> dirty_old_rstat;
>  	::decode(fg, p);
> +	::decode(mseq, p);
>  	::decode(fgfirst, p);
>  	::decode(rstat, p);
>  	::decode(accounted_rstat, p);
> @@ -1481,6 +1493,12 @@ void CInode::decode_lock_state(int type, bufferlist& bl)
>  	  assert(dir);                // i am auth; i had better have this dir open
>  	  dout(10) << fg << " first " << dir->first << " -> " << fgfirst
>  		   << " on " << *dir << dendl;
> +	  if (dir->fnode.rstat.version == inode.rstat.version &&
> +	      ceph_seq_cmp(mseq, dir->mseq) < 0) {
> +	    dout(10) << " mseq " << mseq << " < " << dir->mseq << ", ignoring" << dendl;
> +	    continue;
> +	  }
> +	  dir->mseq = mseq;
>  	  dir->first = fgfirst;
>  	  dir->fnode.rstat = rstat;
>  	  dir->fnode.accounted_rstat = accounted_rstat;
> diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
> index 2b0029f..f1ebedf 100644
> --- a/src/mds/MDCache.cc
> +++ b/src/mds/MDCache.cc
> @@ -3764,6 +3764,7 @@ void MDCache::rejoin_walk(CDir *dir, MMDSCacheRejoin *rejoin)
>      dout(15) << " add_strong_dirfrag " << *dir << dendl;
>      rejoin->add_strong_dirfrag(dir->dirfrag(), dir->get_replica_nonce(), dir->get_dir_rep());
>      dir->state_set(CDir::STATE_REJOINING);
> +    dir->mseq = 0;
>  
>      for (CDir::map_t::iterator p = dir->items.begin();
>  	 p != dir->items.end();
> @@ -3913,11 +3914,19 @@ void MDCache::handle_cache_rejoin_weak(MMDSCacheRejoin *weak)
>         ++p) {
>      CInode *in = get_inode(p->first);
>      assert(in);
> +    if (survivor) {
> +      list<CDir*> ls;
> +      in->get_subtree_dirfrags(ls);
> +      for (list<CDir*>::iterator q = ls.begin(); q != ls.end(); ++q) {
> +	if ((*q)->get_dir_auth().first == from)
> +	  (*q)->mseq = 0;
> +      }
> +    } else {
> +      rejoin_potential_updated_scatterlocks.insert(in);
> +    }
>      in->decode_lock_state(CEPH_LOCK_IFILE, p->second.file);
>      in->decode_lock_state(CEPH_LOCK_INEST, p->second.nest);
>      in->decode_lock_state(CEPH_LOCK_IDFT, p->second.dft);
> -    if (!survivor)
> -      rejoin_potential_updated_scatterlocks.insert(in);
>    }
>  
>    // recovering peer may send incorrect dirfrags here.  we need to
> -- 
> 1.8.1.4
> 
> 
