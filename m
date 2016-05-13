From: Naveen <Naveen.Chandrasekaran@radisys.com>
Subject: Re: Issuing custom IOCTLs to SCSI LLD
Date: Fri, 13 May 2016 15:01:43 +0000 (UTC)
Message-ID: <loom.20160513T165650-666@post.gmane.org>
References: <loom.20160509T111456-471@post.gmane.org> <loom.20160511T061343-334@post.gmane.org> <alpine.DEB.2.11.1605110839390.15518@cpach.fuggernut.com> <loom.20160512T112356-917@post.gmane.org> <alpine.DEB.2.11.1605120832420.23446@cpach.fuggernut.com>,<CALe9h7fbdA5zPyva4CUSv0Mp+oG8AvCyd4bQeB2Nf4mnEfZ_jA@mail.gmail.com> <98A1E741-0CAC-49CB-9701-18932EA6381B@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbcEMPCH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 May 2016 11:02:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1b1EbG-0000Qm-II
	for ceph-devel@vger.kernel.org; Fri, 13 May 2016 17:01:59 +0200
Received: from 51.136-broadband.acttv.in ([51.136-broadband.acttv.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2016 17:01:58 +0200
Received: from Naveen.Chandrasekaran by 51.136-broadband.acttv.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 13 May 2016 17:01:58 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Handzik, Joseph <joseph.t.handzik <at> hpe.com> writes:

> 
> I was intentionally staying quiet to hear other opinions, but I agree 
that the same mechanisms I'm building
> for LED operations could extend here (within Ceph of we want it to, 
but at the very least in libstoragemgmt).
> 
> Naveen, if you have interest in helping push this along I'd encourage 
you to voice your interest over on the
> libstoragemgmt GitHub: https://github.com/libstorage/libstoragemgmt
> 
> Joe
> 
> > 
> > This is all pretty relevant to Joe Handzik's stuff:
> > https://github.com/joehandzik/ceph/commits/wip-hw-mgmt-cli
> > http://www.spinics.net/lists/ceph-devel/msg30126.html
> > 
> > The idea there though is to enable passing libstoragemgmt calls
> > through the OSD, as opposed to arbitrary SCSI operations.
> > 
> > Although libstoragemgmt is fairly young, I'm a fan of the idea that 
we
> > could use it internally within Ceph, and then have the same 
tools/libs
> > used by out-of-ceph management platforms when they want to do
> > equivalent stuff while the OSD is offline.
> > 
> > John
> > 
> > 
> >>> I asked a related question in another post too: Can a physical 
disk
> >>> (/dev/sda1) assigned to a ceph OSD object be continued to used by 
other
> >>> apps in the system to issue I/O directly via (/dev/sda1) 
interface? Does
> >>> ceph prevent it, as such operations may corrupt data?
> >> 
> >> It depends on what privileges the other app has.  If it's root or 
user
> >> ceph, it can step all over the disk (and the rest of the system) 
and wreak
> >> havoc.  With the current backend, we are storing data as files, so 
you
> >> could have other apps using other directories on the file system--
this is
> >> generally a bad idea for real deployments, though, as performance 
and disk
> >> utilization will be unpredictable.
> >> 
> >> sage

Thanks everyone for the inputs and clarifications. Looks like 
libstoragemgmt is key to lot of these feature. Will explore that next 
and add if any questions in the git.

thanks,
naveen

