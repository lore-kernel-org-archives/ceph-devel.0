From: Naveen <Naveen.Chandrasekaran@radisys.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Thu, 12 May 2016 09:32:21 +0000 (UTC)
Message-ID: <loom.20160512T112356-917@post.gmane.org>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org> <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35445 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbcELJca (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 12 May 2016 05:32:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1b0myp-0007K9-UZ
	for ceph-devel@vger.kernel.org; Thu, 12 May 2016 11:32:28 +0200
Received: from 14.141.44.130.Static-Bangalore.tcl.net.in ([14.141.44.130.Static-Bangalore.tcl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 11:32:27 +0200
Received: from Naveen.Chandrasekaran by 14.141.44.130.Static-Bangalore.tcl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 12 May 2016 11:32:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:


> > > My question is:
> > > The SCSI LLD would support both read /write entry points for I/O 
> > > requests issued by the filesystem/block I/O but they also support 
some
> > > custom requests using IOCTLs. So how can ceph support issuing of 
such 
> > > IOCTL requests to the device if user issues such request. Say for 
> > > example power cycling the drive etc. It can also be a passthro 
request 
> > > down to the device.
> 
> Can you give an example of such an operation?
> 
> In general, any operation is generalized at the librados level. 
> For example, in order to get write same and cmpxchg block operations, 
we 
> added librados operations with similar semantics and implement them 
there.  
> It is unlikely that passing a complex operation down to the SCSI layer 
> will work in unison with the other steps involved in committing 
> an operation (e.g., updating metadata indicating the object 
> version has changed).
> 
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

Thanks for the response Sage. Example IOCTL operations would be like 
downloading a new FW to the drive/HBA, task management requests like 
Hard reset, power cycling the drive, issue a SAS/SMP/STP pass thro 
command to the drive for querying etc. All these would have to be 
initiated and go through ceph (if supported) and not bypassing it. 

I asked a related question in another post too: Can a physical disk 
(/dev/sda1) assigned to a ceph OSD object be continued to used by other 
apps in the system to issue I/O directly via (/dev/sda1) interface? Does 
ceph prevent it, as such operations may corrupt data?


Thanks in advance,
naveen

