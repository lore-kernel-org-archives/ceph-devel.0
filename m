From: Sage Weil <sage@newdream.net>
Subject: Re: recommended rocksdb/rockswal sizes when using SSD/HDD
Date: Wed, 2 Aug 2017 21:32:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708022129210.20435@piezo.novalocal>
References: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1966030540-1501709555=:20435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52788 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdHBVcg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Aug 2017 17:32:36 -0400
In-Reply-To: <3D48D7F6-6383-4F9F-9728-6CB6263D0E32@teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "McFarland, Bruce" <Bruce.McFarland@Teradata.com>
Cc: Mark Nelson <mark.a.nelson@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1966030540-1501709555=:20435
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 2 Aug 2017, McFarland, Bruce wrote:
> I’m using SDD for the rocksdb/rockswal partitions and putting the data 
> on HDD’s. What is the recommended sizing for these partitions. I’ve read 
> various sizes discussed on the perf call and know that the code defaults 
> of 128MB for rocksdb is small and limits performance. What are the 
> recommended sizes for these partitions?

tl;dr: 1GB for block.wal.  For block.db, as much as you have.

For an RBD-only pool, my guess is you want around 1-2% of your total 
storage, but I'm guessing... we need to deploy a real-ish RBD workload and 
see what the ratio is in practice.  Mark can probably give us a worst-case 
value (after a long-running 4kb random-write workload).

Omap data will go to block.db (if it will fit), so for RGW clusters there 
may be more.  OTOH, the object metadata will be smaller (immutable 
objects, sequentially written), so it depends on how big your RGW objects 
are.  We have no real-world data on this yet.

sage
--8323329-1966030540-1501709555=:20435--
