From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: AIX client for ceph cluster?
Date: Sat, 04 May 2013 21:15:05 -0700
Message-ID: <km4mc6$9ea$1@ger.gmane.org>
References: <5183625B.8080509@tnsoft.com.cn> <001501ce47ce$236a09b0$6a3e1d10$@com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57536 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab3EEEPW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 5 May 2013 00:15:22 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UYqM3-0006Ir-He
	for ceph-devel@vger.kernel.org; Sun, 05 May 2013 06:15:19 +0200
Received: from rain.gmane.org ([80.91.229.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 05 May 2013 06:15:19 +0200
Received: from eternaleye by rain.gmane.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sun, 05 May 2013 06:15:19 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

dennis chen wrote:

> Hi All,
> 
> Recently I want to use IBM AIX as the ceph client to take use of the
> cephFS and rbd service from ceph,
> but after some investigation, seem there's no support for AIX as the
> ceph client. Is there some clues about this? or is there some workaround
> that I can map a block device created
> from ceph cluster to the AIX system client?

If you have a reasonably-recent Linux box and are using the v1 metadata 
format for RBD, you ought to be able to use the RBD kernel driver and re-
export the RBD device over some variant of SCSI (iSCSI, SCSI over FC, etc).

If you are using v2 metadata or don't have a recent Linux box, you may be 
able to run a QEMU virtual machine, using the QEMU RBD support to bring the 
disk into the VM and Linux's SCSI target code to export it as above.

Another possible solution would be to use qemu-nbd to bypass needing a 
virtual machine, but I'm not at all sure of its performance/stability 
characteristics, nor whether AIX has the ability to access NBD devices.

Note that all of these are almost certain to impair both resilience and 
performance compared to accessing it directly, but there really isn't much 
for AIX.

As far as CephFS goes, there is a FUSE client, although I suspect AIX 
doesn't support FUSE. The only other option I can think of is to reexport it 
as another filesystem from another machine - there's ongoing efforts to 
support exporting CephFS via the Ganesha NFS server and the Samba SMB/CIFS 
server.


