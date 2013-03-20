From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Bad Blocks
Date: Wed, 20 Mar 2013 13:55:49 -0500
Message-ID: <b3fb63f5ebff9bde421043598c83d7ab@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([209.177.156.123]:56370 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab3CTTEG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 20 Mar 2013 15:04:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I would like to understand how Ceph handles and recovers from bad 
blocks.  Would someone mind explaining this to me?  It wasn't very 
apparent from the docs.

My ultimate goal to be able to get some extra life out of my disks, 
after I detect that they may be failing.  (I'm talking about those disks 
that may have a small amount of bad blocks, but otherwise seem file and 
still perform well).

Here's what I've put together:

1. BBR Hardware
     - All hard disks come with a set number of blocks that are reserved 
for remapping of failed blocks.  This is handled transparently by the 
hard disk.  The hard disk may not begin reporting failed blocks until 
all the reserved blocks are used up.

2. BBR Device Mapper Target
     - Back in the EVMS days, IBM wrote a kernel module (dm-bbr) and a 
evms plugin to manage that kernel module.  I have updated that kernel 
module to work with the 3.6.11 kernel.  I have also rewrote some 
portions of the evms plugin as a standalone bash script to allow me to 
initialize the BBR layer and start the BBR device mapper target on that 
layer.  (So far it seems to run fine, but requires more testing).

3. BTRFS
     - I've read that BTRFS can perform data scrubbing and repair 
damaged files from redundant copies.

4. CEPH
     - I've read that CEPH can perform a deep scrub to find damaged 
copies.  I assume by the distributed nature of CEPH, it can repair the 
damaged copy from the other OSDs.

One thing I am not clear on is when BTRFS / CEPH finds damaged data, 
what do they do to prevent data from being written to the same area?

Also, I'm wondering if any parts to my layered approach are redundant / 
unnecessary...  For instance if BTRFS marks the block bad internally, 
then perhaps the BBR DM Target isn't needed...


In my testing recently, I had the following setup:
   Disk -> DM-Crypt -> DM-BBR -> BTRFS -> OSD

When the OSD hit a bad block, the DM-BBR target successfully remapped 
it to one of its own reserved blocks, BTRFS then reported data 
corruption, and the OSD daemon crashed.


-- 
Thanks,
Dyweni
