From: Sage Weil <sage@newdream.net>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Thu, 12 May 2016 08:37:01 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605120832420.23446@cpach.fuggernut.com>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org> <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com> <loom.20160512T112356-917@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60694 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbcELMgt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2016 08:36:49 -0400
In-Reply-To: <loom.20160512T112356-917@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Naveen <Naveen.Chandrasekaran@radisys.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 12 May 2016, Naveen wrote:
> Sage Weil <sage <at> newdream.net> writes:
> 
> 
> > > > My question is:
> > > > The SCSI LLD would support both read /write entry points for I/O 
> > > > requests issued by the filesystem/block I/O but they also support 
> some
> > > > custom requests using IOCTLs. So how can ceph support issuing of 
> such 
> > > > IOCTL requests to the device if user issues such request. Say for 
> > > > example power cycling the drive etc. It can also be a passthro 
> request 
> > > > down to the device.
> > 
> > Can you give an example of such an operation?
> > 
> > In general, any operation is generalized at the librados level. 
> > For example, in order to get write same and cmpxchg block operations, 
> we 
> > added librados operations with similar semantics and implement them 
> there.  
> > It is unlikely that passing a complex operation down to the SCSI layer 
> > will work in unison with the other steps involved in committing 
> > an operation (e.g., updating metadata indicating the object 
> > version has changed).
> > 
> > sage
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
> Thanks for the response Sage. Example IOCTL operations would be like 
> downloading a new FW to the drive/HBA, task management requests like 
> Hard reset, power cycling the drive, issue a SAS/SMP/STP pass thro 
> command to the drive for querying etc. All these would have to be 
> initiated and go through ceph (if supported) and not bypassing it.

Ah.  I think these kind of management functions should be performed while 
the ceph-osd daemon for that drive is offline.  We would probably want 
some hardware management layer that coexists with ceph or that perhaps has 
some minimal integration with the ceph osds to do this sort of thing.  
It's not something that a client (user) would initiate, though.
 
> I asked a related question in another post too: Can a physical disk 
> (/dev/sda1) assigned to a ceph OSD object be continued to used by other 
> apps in the system to issue I/O directly via (/dev/sda1) interface? Does 
> ceph prevent it, as such operations may corrupt data?

It depends on what privileges the other app has.  If it's root or user 
ceph, it can step all over the disk (and the rest of the system) and wreak 
havoc.  With the current backend, we are storing data as files, so you 
could have other apps using other directories on the file system--this is 
generally a bad idea for real deployments, though, as performance and disk 
utilization will be unpredictable.

sage
