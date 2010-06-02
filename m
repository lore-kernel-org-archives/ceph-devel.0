From: Sage Weil <sage@newdream.net>
Subject: Re: subdir quotas
Date: Wed, 2 Jun 2010 12:48:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006021223590.1269@cobra.newdream.net>
References: <w2ibe579e381004290204lb59c124di7a59f71bbf4ede1@mail.gmail.com>
 <Pine.LNX.4.64.1004290937110.5285@cobra.newdream.net>
 <l2nbe579e381004300827l4c695cb1g2e6ff032fddee222@mail.gmail.com>
 <Pine.LNX.4.64.1004301112010.30864@cobra.newdream.net>
 <m2obe579e381005022121z1ace49f3o188240077631f497@mail.gmail.com>
 <w2vbe579e381005022341yccbd20b5w24c66e97bbcced55@mail.gmail.com>
 <Pine.LNX.4.64.1006011206040.14408@cobra.newdream.net>
 <AANLkTimi8lrwiblFXYJIiprfy3gCZOoGu5auL3umEqA2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36522 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555Ab0FBTsX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jun 2010 15:48:23 -0400
In-Reply-To: <AANLkTimi8lrwiblFXYJIiprfy3gCZOoGu5auL3umEqA2@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 2 Jun 2010, Henry C Chang wrote:
> Yes, I am interested and that's what I am doing right now.
> In fact, we have a clone of ceph on github, and have had a "quick"
> implementation already. You can get it from:
> 
> http://github.com/tcloud/ceph/tree/folder-quota
> http://github.com/tcloud/ceph-client-standalone/tree/folder-quota

Oh, cool.  I'll take a look at this today.

> To allow switching quota on/off, we added the option/configuration on both
> client and server sides. To enable folder quota, you need to mount ceph with
> "-o folder_quota=1" on client side. On server side, you need to add
> "folder quota = 1" in the global section of ceph config file. We also
> implemented a tool to set/unset/get/list quota limits on folders.
> 
> To enforce the quota more precisely, our imlementation, however, sacrifies
> the writing throughput and introduces more traffic:
> 
> 1. We modified the max_size request-reply behaviour between client and mds.
>    Our client requests a new max_size only when endoff > max_size. (i.e., it
>    will not pre-request a larger max-size when it's approached the max_size.)
> 
> 2. Our client requests a constant 4 MB (the object size) every time. This
>    degrades the throughput significantly. (It used to request more and more.)

Is this just to reduce the amount by which we might overshoot?  I would 
try to make it a tunable, maybe ('max size slop' or something) so that it 
preserves the current doubling logic but caps it at some value, so the 
admin can trade throughput vs quota precision.  And/or we can make it also
dynamic reduce that window as the user approaches the limit.

> Anyway, it is the initial implementation. I will take your comments into
> consideration and try to revise the current implementation. Of course, I will
> need your help on rstat propagation issue 'cause I have no clue right now
> and have to dig the mds source code more to understand the existing
> implementation. :)

Sure.

> A few questions about ceph testing:
> - When will a subtree be fragmented?
> - Can I force a subtree to be framented to faciliate testing? 

By default the load balancer goes every 30 seconds.  You can turn on mds 
'thrashing' that will export random directories to random nodes (to stress 
test the migration), but that is probably overkill.

It would probably be best to add something to MDS.cc's handle_command that 
lets the admin explicit initiate a subtree migration, via something like

 $ ceph mds tell 0 export_dir /foo/bar 2    # send /foo/bar from mds0 to 2

I just pushed something to do that to unstable.. let me know if you run 
into problems with it.

> - How do I know which mds is authoritive for particular fragment?

In the mds log you'll periodically see a show_subtrees output, but that 
only shows a local view of the partition.  There isn't currently a way to 
query a running mds, though (e.g. via the 'ceph' tool)... let me think 
about that one!

sage
