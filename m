From: Sage Weil <sage@inktank.com>
Subject: Re: Understanding Ceph
Date: Sat, 19 Jan 2013 09:38:26 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301190933000.29915@cobra.newdream.net>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com> <50FAC92C.8030709@bmrb.wisc.edu> <alpine.DEB.2.00.1301190911470.29915@cobra.newdream.net> <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59092 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab3ASRi0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 12:38:26 -0500
In-Reply-To: <CAPrNTukzfE0KNMG+Rww8FBOCFq_BZr29Kb0zQRCf0K40oX4enQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Smith <peterfruits@gmail.com>
Cc: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>, ceph-devel@vger.kernel.org

On Sun, 20 Jan 2013, Peter Smith wrote:
> Thanks for the reply, Sage and everyone.
> 
> Sage, so I can expect Ceph-rbd works well on Centos 6.3 if I only use
> it as the Cinder volume backend because the librbd in QEMU doesn't
> make use of kernel client, right?

Then the dependency is on the qemu version.  I don't remember that off the 
top of my head, or know what version rhel6 ships.  Most people deploying 
openstack and rbd are using a more modern distro (like ubuntu 12.04).

Josh would know more...

> Could you explain a bit more about what are the functions of kernel
> client? Will it influence the daily operations, such as listing
> volumes, devices by using ceph commands?

There is no kernel dependency at all for the radosgw and qemu+rbd use- 
cases.

sage


> 
> 
> 
> 
> 
> 
> On Sun, Jan 20, 2013 at 1:13 AM, Sage Weil <sage@inktank.com> wrote:
> > On Sat, 19 Jan 2013, Dimitri Maziuk wrote:
> >> On 1/19/2013 9:50 AM, Peter Smith wrote:
> >>
> >> > 3. OS recommendation: The OS recommendation page:
> >> > http://ceph.com/docs/master/install/os-recommendations/#bobtail-0-56
> >> > says CentOS 6.3 has a default kernel with old kernel client. CentOS
> >> > 6.3 is our production environment.
> >>
> >> I was unable to get ceph to run on centos 6.3 following the "5 minute quick
> >> start" document. I did get one machine to "unclean" cluster state using
> >> elrepo's kernel 3.7, but that kernel doesn't boot on most of our boxen
> >> (boot-time oops in pata-acpi).
> >>
> >> It looks to me that unless inktank backports rbd.ko to 2.6.32, centos/sl users
> >> won't be able to test ceph for a couple of years: until centos 7.1 comes out
> >> and we get the chance to reimage our hardware.
> >
> > If you want to use the kernel client(s), that is true: there are no plans
> > to backport the client code to the ancient RHEL kernels.  Nothing prevents
> > you from running the server side, though, or the userland clients
> > (ceph-fuse, librbd, qemu/KVM, radosgw, etc.)
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
