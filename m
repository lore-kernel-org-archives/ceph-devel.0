From: Sage Weil <sage@newdream.net>
Subject: Re: OSD behaviour when an i/o error occurs
Date: Wed, 6 Sep 2017 16:44:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709061641330.18091@piezo.novalocal>
References: <CAL2-6bKnuoT5Fj7+LXepwy8eDve+VXQmtEqrDX3Bn55J2ESKQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52150 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754245AbdIFQoR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Sep 2017 12:44:17 -0400
In-Reply-To: <CAL2-6bKnuoT5Fj7+LXepwy8eDve+VXQmtEqrDX3Bn55J2ESKQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 6 Sep 2017, Vincent Godin wrote:
> Hello,
> 
> I'd like to understand the behaviour of an OSD daemon when an I/O
> error occurs while reading and while writing.
> We had some I/O errors while reading during deep-scrub on one OSD and
> it's lead to hold all client's requests
> Ceph version : Jewel 10.2.6
> faulty OSD is a raid 0 on one SATA Disk on a HP SL4540 host
> 
> Is there a normal process of handling a I/O error by Ceph ? Is this
> probleme linked to my hardware config. The corrupted sector seems not
> take in account by the hardware so the error can re-occur a lot of
> time on the same sector (maybe a problem with the raid0 between ceph
> and the disk)
> 
> In the dmesg of the host, we can see the error :
> 
> sd 0:1:0:22: [sdw] tag#22 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> sd 0:1:0:22: [sdw] tag#22 Sense Key : Medium Error [current]
> sd 0:1:0:22: [sdw] tag#22 Add. Sense: Unrecovered read error
> sd 0:1:0:22: [sdw] tag#22 CDB: Read(16) 88 00 00 00 00 00 2e 15 24 e0
> 00 00 01 00 00 00
> blk_update_request: critical medium error, dev sdw, sector 773137632
> hpsa 0000:08:00.0: scsi 0:1:0:22: resetting logical Direct-Access HP
> LOGICAL VOLUME RAID-0 SSDSmartPathCap- En- Exp=1
> hpsa 0000:08:00.0: scsi 0:1:0:22: reset logical completed successfully
> Direct-Access HP LOGICAL VOLUME RAID-0 SSDSmartPathCap- En- Exp=1
> sd 0:1:0:22: [sdw] tag#10 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> sd 0:1:0:22: [sdw] tag#10 Sense Key : Medium Error [current]
> sd 0:1:0:22: [sdw] tag#10 Add. Sense: Unrecovered read error
> sd 0:1:0:22: [sdw] tag#10 CDB: Read(16) 88 00 00 00 00 01 e1 39 3c 00
> 00 00 01 00 00 00
> blk_update_request: critical medium error, dev sdw, sector 8073591808
> 
> In the OSD log (with a standard level of logging), we can only see the
> number of slow requests raising (before the system alarm) and a lot of
> timeout of osd_op_tp thread then OSD is marked down by the others.
> Nothing on the failed I/O

It sounds like if the IO had returned sooner with an error (before we hit 
the internal timeout) then we would have tried to do something, but in 
this case we didn't survive long enough to get there.  During scrub we 
note EIO and mark the PG as needing repair, and during read operations we 
try to recover from another replica or EC shards.

sage
