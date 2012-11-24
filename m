From: Sage Weil <sage@inktank.com>
Subject: Re: syncfs via syscall doesn not work
Date: Sat, 24 Nov 2012 09:16:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211240859340.23552@cobra.newdream.net>
References: <50AF31AB.1050402@profihost.ag> <alpine.DEB.2.00.1211231907330.23552@cobra.newdream.net> <7D302B0D-898C-45F6-A60A-A43DB78C7479@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33528 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab2KXRQQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 12:16:16 -0500
In-Reply-To: <7D302B0D-898C-45F6-A60A-A43DB78C7479@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 24 Nov 2012, Stefan Priebe - Profihost AG wrote:
> At the machine compiling? Yes!

Hmm, I just tested on my wonky wheezy machine (glibc 2.13, 3.2) and 
system(SYS_syncfs, ..) works for me.  But the #define is in libc6-dev:

vapre:src 08:57 AM $ grep -r SYS_syncfs /usr/include
/usr/include/x86_64-linux-gnu/bits/syscall.h:#define SYS_syncfs 
__NR_syncfs
vapre:src 08:57 AM $ dpkg -S /usr/include/x86_64-linux-gnu/bits/syscall.h
libc6-dev:amd64: /usr/include/x86_64-linux-gnu/bits/syscall.h
vapre:src 09:11 AM $ dpkg -l libc6-dev
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                         Version                      Description
+++-============================-============================-========================================================================
ii  libc6-dev:amd64              2.13-33                      Embedded GNU C Library: Development Libraries and Header Files

Where does SYS_syncfs come from on your machine?

sage



> 
> Am 24.11.2012 um 04:07 schrieb Sage Weil <sage@inktank.com>:
> 
> > On Fri, 23 Nov 2012, Stefan Priebe - Profihost AG wrote:
> >> Hello list,
> >> 
> >> i've seen that next branch caontains the "Try using syscall() for syncfs if
> >> not supported directly by glibc" patch. But this does not work for me.
> >> 
> >> I've tested this on a Debian Squeeze box with default glibc and a 3.6.7
> >> Kernel.
> >> 
> >> The OSD gives me the following output:
> >> 2012-11-23 08:55:54.650182 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
> >> FIEMAP ioctl is supported and appears to work
> >> 2012-11-23 08:55:54.650190 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
> >> FIEMAP ioctl is disabled via 'filestore fiemap' config option
> >> 2012-11-23 08:55:54.650355 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount did
> >> NOT detect btrfs
> >> 2012-11-23 08:55:54.650358 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
> >> syncfs(2) syscall not support by glibc
> >> 2012-11-23 08:55:54.650361 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount no
> >> syncfs(2), must use sync(2).
> >> 2012-11-23 08:55:54.650362 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
> >> WARNING: multiple ceph-osd daemons on the same host will be slow
> >> 2012-11-23 08:55:54.650391 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
> >> found snaps <>
> >> 2012-11-23 08:55:54.652413 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount:
> >> enabling WRITEAHEAD journal mode: btrfs not detected
> > 
> > Is SYS_syncfs defined anywhere in /usr/include?  Is the kernel headers 
> > package installed?
> > 
> > sage
> > 
> > 
> >> 
> >> When i build ceph against a patched glibc i get:
> >> 
> >> 2012-11-23 09:19:39.339597 7fee3e497780  0 ceph version 0.54-676-g9d366a0
> >> (9d366a0706a58b1612dd95831533c5a02b87f5fc), process ceph-osd, pid 9165
> >> starting osd.11 at :/0 osd_data /ceph/osd.11/ /ceph/journal/osd.11.journal
> >> 2012-11-23 09:19:39.347924 7fee3e497780  0 filestore(/ceph/osd.11/) mount
> >> FIEMAP ioctl is supported and appears to work
> >> 2012-11-23 09:19:39.347932 7fee3e497780  0 filestore(/ceph/osd.11/) mount
> >> FIEMAP ioctl is disabled via 'filestore fiemap' config option
> >> 2012-11-23 09:19:39.348111 7fee3e497780  0 filestore(/ceph/osd.11/) mount did
> >> NOT detect btrfs
> >> 2012-11-23 09:19:39.349415 7fee3e497780  0 filestore(/ceph/osd.11/) mount
> >> syncfs(2) syscall fully supported (by glibc and kernel)
> >> 2012-11-23 09:19:39.349461 7fee3e497780  0 filestore(/ceph/osd.11/) mount
> >> found snaps <>
> >> 2012-11-23 09:19:39.350661 7fee3e497780  0 filestore(/ceph/osd.11/) mount:
> >> enabling WRITEAHEAD journal mode: btrfs not detected
> >> 
> >> Greets,
> >> Stefan
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> 
> >> 
> 
> 
