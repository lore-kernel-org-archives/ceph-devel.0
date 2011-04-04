From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: increase duplication level decrease performance
Date: Tue, 05 Apr 2011 02:28:54 +0300
Message-ID: <4D9A5436.50706@ufm.su>
References: <loom.20110404T235336-22@post.gmane.org> <056A9574715F491489130619CBB23989@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:38500 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755591Ab1DDXgL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Apr 2011 19:36:11 -0400
In-Reply-To: <056A9574715F491489130619CBB23989@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 04/05/2011 01:52 AM, Gregory Farnum wrote:
> Data replicas don't service reads unless you specifically configure it for that (it doesn't provide POSIX semantics if you do that), and each replica needs to get the data written before it's considered safe. In your case you're doing a dd, which is a write to disk, so you're increasing how much data needs to get sent over the network and written to disk by increasing replication.
>
> Without knowing more about your setup though we can't tell exactly why the performance is dropping as it is. Some possibilities:
> 1) You have a very small number of OSDs, so you're saturating the NIC on the primaries
> 2) You have a very small number of OSDs, so you're saturating the disk on all of them (this is particularly likely if you've got the journal on the same drive as the main store, since that's an automatic 50% cut in disk throughput).
> 3) Everything is connected via one cheap switch, which can't handle the traffic.
> 4) You've got some very slow OSDs, which will slow down each Placement Group they're a member of (and with higher replication levels you will hit them more often).
> etc
>
Many thanks for your reply.

If I correct understood - the maximum write speed to the file system in 
the ideal case is the network bandwidth from the client? Or bandwidth 
divided by the number of copies?

How much OSDs recommended for 3 replicas?

P.S. without documentation have to ask stupid questions.:)

