From: Sage Weil <sage@newdream.net>
Subject: Re: connection management in ceph
Date: Tue, 8 Mar 2011 08:14:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103080813010.19546@cobra.newdream.net>
References: <AANLkTimQsfsBaykOsNyo6H9cMv2LL_GZDNUyuWC6Fitq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45212 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330Ab1CHQMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2011 11:12:43 -0500
In-Reply-To: <AANLkTimQsfsBaykOsNyo6H9cMv2LL_GZDNUyuWC6Fitq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Chang <heracles@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 8 Mar 2011, H Chang wrote:
> I have a question on how ceph maintains tcp connections.
> 
> As I understand, given a cluster of N osds, ceph client can
> potentially read from, and write to all N osds, if crush distributes
> data randomly across all. 

Right.

> Then does the client maintains persistent tcp connections to all osds?

The kernel client closes out idle connections.  The userspace 
implementation does not do that yet.  

> How about tcp connections among osds (for replication)?  Does each osd
> maintain persistent tcp connection to all the other osds, essentially
> forming a clique?

The OSDs maintain open connections to the nodes they peer with.  This is 
related to the number of PGs they store.  So in a 10,000 node cluster, if 
an osd has ~100 PGs, it will have ~100 peer connections (for 2x 
replication).  For a 10 node system, each node will typically peer with 
every other node.

sage
