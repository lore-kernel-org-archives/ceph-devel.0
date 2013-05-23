From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 13/30] mds: export CInode::STATE_NEEDSRECOVER
Date: Thu, 23 May 2013 10:59:39 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305231057380.32642@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-14-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42056 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759792Ab3EWR7k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 13:59:40 -0400
In-Reply-To: <1369296418-14871-14-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On Thu, 23 May 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.cc     |  1 +
>  src/mds/CInode.cc   | 14 +++++++++-----
>  src/mds/CInode.h    |  5 +++++
>  src/mds/Migrator.cc | 11 ++++-------
>  4 files changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 9b49c10..10b4bf4 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -2142,6 +2142,7 @@ void CDir::encode_export(bufferlist& bl)
>  
>  void CDir::finish_export(utime_t now)
>  {
> +  state &= MASK_STATE_EXPORT_KEPT;
>    pop_auth_subtree_nested.sub(now, cache->decayrate, pop_auth_subtree);
>    pop_me.zero(now);
>    pop_auth_subtree.zero(now);
> diff --git a/src/mds/CInode.cc b/src/mds/CInode.cc
> index 781ed72..857e5cc 100644
> --- a/src/mds/CInode.cc
> +++ b/src/mds/CInode.cc
> @@ -2992,8 +2992,7 @@ void CInode::encode_export(bufferlist& bl)
>    ENCODE_START(3, 3, bl)
>    _encode_base(bl);
>  
> -  bool dirty = is_dirty();
> -  ::encode(dirty, bl);
> +  ::encode(state, bl);

This changes the format of the encoding.  The version needs to be bumped 
in the 

   DECODE_START_LEGACY_COMPAT_LEN(3, 3, 3, p);

lines.. pbly just simplify to 

   DECODE_START(4, 4, p);

and then the protocol rev needs to be bumped in MDS.h.

>  
>    ::encode(pop, bl);
>  
> @@ -3024,6 +3023,8 @@ void CInode::encode_export(bufferlist& bl)
>  
>  void CInode::finish_export(utime_t now)
>  {
> +  state &= MASK_STATE_EXPORT_KEPT;
> +
>    pop.zero(now);
>  
>    // just in case!
> @@ -3041,10 +3042,13 @@ void CInode::decode_import(bufferlist::iterator& p,
>  
>    _decode_base(p);
>  
> -  bool dirty;
> -  ::decode(dirty, p);
> -  if (dirty) 
> +  unsigned s;
> +  ::decode(s, p);
> +  state |= (s & MASK_STATE_EXPORTED);
> +  if (is_dirty()) {
> +    get(PIN_DIRTY);
>      _mark_dirty(ls);
> +  }
>  
>    ::decode(pop, ceph_clock_now(g_ceph_context), p);
>  
> diff --git a/src/mds/CInode.h b/src/mds/CInode.h
> index 7c63593..47973c2 100644
> --- a/src/mds/CInode.h
> +++ b/src/mds/CInode.h
> @@ -155,6 +155,11 @@ public:
>    static const int STATE_STRAYPINNED = (1<<16);
>    static const int STATE_FROZENAUTHPIN = (1<<17);
>  
> +  static const int MASK_STATE_EXPORTED =
> +    (STATE_DIRTY|STATE_NEEDSRECOVER);
> +  static const int MASK_STATE_EXPORT_KEPT =
> +    (STATE_FROZEN|STATE_AMBIGUOUSAUTH|STATE_EXPORTINGCAPS);
> +
>    // -- waiters --
>    static const uint64_t WAIT_DIR         = (1<<0);
>    static const uint64_t WAIT_ANCHORED    = (1<<1);
> diff --git a/src/mds/Migrator.cc b/src/mds/Migrator.cc
> index 59abb31..5cc26a3 100644
> --- a/src/mds/Migrator.cc
> +++ b/src/mds/Migrator.cc
> @@ -1066,10 +1066,6 @@ void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& fini
>  {
>    dout(12) << "finish_export_inode " << *in << dendl;
>  
> -  in->finish_export(now);
> -
> -  finish_export_inode_caps(in);
> -
>    // clean
>    if (in->is_dirty())
>      in->mark_clean();
> @@ -1103,7 +1099,11 @@ void Migrator::finish_export_inode(CInode *in, utime_t now, list<Context*>& fini
>  
>    // waiters
>    in->take_waiting(CInode::WAIT_ANY_MASK, finished);
> +
> +  in->finish_export(now);
>    
> +  finish_export_inode_caps(in);
> +
>    // *** other state too?
>  
>    // move to end of LRU so we drop out of cache quickly!
> @@ -1218,9 +1218,6 @@ void Migrator::finish_export_dir(CDir *dir, list<Context*>& finished, utime_t no
>  
>    if (dir->is_dirty())
>      dir->mark_clean();
> -  
> -  // discard most dir state
> -  dir->state &= CDir::MASK_STATE_EXPORT_KEPT;  // i only retain a few things.
>  
>    // suck up all waiters
>    dir->take_waiting(CDir::WAIT_ANY_MASK, finished);    // all dir waiters
> -- 
> 1.8.1.4
> 
> 
