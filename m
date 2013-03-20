From: Greg Farnum <greg@inktank.com>
Subject: Re: [PATCH 03/39] mds: fix
 MDCache::adjust_bounded_subtree_auth()
Date: Wed, 20 Mar 2013 11:33:50 -0700
Message-ID: <650C36CB8C2C427EBA9CB00804C2BD28@inktank.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
 <1363531902-24909-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:54131 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab3CTSdy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Mar 2013 14:33:54 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so1143889dak.25
        for <ceph-devel@vger.kernel.org>; Wed, 20 Mar 2013 11:33:53 -0700 (PDT)
In-Reply-To: <1363531902-24909-4-git-send-email-zheng.z.yan@intel.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Yan=2C_Zheng?= <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

Reviewed-by: Greg Farnum <greg@inktank.com>


Software Engineer #42 @ http://inktank.com | http://ceph.com


On Sunday, March 17, 2013 at 7:51 AM, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> 
> There are cases that need both create new bound and swallow intervening
> subtree. For example: A MDS exports subtree A with bound B and imports
> subtree B with bound C at the same time. The MDS crashes, exporting
> subtree A fails, but importing subtree B succeed. During recovery, the
> MDS may create new bound C and swallow subtree B.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com (mailto:zheng.z.yan@intel.com)>
> ---
> src/mds/MDCache.cc (http://MDCache.cc) | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/src/mds/MDCache.cc (http://MDCache.cc) b/src/mds/MDCache.cc (http://MDCache.cc)
> index 684e70b..19dc60b 100644
> --- a/src/mds/MDCache.cc (http://MDCache.cc)
> +++ b/src/mds/MDCache.cc (http://MDCache.cc)
> @@ -980,15 +980,21 @@ void MDCache::adjust_bounded_subtree_auth(CDir *dir, set<CDir*>& bounds, pair<in
> }
> else {
> dout(10) << " want bound " << *bound << dendl;
> + CDir *t = get_subtree_root(bound->get_parent_dir());
> + if (subtrees[t].count(bound) == 0) {
> + assert(t != dir);
> + dout(10) << " new bound " << *bound << dendl;
> + adjust_subtree_auth(bound, t->authority());
> + }
> // make sure it's nested beneath ambiguous subtree(s)
> while (1) {
> - CDir *t = get_subtree_root(bound->get_parent_dir());
> - if (t == dir) break;
> while (subtrees[dir].count(t) == 0)
> t = get_subtree_root(t->get_parent_dir());
> dout(10) << " swallowing intervening subtree at " << *t << dendl;
> adjust_subtree_auth(t, auth);
> try_subtree_merge_at(t);
> + t = get_subtree_root(bound->get_parent_dir());
> + if (t == dir) break;
> }
> }
> }
> -- 
> 1.7.11.7



