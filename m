From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: increase duplication level decrease performance
Date: Mon, 4 Apr 2011 15:52:43 -0700
Message-ID: <056A9574715F491489130619CBB23989@gmail.com>
References: <loom.20110404T235336-22@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55939 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab1DDWwr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2011 18:52:47 -0400
Received: by iwn34 with SMTP id 34so6228900iwn.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Apr 2011 15:52:46 -0700 (PDT)
In-Reply-To: <loom.20110404T235336-22@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Monday, April 4, 2011 at 2:55 PM, Fyodor Ustinov wrote:
Hi.
> 
> ceph osd pool set data size 1
> 
> dd if=/dev/zero of=aaa bs=1024000 count=4000
> 4096000000 bytes (4.1 GB) copied, 31.3153 s, 131 MB/s
> 
> ceph osd pool set data size 2
> 4096000000 bytes (4.1 GB) copied, 72.7146 s, 56.3 MB/s
> 
> ceph osd pool set data size 3
> 4096000000 bytes (4.1 GB) copied, 136.263 s, 30.1 MB/s
> 
> Why? I thought increase in the number of copies should increase the 
> performance (in the worst case does not affect).
> 
> WBR,
>  Fyodor.

Data replicas don't service reads unless you specifically configure it for that (it doesn't provide POSIX semantics if you do that), and each replica needs to get the data written before it's considered safe. In your case you're doing a dd, which is a write to disk, so you're increasing how much data needs to get sent over the network and written to disk by increasing replication.

Without knowing more about your setup though we can't tell exactly why the performance is dropping as it is. Some possibilities:
1) You have a very small number of OSDs, so you're saturating the NIC on the primaries
2) You have a very small number of OSDs, so you're saturating the disk on all of them (this is particularly likely if you've got the journal on the same drive as the main store, since that's an automatic 50% cut in disk throughput).
3) Everything is connected via one cheap switch, which can't handle the traffic.
4) You've got some very slow OSDs, which will slow down each Placement Group they're a member of (and with higher replication levels you will hit them more often).
etc

-Greg 
