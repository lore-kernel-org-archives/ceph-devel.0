From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: syncfs via syscall doesn not work
Date: Sat, 24 Nov 2012 06:34:16 +0100
Message-ID: <7D302B0D-898C-45F6-A60A-A43DB78C7479@profihost.ag>
References: <50AF31AB.1050402@profihost.ag> <alpine.DEB.2.00.1211231907330.23552@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59845 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab2KXFeU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 00:34:20 -0500
In-Reply-To: <alpine.DEB.2.00.1211231907330.23552@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

At the machine compiling? Yes!

Am 24.11.2012 um 04:07 schrieb Sage Weil <sage@inktank.com>:

> On Fri, 23 Nov 2012, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>> 
>> i've seen that next branch caontains the "Try using syscall() for syncfs if
>> not supported directly by glibc" patch. But this does not work for me.
>> 
>> I've tested this on a Debian Squeeze box with default glibc and a 3.6.7
>> Kernel.
>> 
>> The OSD gives me the following output:
>> 2012-11-23 08:55:54.650182 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
>> FIEMAP ioctl is supported and appears to work
>> 2012-11-23 08:55:54.650190 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
>> FIEMAP ioctl is disabled via 'filestore fiemap' config option
>> 2012-11-23 08:55:54.650355 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount did
>> NOT detect btrfs
>> 2012-11-23 08:55:54.650358 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
>> syncfs(2) syscall not support by glibc
>> 2012-11-23 08:55:54.650361 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount no
>> syncfs(2), must use sync(2).
>> 2012-11-23 08:55:54.650362 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
>> WARNING: multiple ceph-osd daemons on the same host will be slow
>> 2012-11-23 08:55:54.650391 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount
>> found snaps <>
>> 2012-11-23 08:55:54.652413 7f7bc7c1f780  0 filestore(/ceph/osd.11/) mount:
>> enabling WRITEAHEAD journal mode: btrfs not detected
> 
> Is SYS_syncfs defined anywhere in /usr/include?  Is the kernel headers 
> package installed?
> 
> sage
> 
> 
>> 
>> When i build ceph against a patched glibc i get:
>> 
>> 2012-11-23 09:19:39.339597 7fee3e497780  0 ceph version 0.54-676-g9d366a0
>> (9d366a0706a58b1612dd95831533c5a02b87f5fc), process ceph-osd, pid 9165
>> starting osd.11 at :/0 osd_data /ceph/osd.11/ /ceph/journal/osd.11.journal
>> 2012-11-23 09:19:39.347924 7fee3e497780  0 filestore(/ceph/osd.11/) mount
>> FIEMAP ioctl is supported and appears to work
>> 2012-11-23 09:19:39.347932 7fee3e497780  0 filestore(/ceph/osd.11/) mount
>> FIEMAP ioctl is disabled via 'filestore fiemap' config option
>> 2012-11-23 09:19:39.348111 7fee3e497780  0 filestore(/ceph/osd.11/) mount did
>> NOT detect btrfs
>> 2012-11-23 09:19:39.349415 7fee3e497780  0 filestore(/ceph/osd.11/) mount
>> syncfs(2) syscall fully supported (by glibc and kernel)
>> 2012-11-23 09:19:39.349461 7fee3e497780  0 filestore(/ceph/osd.11/) mount
>> found snaps <>
>> 2012-11-23 09:19:39.350661 7fee3e497780  0 filestore(/ceph/osd.11/) mount:
>> enabling WRITEAHEAD journal mode: btrfs not detected
>> 
>> Greets,
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
