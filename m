From: Sage Weil <sage@inktank.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 09:13:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58952 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3ASRNB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 12:13:01 -0500
In-Reply-To: <50FAC92C.8030709@bmrb.wisc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Cc: Peter Smith <peterfruits@gmail.com>, ceph-devel@vger.kernel.org

On Sat, 19 Jan 2013, Dimitri Maziuk wrote:
> On 1/19/2013 9:50 AM, Peter Smith wrote:
> 
> > 3. OS recommendation: The OS recommendation page:
> > http://ceph.com/docs/master/install/os-recommendations/#bobtail-0-56
> > says CentOS 6.3 has a default kernel with old kernel client. CentOS
> > 6.3 is our production environment.
> 
> I was unable to get ceph to run on centos 6.3 following the "5 minute quick
> start" document. I did get one machine to "unclean" cluster state using
> elrepo's kernel 3.7, but that kernel doesn't boot on most of our boxen
> (boot-time oops in pata-acpi).
> 
> It looks to me that unless inktank backports rbd.ko to 2.6.32, centos/sl users
> won't be able to test ceph for a couple of years: until centos 7.1 comes out
> and we get the chance to reimage our hardware.

If you want to use the kernel client(s), that is true: there are no plans 
to backport the client code to the ancient RHEL kernels.  Nothing prevents 
you from running the server side, though, or the userland clients 
(ceph-fuse, librbd, qemu/KVM, radosgw, etc.)

sage
