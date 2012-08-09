From: Sage Weil <sage@inktank.com>
Subject: Re: accident corruption in osdmap
Date: Thu, 9 Aug 2012 08:53:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208090852010.27600@cobra.newdream.net>
References: <60E83269D669544E8069A09CB69135EA01C298@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53375 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031231Ab2HIPyA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 11:54:00 -0400
In-Reply-To: <60E83269D669544E8069A09CB69135EA01C298@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org

On Thu, 9 Aug 2012, Eric_YH_Chen@wiwynn.com wrote:
> Dear all:
> 
> My Environment:  two servers, and 12 hard-disk on each server.
>                   Version: Ceph 0.48, Kernel: 3.2.0-27
> 
>  We create a ceph cluster with 24 osd, 3 monitors
>  Osd.0 ~ osd.11 is on server1
>  Osd.12 ~ osd.23 is on server2
>  Mon.0 is on server1
>  Mon.1 is on server2
>  Mon.2 is on server3 which has no osd
> 
> We create a rbd device and mount it as ext4 file system. 
> During read/write data on the rbd device, one of the storage server is shutdown by accident. 
> After reboot the server, we cannot access the rbd device any more.
> One of the log shows the osdmap is corrupted.
> 
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998582] libceph: corrupt inc osdmap epoch 78 off 98 (ffffc9000177d07e of ffffc9000177d01c-ffffc9000177edf2)
> 
> We would like to know what kind of scenario would cause the corruption of osdmap and how to avoid it?
> It seems that osdmap corruption cannot be recovered by the ceph cluster itself.

Which kernel version are you running?

> Is it the same issue with http://tracker.newdream.net/issues/2446?
> In which version of kernel that we can find this patch? Thanks!

If it is that issue, simply restarting the client is a workaround.  It may 
crop up again on a newer epoch as the cluster recovers/rebalances data, 
but in each case a client restart will get past it.

If that doesn't work, please attach a copy of the incremental osdmap 
($mon_data/osdmap/78 from one of your monitors) and we can see what the 
actual corruption is.

Thanks!
sage

> 
> 
> ============= /var/log/kern.log =================================================================
> Aug  5 15:31:44 ubuntu-002 kernel: [78240.712542] libceph: osd11 down
> Aug  5 15:31:49 ubuntu-002 kernel: [78244.817151] libceph: osd12 down
> Aug  5 15:31:52 ubuntu-002 kernel: [78248.151815] libceph: osd13 down
> Aug  5 15:31:52 ubuntu-002 kernel: [78248.151913] libceph: osd14 down
> Aug  5 15:31:53 ubuntu-002 kernel: [78249.250991] libceph: get_reply unknown tid 96452 from osd7
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833033] libceph: osd15 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833037] libceph: osd16 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833039] libceph: osd17 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833040] libceph: osd18 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833042] libceph: osd19 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833062] libceph: osd20 down
> Aug  5 15:31:59 ubuntu-002 kernel: [78254.833064] libceph: osd21 down
> Aug  5 15:36:46 ubuntu-002 kernel: [78541.813963] libceph: osd11 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811236] libceph: osd12 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811238] libceph: osd13 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811264] libceph: osd14 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811265] libceph: osd15 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811266] libceph: osd16 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811271] libceph: osd17 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811272] libceph: osd18 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811273] libceph: osd19 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811314] libceph: osd20 weight 0x0 (out)
> Aug  5 15:37:09 ubuntu-002 kernel: [78564.811315] libceph: osd21 weight 0x0 (out)
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998582] libceph: corrupt inc osdmap epoch 78 off 98 (ffffc9000177d07e of ffffc9000177d01c-ffffc9000177edf2)
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998737] osdmap: 00000000: 05 00 70 d6 52 f9 b3 cc 44 c5 a2 eb c1 33 1d a2  ..p.R...D....3..
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998739] osdmap: 00000010: 45 3d 4e 00 00 00 b3 22 1e 50 d0 b3 f3 2d ff ff  E=N....".P...-..
> Aug  5 15:37:24 ubuntu-002 kernel: [78579.998742] osdmap: 00000020: ff ff ff ff ff ff 00 00 00 00 00 00 00 00 ff ff  ................
> ...
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
