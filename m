From: Sage Weil <sweil@redhat.com>
Subject: Re: question on OSDService::infos_oid
Date: Wed, 12 Nov 2014 05:51:08 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411120542480.24889@cobra.newdream.net>
References: <CAF7cUg3B4QwrWq=pAP+HU=rrwytp45TKChMsR_Yf_vLxgcJq0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60285 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbaKLNvJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 08:51:09 -0500
In-Reply-To: <CAF7cUg3B4QwrWq=pAP+HU=rrwytp45TKChMsR_Yf_vLxgcJq0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xinxin shu <xinxin.shu5040@gmail.com>
Cc: xinxin.shu@intel.com, ceph-devel@vger.kernel.org

On Wed, 12 Nov 2014, xinxin shu wrote:
> recently we focus on 4k random write , dump transaction on every 4k
> random write op , found that , for every 4k random write , it will
> update pg epoch and pg info on OSDService::infos_oid , we find the
> below transaction will be serialized on the infos_oid , which maybe
> not friendly to 4k random write performance . i want to if there is
> any special consideration on serializing pg epoch and info update on
> infos_oid , can we shard this to pg level ?
> 
>                 { "op_num": 1,
> 
>                   "op_name": "omap_setkeys",
> 
>                   "collection": "meta",
> 
>                   "oid": "16ef7597\/infos\/head\/\/-1",
> 
>                   "attr_lens": { "0.3c_epoch": 4,
> 
>                       "0.3c_info": 721}},

I think we did that for simplicity without thinking about locking 
parallelism.. there is no particular need to have the keys on the same 
object.  It's a bit awkward to make the change (since we need to read the 
old scheme and write the new one), but it's nothing we haven't done 
before.

Probably a better strategy is an object per PG.  But before we pick a new 
pg object in meta/ we should make sure this is the right strategy... we 
may want something that is grouped with the PG collection and is 
compatible with whatever the 'collection' concept morphs in to.

> btw , i have some question on DBObjectMap lock , currently DBObjectMap
> has several locks , cache lock , header lock
> 
> for cache lock , it seems that it is lock for header cache , but
> LRUCache has an internal lock , is it a duplicated lock?
>
> for header lock, the annotation shows that it serialize the access to
> next seq and in_use set ,  but after checking the code , header lock
> seems not just protect the in_use and next seq . my question is what
> header_lock exactly protects?

Sam, Somnath, or Haomai would have to answer that one...

sage 
