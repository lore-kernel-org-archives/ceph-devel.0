From: "Nick Couchman" <Nick.Couchman@seakr.com>
Subject: Re: How are you using Ceph?
Date: Mon, 17 Sep 2012 16:47:53 -0600
Message-ID: <5057543902000099000EA573@collaborate.seakr.com>
References: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.seakr.com ([64.2.143.10]:33348 "EHLO mx1.seakr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757466Ab2IQWr4 convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:2:1>);
	Mon, 17 Sep 2012 18:47:56 -0400
Received: from mx-inside.seakr.com ([192.168.100.31])
	by mx1.seakr.com (8.13.8/8.13.8) with ESMTP id q8HMfNvS007589
	for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 16:41:24 -0600
Received: from collaborate.seakr.com (collaborate.seakr.com [192.168.100.28])
	by mx-inside.seakr.com (Postfix) with ESMTP id 61B5E44D0E
	for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 16:47:54 -0600 (MDT)
In-Reply-To: <CAHb+bZ+x3NxLBYWb-dt8CD4x4Zzud9Cqp90ug-vS=hC-O-f4wg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>, ceph-devel@vger.kernel.org

My use of Ceph is probably pretty unique in some of the aspects of where/how I'm using it.  I run an IT department for a medium-sized engineering firm.  One of my goals is to try to make the best possible use of the hardware we're deploying to users' desktops.  Often times users cannot get by with a thin client and a VM somewhere, they actually need decent hardware on the desktop.  However, when the hardware isn't being used, it's nice to be able to have access to some of the free disk space, I/O bandwidth, memory, and CPU cycles available on the hardware.  So, Ceph is part of an overall strategy for making use of the hardware.  I'm guessing most folks run it on racked servers in datacenters, but I'm distributing it across desktops.

I've started by rolling out Linux to the desktop bare metal rather than Windows.  I run openSuSE 12.1, probably moving to 12.2 here in the near-future (I have Ceph packages available and built for openSuSE 11.4, 12.1, and 12.2 on my OBS project).  I run the Xen kernel on this hardware so that I can run VMs on top of it for various purposes.  For folks who need Windows, I use Windows-based VMs on Xen.  For the types who are comfortable with switching between Linux and Windows, I use a Windows VM and then rdesktop to connect from the Linux desktop/window manager.  For the types who are only comfortable in Windows, I use VGA and PCI pass-through in Xen to pass the video card and the USB controllers to the Windows guest, making the Linux base install transparent to the end-user.

To make use of free CPU cycles, in addition to VMs, I use the latest freely-available version of the software formerly known as the Sun Grid Engine to make these desktop systems part of the batching system that allows engineers to run HPC jobs.  They mount various filesystems from our NFS servers and jobs can execute on these systems on evenings and weekends.

Ceph is a pretty recent addition to these configurations.  I wanted to find an easy way to make use of the free disk space on these systems, but in a useful way that aggregates it all together.  After looking at several distributed filesystems, Ceph came up as the one with the feature sets that made the most sense for me.  So, I've spent a bunch of time building packages, testing out Ceph, and have finally rolled it out on these two dozen Linux desktops, aggregating 100GB from each desktop's 250GB drive into a single pool that adds up to roughly 2.2TB of raw storage.  I currently do 3 replications for all of my pools in Ceph to try to protect against a desktop machine going down, getting shut down, etc., which does happen from time-to-time.  So far this has worked out pretty well, and Ceph
  seems to recover pretty well from these failures, moving blocks to different systems when necessary, then re-doing that when the systems come back online.

My next steps for this setup, including Ceph, really get into more of a private cloud infrastructure using desktop commodity hardware.  I'd like to be able to install something like Openstack or the XAPI/XCP software on these systems and centrally manage the aggregated storage along with memory and CPU with a tool like that.  This would give me the ability to deploy these inexpensive systems across the organization, but make sure they're used to their best capacity, and it also allows for great flexibility when users move from machine to machine, or VMs need to move from place to place.  I do keep a lot of my critical infrastructure in my datacenter on more traditional compute systems - a SAN, XenServer, fileservers/NAS with NFS/CIFS, etc. - but this is a good way for me to prove out the u
 sefulness and reliability of systems like Ceph and other cloud-computing concepts and then take those and apply them to increasingly complex and critical needs in my organization.

For Ceph improvements that would help me out, the ability to support POSIX and NFSv4 ACLs would be a fantastic addition.  We use these types of permissions on our main filesystems to control access better than the traditional UGO-style permissions, and I already miss it while using Ceph.  Also, I know the concept of deduplication has been discussed, and this, too, would be great.  I was actually wondering about the feasibility of implementing post-processing deduplication on Ceph, first, rather than inline deduplication - obviously this increases disk space requirements since there has to be enough to store the duplicated data, but still seems to beat no deduplication at all.  Not a huge requirement at this point, but playing with FSs that support deduplication makes me want it everywhere 
 :-).

-Nick

>>> On 2012/09/17 at 16:14, Ross Turk <ross@inktank.com> wrote: 
> Hi, all!
> 
> One of the most important parts of Inktank's mission is to spread the
> word about Ceph. We want everyone to know what it is and how to use
> it.
> 
> In order to tell a better story to potential new users, I'm trying to
> get a sense for today's deployments. We've spent the last few months
> talking to folks around the world, but I'm sure there are a few great
> stories we haven't heard yet!
> 
> If you've got a spare five minutes, I would love to hear what you're
> up to. What kind of projects are you working on, and in what stage?
> What is your workload? Are you using Ceph alongside other
> technologies? How has your experience been?
> 
> This is also a good opportunity for me to introduce myself to those I
> haven't met yet! Feel free to copy the list if you think others would
> be interested (and you don't mind sharing).
> 
> Cheers,
> Ross
> 
> --
> Ross Turk
> Ceph Community Guy
> 
> "Any sufficiently advanced technology is indistinguishable from magic."
> -- Arthur C. Clarke
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--------

This e-mail may contain confidential and privileged material for the sole use of the intended recipient.  If this email is not intended for you, or you are not responsible for the delivery of this message to the intended recipient, please note that this message may contain SEAKR Engineering (SEAKR) Privileged/Proprietary Information.  In such a case, you are strictly prohibited from downloading, photocopying, distributing or otherwise using this message, its contents or attachments in any way.  If you have received this message in error, please notify us immediately by replying to this e-mail and delete the message from your mailbox.  Information contained in this message that does not relate to the business of SEAKR is neither endorsed by nor attributable to SEAKR.
