From: Sage Weil <sage@inktank.com>
Subject: Re: [RFC] Inline data support for Ceph
Date: Sat, 23 Feb 2013 08:25:09 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302230817170.26331@cobra.newdream.net>
References: <tencent_135BE907506ADB755BF2E58C@qq.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50730 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171Ab3BWQZJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Feb 2013 11:25:09 -0500
In-Reply-To: <tencent_135BE907506ADB755BF2E58C@qq.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-2022-JP?Q?=1B$B=5DjsU=1B=28J?= <wangli@kylinos.com.cn>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

On Sat, 23 Feb 2013, ?? wrote:
> Hi there,
>    We have a team working on Ceph optimization, for the purpose of integrating with OpenStack.
>    Currently, Ceph could make use of the inline data feature implemented in the local file system, such as btrfs. However, we think it maybe better to implement inline data at a higher level, i.e, let Ceph aware. Since it could save the client the calculation of object location and communication with the OSDs. It hopefully will receive a good IO speedup for small files, with a slightly heavier load for MDS. 
>     We have worked out a plan to do it, and the job is ongoing, and we are wondering the community 's response to this job and its fate for inclusion, comments are appreciated.

This sounds very interesting!  As long as it is an optional size 
threshold to control how much data is stuff in the inode/on the mds, I 
think it's a fine idea.  My main concern is that we also think about other 
future changes while extending the protocol and data types.

Namely: content addressible storage/dedup.  One idea we've kicked around 
in the past is to option convert existing data in the $ino.$block objects 
into chunks that are named by their content hash.  In that scenario, the 
MDS would need to store a list/map of offsets to hashes and pass that to 
the client so that it can read the data.  That storage strategy does not 
lend itself to overwrites, though, so the thought is to conceptually have 
the data stored in "layers", where the normal vanilla striping is the top 
layer, the dedup hash tree is a lower layer, and an overwrite fill in a 
portion of the upper layer that obscures the lower layer... eventually 
allowing the obscured region of the lower layer to be released or requeued 
for dedup.

In the context of this change, it would be nice to see the data types 
describing the content to be generalized in some data type(s) that can be 
easily extended in the future.  Maybe a "data description" type, with a 
code indicating whether it is inline, 'normal', for (in the future) some 
other scheme.

Another interesting question is how the client will query that content.  
Currrently the MDS passes all metadata to the client aggressively (e.g., 
on readdir and lookup/stat).  For a file with a potentially largeish data 
payload, it may make sense to have another op that lets the client 
explicitly query it.  Getting it to all behave with the cap bits may be 
tricky.

sage
