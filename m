From: Sage Weil <sage@newdream.net>
Subject: Re: NFS over Ceph
Date: Mon, 23 Apr 2012 20:01:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204231958020.9820@cobra.newdream.net>
References: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47109 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab2DXDBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Apr 2012 23:01:08 -0400
In-Reply-To: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Calvin Morrow <calvin.morrow@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 23 Apr 2012, Calvin Morrow wrote:
> I've been testing a couple different use scenarios with Ceph 0.45
> (two-node cluster, single mon, active/standby mds).  I have a pair of
> KVM virtual machines acting as ceph clients to re-export iSCSI over
> RBD block devices, and also NFS over a Ceph mount (mount -t ceph).
> 
> The iSCSI re-export is going very well.  So far I haven't had any
> issues to speak of (even while testing Pacemaker based failover).
> 
> The NFS re-export isn't going nearly as well.  I'm running into
> several issues with reliability, speed, etc.  To start with, file
> operations seem painstakingly long.  Copying over multiple 20 Kb files
> takes  > 10 seconds per file.  "dd if=/dev/zero of='.... goes very
> fast once the data transfer starts, but the actual opening of the file
> can take nearly as long (or longer depending on size).

Can you try with the 'async' option in your exports file?  I think the 
main problem with the slowness is because of what nfsd is doing with 
syncs, but want to confirm that.

Generally speaking, there is an unfortunate disconnect between the NFS and 
Ceph metadata protocols.  Ceph tries to do lots of operations and sync 
periodically and on-demand (e.g., when you fsync() a directory).  NFS, 
OTOH, says you should sync every operation, which is usually pretty 
horrible for performance unless you have NVRAM or an SSD or something.

We haven't invested much time/thought into what the best behavior should 
be, here... NFS is pretty far down are list at the moment.

sage

> 
> I've also run into cases where the directory mounted as ceph
> (/mnt/ceph) "hangs" on the NFS server requiring a reboot of the NFS
> server.
> 
> That said, are there any special recommendations regarding exporting
> Ceph through NFS?  I know that in the wiki and also (still present as
> of 3.3.3) kernel source indicates:
> 
> * NFS export support
> *
> * NFS re-export of a ceph mount is, at present, only semireliable.
> * The basic issue is that the Ceph architectures doesn't lend itself
> * well to generating filehandles that will remain valid forever.
> 
> Should I be trying this a different way?  NFS export of a filesystem
> (ext4 / xfs) on RBD?  Other options?  Also, does the filehandle
> limitation specified above apply to more than NFS (such as a KVM image
> using a file on a ceph mount for storage backing)?
> 
> Any insight would be appreciated.
> 
> Calvin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
