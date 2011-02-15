From: Sage Weil <sage@newdream.net>
Subject: Re: Clarification on role of PGs
Date: Tue, 15 Feb 2011 12:35:46 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102151221480.11846@cobra.newdream.net>
References: <20110215201949.GB14510@dreamer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53361 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab1BOUe3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Feb 2011 15:34:29 -0500
In-Reply-To: <20110215201949.GB14510@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

There are a few reasons.  At the most basic level, grouping things into 
PGs (you might think of them as "shards" of a pool) limits metadata and 
tracking.  Calculating the mapping is pretty cheap but not computationally 
free; it also helps us there.

A better answer has to do with reliability and the probability of failure 
loss.  If we _independently_ calculate a placement of an object, then it 
doesn't take long before you can pick any two (or even three) nodes in the 
system and there will be object stored by exactly those two nodes.  That 
means that _any_ double failure guarantees you will lose some data.  But 
generally speaking we do want replication to be declustered because it 
allows massively parallel recovery and (in general) is a reliability 
win(*).  As a practical matter, we want to balance those two things and 
mitigate when possible by imposing some order (e.g. separating replicas 
across failure domains).  PGs are the tool to do that.

They are also nice when you have, say, a small pool with a small number of 
objects.  You can break in into a small number of PGs and talk to a small 
number of OSDs (instead of talking to, say, 10 OSDs to read/write 10 
object.

From a more practical standpoint, PGs are a simple abstraction upon which 
to implement all the peering and syncrhonization between OSDs.  The map 
update processing _only_ has to recalculate mappings for the PGs currently 
stored locally, not for every single object stored locally.  And sync is 
in terms of the PG version for the PGs shared between a pair of OSDs, not 
the versions of every object they share.  The peering protocols are a 
delicate balance between ease of synchronization, simplicity, and 
minimization of centralized metadata.

sage


(* If you do the math, it's actually a wash for 2x.  The probability of 
any data loss is the same (although you will lose some data).  Once you 
factor in factors at the margins, declustered replication is a slight win.  
If you look at the expected _amount_ of data lost, declustering is always 
a win.  See Qin Xin's paper on the publications page for more info.)



On Tue, 15 Feb 2011, Tommi Virtanen wrote:

> Hi. I'm reading the thesis, and wondering what the thinking is behind
> how Ceph uses the placement groups (PGs).
> 
> It seems that CRUSH is used for a deterministic, pseudorandom mapping,
> object_id --> pg --> osds. I'm wondering why the extra level of PGs
> was felt desirable, why that isn't just object_id --> osds.
> 
> Colin explained on IRC that the primary OSD for a PG is responsible
> for some managerial duties, but that just tells me *how* PGs are used;
> not *why*. Surely you could organize these responsibilities
> differently, e.g. manage replication of an object on an
> object-by-object basis, by the primary OSD for that object.
> 
> -- 
> :(){ :|:&};:
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
