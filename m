From: Sage Weil <sage@newdream.net>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Wed, 11 May 2016 08:41:41 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54333 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcEKMl3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2016 08:41:29 -0400
In-Reply-To: <loom.20160511T061343-334@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Naveen <Naveen.Chandrasekaran@radisys.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 11 May 2016, Naveen wrote:
> Naveen <Naveen.Chandrasekaran <at> radisys.com> writes:
> > Hi,
> > 
> > I'm new to ceph and trying to find if on CentOS there is a way to 
> issue 
> > IOCTL or similar custom requests (other than fops request like OS 
> issued 
> > read/write requests) from ceph OSD/RBD to the underlying SCSI LLD. 
> > From initial reading of docs it looks like in the I/O stack 
> user/client 
> > issued I/Os would reach the actual device as below:
> > 
> > Client I/O req
> >  VFS
> >   ceph fs
> >    Ceph OSD daemon
> >      RBD
> >       SCSI midlayer
> >        SCSI LLD (say mpt3sas)
> >          Disk
> > 
> > Ref: 
> > 
> https://en.wikipedia.org/wiki/NVM_Express#/media/File:IO_stack_of_the_Li
> > nux_kernel.svg
> > 
> > My question is:
> > The SCSI LLD would support both read /write entry points for I/O 
> > requests issued by the filesystem/block I/O but they also support some
> > custom requests using IOCTLs. So how can ceph support issuing of such 
> > IOCTL requests to the device if user issues such request. Say for 
> > example power cycling the drive etc. It can also be a passthro request 
> > down to the device.

Can you give an example of such an operation?

In general, any operation is generalized at the librados level. 
For example, in order to get write same and cmpxchg block operations, we 
added librados operations with similar semantics and implement them there.  
It is unlikely that passing a complex operation down to the SCSI layer 
will work in unison with the other steps involved in committing 
an operation (e.g., updating metadata indicating the object 
version has changed).

sage

