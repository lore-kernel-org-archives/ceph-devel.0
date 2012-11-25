From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: sort dentries when committing dir fragment
Date: Sun, 25 Nov 2012 14:32:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211251430290.23552@cobra.newdream.net>
References: <1353845850-14187-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42877 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab2KYWcs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 17:32:48 -0500
In-Reply-To: <1353845850-14187-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

I pushed an alternative approach to wip-tmap.

This sorting is an artifact of tmap's crummy implementation, and the mds 
workaround will need to get reverted when we switch to omap.  Instead, fix 
tmap so that it will tolerate unsorted keys.  (Also, drop the ENOENT on rm 
on missing key.)

Eventually we can deprecate and remove tmap entirely...

What do you think?
sage


On Sun, 25 Nov 2012, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Currently ceph mds uses tmap to store dir fragments. Dentry_key_t's
> string representation is used as key for the tmap. When writing or
> updating a tmap, the OSDs expect the keys to be provided in ascending
> order. Current code encodes dentries by the order of dentry_key_t(s)
> when committing dir fragment. The problem here is that we may get
> different results when comparing dentry_key_t(s) and their string
> representations. So the MDS may send data/commands sorted in the
> wrong order to the OSDs. It confuses the OSDs and causes corruption.
> 
> Comparing dentry_key_t(s) and their string representations gives
> different results only when name string in one dentry_key_t is prefix
> of name string in another dentry_key_t. So the fix is checking the
> special case and re-sorting dentries that are in the wrong order.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/CDir.cc    | 154 ++++++++++++++++++++++++++++++++++++++++++-----------
>  src/mds/mdstypes.h |  16 +++---
>  2 files changed, 130 insertions(+), 40 deletions(-)
> 
> diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
> index 2b4f7c7..e724e61 100644
> --- a/src/mds/CDir.cc
> +++ b/src/mds/CDir.cc
> @@ -1720,24 +1720,65 @@ CDir::map_t::iterator CDir::_commit_full(ObjectOperation& m, const set<snapid_t>
>    ::encode(fnode, header);
>    max_write_size -= header.length();
>  
> +  /*
> +   * We may get different results when comparing dentry_key_t(s) and their
> +   * string representations. It happens only when name string in one dentry_key_t
> +   * is prefix of name string in another dentry_key_t. Tmap uses dentry_key_t's
> +   * string representation as key. When writing or updating a tmap, the osd
> +   * expects the keys to be provided in ascending order. So we need re-sort
> +   * the dentries here.
> +   */
> +  map<string, CDentry*> pending_items;
> +
>    map_t::iterator p = items.begin();
> -  while (p != items.end() && bl.length() < max_write_size) {
> -    CDentry *dn = p->second;
> -    p++;
> -    
> -    if (dn->linkage.is_null()) 
> -      continue;  // skip negative entries
> +  while ((p != items.end() || pending_items.size()) && bl.length() < max_write_size) {
> +    if (p != items.end()) {
> +      CDentry *dn = p->second;
> +      p++;
>  
> -    if (snaps && dn->last != CEPH_NOSNAP &&
> -	try_trim_snap_dentry(dn, *snaps))
> -      continue;
> -    
> -    n++;
> +      if (dn->linkage.is_null())
> +	continue;  // skip negative entries
> +
> +      if (snaps && dn->last != CEPH_NOSNAP &&
> +	  try_trim_snap_dentry(dn, *snaps))
> +	continue;
> +
> +      n++;
> +
> +      if (pending_items.empty()) {
> +	int len = 0;
> +	if (p != items.end())
> +	  len = min(dn->name.length(), p->second->name.length());
> +	if (p == items.end() || dn->name.compare(0, len, p->second->name, 0, len) < 0) {
> +	  _encode_dentry(dn, bl, snaps);
> +	} else {
> +	  pending_items[dn->key().str()] = dn;
> +	}
> +	continue;
> +      }
> +
> +      pending_items[dn->key().str()] = dn;
> +      if (p != items.end()) {
> +	string& last_pending = pending_items.rbegin()->second->name;
> +	int len = min(last_pending.length(), p->second->name.length());
> +	if (last_pending.compare(0, len, p->second->name, 0, len) >= 0)
> +	  continue;
> +      }
> +    }
> +
> +    for (map<string, CDentry*>::iterator it = pending_items.begin();
> +	 it != pending_items.end(); it++) {
> +      CDentry *dn = it->second;
> +      _encode_dentry(dn, bl, snaps);
> +    }
>  
> -    _encode_dentry(dn, bl, snaps);
> +    if (bl.length() > max_write_size)
> +      break;
> +
> +    pending_items.clear();
>    }
>  
> -  if (p != items.end()) {
> +  if (p != items.end() || pending_items.size()) {
>      assert(bl.length() > max_write_size);
>      return _commit_partial(m, snaps, max_write_size);
>    }
> @@ -1790,31 +1831,82 @@ CDir::map_t::iterator CDir::_commit_partial(ObjectOperation& m,
>    if(last_committed_dn != map_t::iterator())
>      p = last_committed_dn;
>  
> -  while (p != items.end() && finalbl.length() < max_write_size) {
> -    CDentry *dn = p->second;
> -    ++p;
> -    
> -    if (snaps && dn->last != CEPH_NOSNAP &&
> -	try_trim_snap_dentry(dn, *snaps))
> -      continue;
> +  // see comments in _commit_full()
> +  map_t::iterator next_dn = p;
> +  map<string, CDentry*> pending_items;
>  
> -    if (!dn->is_dirty())
> -      continue;  // skip clean dentries
> +  while ((p != items.end() || pending_items.size()) && finalbl.length() < max_write_size) {
> +    if (p != items.end()) {
> +      CDentry *dn = p->second;
> +      ++p;
>  
> -    if (dn->get_linkage()->is_null()) {
> -      dout(10) << " rm " << dn->name << " " << *dn << dendl;
> -      finalbl.append(CEPH_OSD_TMAP_RM);
> -      dn->key().encode(finalbl);
> -    } else {
> -      dout(10) << " set " << dn->name << " " << *dn << dendl;
> -      finalbl.append(CEPH_OSD_TMAP_SET);
> -      _encode_dentry(dn, finalbl, snaps);
> +      if (snaps && dn->last != CEPH_NOSNAP &&
> +	  try_trim_snap_dentry(dn, *snaps))
> +	continue;
> +
> +      if (!dn->is_dirty())
> +	continue;  // skip clean dentries
> +
> +      if (pending_items.empty()) {
> +	int len = 0;
> +	if (p != items.end())
> +	  len = min(dn->name.length(), p->second->name.length());
> +	if (p == items.end() || dn->name.compare(0, len, p->second->name, 0, len) < 0) {
> +	  if (dn->get_linkage()->is_null()) {
> +	    dout(10) << " rm " << dn->name << " " << *dn << dendl;
> +	    finalbl.append(CEPH_OSD_TMAP_RM);
> +	    dn->key().encode(finalbl);
> +	  } else {
> +	    dout(10) << " set " << dn->name << " " << *dn << dendl;
> +	    finalbl.append(CEPH_OSD_TMAP_SET);
> +	    _encode_dentry(dn, finalbl, snaps);
> +	  }
> +	  next_dn = p;
> +	} else {
> +	  pending_items[dn->key().str()] = dn;
> +	}
> +	continue;
> +      }
> +
> +      pending_items[dn->key().str()] = dn;
> +      if (p != items.end()) {
> +	string& last_pending = pending_items.rbegin()->second->name;
> +	int len = min(last_pending.length(), p->second->name.length());
> +	if (last_pending.compare(0, len, p->second->name, 0, len) >= 0)
> +	  continue;
> +      }
> +    }
> +
> +    bufferlist bl;
> +    for (map<string, CDentry*>::iterator it = pending_items.begin();
> +	 it != pending_items.end(); it++) {
> +      CDentry *dn = it->second;
> +      if (dn->get_linkage()->is_null()) {
> +	dout(10) << " rm " << dn->name << " " << *dn << dendl;
> +	bl.append(CEPH_OSD_TMAP_RM);
> +	dn->key().encode(bl);
> +      } else {
> +	dout(10) << " set " << dn->name << " " << *dn << dendl;
> +	bl.append(CEPH_OSD_TMAP_SET);
> +	_encode_dentry(dn, bl, snaps);
> +      }
>      }
> +
> +    if (bl.length() + finalbl.length() > max_write_size)
> +      break;
> +
> +    pending_items.clear();
> +
> +    finalbl.claim_append(bl);
> +    next_dn = p;
>    }
>  
> +  if (p == items.end() && pending_items.empty())
> +    next_dn = p;
> +
>    // update the trivialmap at the osd
>    m.tmap_update(finalbl);
> -  return p;
> +  return next_dn;
>  }
>  
>  void CDir::_encode_dentry(CDentry *dn, bufferlist& bl,
> diff --git a/src/mds/mdstypes.h b/src/mds/mdstypes.h
> index 22e754e..9c329a1 100644
> --- a/src/mds/mdstypes.h
> +++ b/src/mds/mdstypes.h
> @@ -662,20 +662,18 @@ struct dentry_key_t {
>    // encode into something that can be decoded as a string.
>    // name_ (head) or name_%x (!head)
>    void encode(bufferlist& bl) const {
> -    __u32 l = strlen(name) + 1;
> +    ::encode(str(), bl);
> +  }
> +  string str() const {
> +    string str = name;
>      char b[20];
>      if (snapid != CEPH_NOSNAP) {
>        uint64_t val(snapid);
> -      snprintf(b, sizeof(b), "%" PRIx64, val);
> -      l += strlen(b);
> +      snprintf(b, sizeof(b), "_%" PRIx64, val);
>      } else {
> -      snprintf(b, sizeof(b), "%s", "head");
> -      l += 4;
> +      snprintf(b, sizeof(b), "_%s", "head");
>      }
> -    ::encode(l, bl);
> -    bl.append(name, strlen(name));
> -    bl.append("_", 1);
> -    bl.append(b);
> +    return str + b;
>    }
>    static void decode_helper(bufferlist::iterator& bl, string& nm, snapid_t& sn) {
>      string foo;
> -- 
> 1.7.11.7
> 
> 
