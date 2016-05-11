From: Naveen <Naveen.Chandrasekaran@radisys.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Wed, 11 May 2016 04:18:05 +0000 (UTC)
Message-ID: <loom.20160511T061343-334@post.gmane.org>
References: <loom.20160509T111456-471@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52820 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbcEKESU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 11 May 2016 00:18:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1b0LbF-0003gv-Iq
	for ceph-devel@vger.kernel.org; Wed, 11 May 2016 06:18:18 +0200
Received: from 14.141.44.130.Static-Bangalore.tcl.net.in ([14.141.44.130.Static-Bangalore.tcl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 06:18:17 +0200
Received: from Naveen.Chandrasekaran by 14.141.44.130.Static-Bangalore.tcl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2016 06:18:17 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



Naveen <Naveen.Chandrasekaran <at> radisys.com> writes:

> 
> Hi,
> 
> I'm new to ceph and trying to find if on CentOS there is a way to 
issue 
> IOCTL or similar custom requests (other than fops request like OS 
issued 
> read/write requests) from ceph OSD/RBD to the underlying SCSI LLD. 
> From initial reading of docs it looks like in the I/O stack 
user/client 
> issued I/Os would reach the actual device as below:
> 
> Client I/O req
>  VFS
>   ceph fs
>    Ceph OSD daemon
>      RBD
>       SCSI midlayer
>        SCSI LLD (say mpt3sas)
>          Disk
> 
> Ref: 
> 
https://en.wikipedia.org/wiki/NVM_Express#/media/File:IO_stack_of_the_Li
> nux_kernel.svg
> 
> My question is:
> The SCSI LLD would support both read /write entry points for I/O 
> requests issued by the filesystem/block I/O but they also support some
> custom requests using IOCTLs. So how can ceph support issuing of such 
> IOCTL requests to the device if user issues such request. Say for 
> example power cycling the drive etc. It can also be a passthro request 
> down to the device.
> 
> Appreciate the help and thanks in advance.
> 


Hi,

Still waiting for a response. Can any of the experts clarify on this?

thanks,
naveen



