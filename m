From: Calvin Morrow <calvin.morrow@gmail.com>
Subject: NFS over Ceph
Date: Mon, 23 Apr 2012 17:50:07 -0600
Message-ID: <CADxhoDTMQMrNBYE8PykjB4UCkCBmyXcUsKxnaXmfyYNbfr9-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:40051 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025Ab2DWXuI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Apr 2012 19:50:08 -0400
Received: by wgbdr13 with SMTP id dr13so76184wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Apr 2012 16:50:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I've been testing a couple different use scenarios with Ceph 0.45
(two-node cluster, single mon, active/standby mds).  I have a pair of
KVM virtual machines acting as ceph clients to re-export iSCSI over
RBD block devices, and also NFS over a Ceph mount (mount -t ceph).

The iSCSI re-export is going very well.  So far I haven't had any
issues to speak of (even while testing Pacemaker based failover).

The NFS re-export isn't going nearly as well.  I'm running into
several issues with reliability, speed, etc.  To start with, file
operations seem painstakingly long.  Copying over multiple 20 Kb files
takes  > 10 seconds per file.  "dd if=/dev/zero of='.... goes very
fast once the data transfer starts, but the actual opening of the file
can take nearly as long (or longer depending on size).

I've also run into cases where the directory mounted as ceph
(/mnt/ceph) "hangs" on the NFS server requiring a reboot of the NFS
server.

That said, are there any special recommendations regarding exporting
Ceph through NFS?  I know that in the wiki and also (still present as
of 3.3.3) kernel source indicates:

* NFS export support
*
* NFS re-export of a ceph mount is, at present, only semireliable.
* The basic issue is that the Ceph architectures doesn't lend itself
* well to generating filehandles that will remain valid forever.

Should I be trying this a different way?  NFS export of a filesystem
(ext4 / xfs) on RBD?  Other options?  Also, does the filehandle
limitation specified above apply to more than NFS (such as a KVM image
using a file on a ceph mount for storage backing)?

Any insight would be appreciated.

Calvin
