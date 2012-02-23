From: Sage Weil <sage@newdream.net>
Subject: Re: I found some problem in CRUSH code
Date: Thu, 23 Feb 2012 10:54:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202231052480.31303@cobra.newdream.net>
References: <4F3BB84E.50209@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38180 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2BWSyL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 13:54:11 -0500
In-Reply-To: <4F3BB84E.50209@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ZhuRongze <zrz4ceph@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Yes, that's a bug... Those ='s should be -, as with the straw bucket type.  
Opened http://tracker.newdream.net/issues/2096

Thanks!  This'll be fixed in v0.43.
sage


On Wed, 15 Feb 2012, ZhuRongze wrote:

> Hi,
> 
> The function crush_adjust_tree_bucket_item_weight in
> ceph-0.41/src/crush/builder.c seem to  have a bug. The argument weight is no
> use, because it is assigned .
> --------------------------------------------------------------------
> int crush_adjust_tree_bucket_item_weight(struct crush_bucket_tree *bucket, int
> item, int weight)
> {
>     int diff;
>     int node;
>     unsigned i, j;
>     unsigned depth = calc_depth(bucket->h.size);
> 
>     for (i = 0; i < bucket->h.size; i++) {
>         if (bucket->h.items[i] == item)
>             break;
>     }
>     if (i == bucket->h.size)
>         return 0;
> 
>     node = crush_calc_tree_node(i);
>     diff = weight = bucket->node_weights[node];
>     bucket->node_weights[node] = weight;
>     bucket->h.weight += diff;
> 
>     for (j=1; j<depth; j++) {
>         node = parent(node);
>         bucket->node_weights[node] += diff;
>     }
> 
>     return diff;
> 
> --------------------------------------------------------------------
> The function crush_adjust_list_bucket_item_weight also have a same problem.
> 
> -ZhuRongze
> 
