From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] mds: sort dentries when committing dir fragment
Date: Mon, 26 Nov 2012 11:06:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211261059360.3409@cobra.newdream.net>
References: <1353845850-14187-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1211251430290.23552@cobra.newdream.net> <50B2D196.8010509@intel.com> <50B32E48.50403@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51092 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2KZTGw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 14:06:52 -0500
In-Reply-To: <50B32E48.50403@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 26 Nov 2012, Yan, Zheng wrote:

> On 11/26/2012 10:19 AM, Yan, Zheng wrote:
> > On 11/26/2012 06:32 AM, Sage Weil wrote:
> >> I pushed an alternative approach to wip-tmap.
> >>
> >> This sorting is an artifact of tmap's crummy implementation, and the mds 
> >> workaround will need to get reverted when we switch to omap.  Instead, fix 
> >> tmap so that it will tolerate unsorted keys.  (Also, drop the ENOENT on rm 
> >> on missing key.)
> >>
> >> Eventually we can deprecate and remove tmap entirely...
> >>
> >> What do you think?
> > 
> > This approach is cleaner than mine. But I think your fix isn't enough because
> > MDS may provide tmap contains misordered items to the TMAPPUT method. Misordered
> > items will confuse future TMAPUP. This fix is either sorting items when handling
> > TMAPPUT or searching forward for any potential misordered items when TMAP_SET
> > wants to add a new item or TMAP_RM fails to find an item.
> >
> 
> how about the patch attached below

Pushed this to wip-tmap, along with a change to TMAPPUT that verifies 
everything is fully sorted.

I'm am bit worried that looking specifically for the <foo>_ sorting 
behavior is fragile, though.  And I'm less worried about performance of 
MDS stuff on bobtail than just correctness (fixing this particular issue). 
That will probably mean we trigger a slow update frequently, particularly 
when snapshots are in use, but I'm okay with that...

sage

> 
> -----
> >From e3c4fb68dc6c7592b7f53ab7a98b561167b567df Mon Sep 17 00:00:00 2001
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> Date: Mon, 26 Nov 2012 12:28:30 +0800
> Subject: [PATCH] osd: check misordered items in TMAP
> 
> There is a bug in the MDS that causes misordered items in TMAPs
> that store dir fragments. Misordered items confuse TMAP updates.
> 
> Fix this by adding code to do_tmapup() to check if there are
> misordered items that may affect the correctness of TMAP update.
> Fall back to use do_tmapup_slow if misordered items are found.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/osd/ReplicatedPG.cc | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index 48cba10..71f5363 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -1803,8 +1803,17 @@ int ReplicatedPG::do_tmapup(OpContext *ctx, bufferlist::iterator& bp, OSDOp& osd
>  	  nkeys--;
>  	}
>  	if (!ip.end()) {
> +	  string last_key = nextkey;
> +
>  	  ::decode(nextkey, ip);
>  	  ::decode(nextval, ip);
> +
> +	  if (nextkey <= last_key) {
> +	    dout(0) << "tmapup warning: key '" << key << "' < previous key '" << last_key
> +		    << "', falling back to an inefficient (unsorted) update" << dendl;
> +	    bp = orig_bp;
> +	    return do_tmapup_slow(ctx, bp, osd_op, newop.outdata);
> +	  }
>  	} else {
>  	  have_next = false;
>  	}
> @@ -1848,6 +1857,35 @@ int ReplicatedPG::do_tmapup(OpContext *ctx, bufferlist::iterator& bp, OSDOp& osd
>        ::encode(nextkey, newkeydata);
>        ::encode(nextval, newkeydata);
>        dout(20) << "  keep " << nextkey << " " << nextval.length() << dendl;
> +
> +      /*
> +       * TMAPs for storing dir fragments may contain misordered items.
> +       * Only items corresponding to dentries that have the same name
> +       * prefix can be out of order.
> +       */
> +      size_t lastlen = nextkey.find_last_of('_');
> +      if (lastlen > 0 && lastlen != string::npos) {
> +	string last_key = nextkey;
> +	bufferlist::iterator tmp_ip = ip;
> +	while (!tmp_ip.end()) {
> +	  ::decode(nextkey, tmp_ip);
> +	  ::decode(nextval, tmp_ip);
> +
> +	  if (nextkey <= last_key) {
> +	    dout(0) << "tmapup warning: key '" << nextkey << "' < previous key '" << last_key
> +		    << "', falling back to an inefficient (unsorted) update" << dendl;
> +	    bp = orig_bp;
> +	    return do_tmapup_slow(ctx, bp, osd_op, newop.outdata);
> +	  }
> +
> +	  size_t len = nextkey.find_last_of('_');
> +	  if (len == 0 || len == string::npos)
> +	    break;
> +	  len = min(len, lastlen);
> +	  if (last_key.compare(0, len, nextkey, 0, len) < 0)
> +	    break;
> +	}
> +      }
>      }
>      if (!ip.end()) {
>        bufferlist rest;
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
