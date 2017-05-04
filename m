From: Sage Weil <sage@newdream.net>
Subject: Re: Blustore data consistency question when big write.
Date: Thu, 4 May 2017 13:00:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705041259350.32730@piezo.novalocal>
References: <CAN=xyVWmpqkzeqCziuxaY=qYeQBNBm6h+vqj0Ur31Az6uaXh4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54101 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdEDNAj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 May 2017 09:00:39 -0400
In-Reply-To: <CAN=xyVWmpqkzeqCziuxaY=qYeQBNBm6h+vqj0Ur31Az6uaXh4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: qi Shi <m13913886148@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 4 May 2017, qi Shi wrote:
> when bluestore bigwrite it divided into two steps:
> 1, alloc a disk space and write data to it.
> 2, update the metadata to the database(rocksdb).
> 
> How to do data consistency?
> 
> Will the following error occur?
> when write data to device sucess Osd process crushed .
> But metadata is not update to rocksdb.
> 
> So I think there are legacy data in the disk,this can cause data
> inconsistencies.

New data is always written to unused, unallocated space.  And the metadata 
that points to it is always committed after those writes are completed and 
flushed to the device.  If you crash in between, it just means the empty 
space has different garbage than it had before.

sage
