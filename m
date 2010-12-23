From: Wido den Hollander <wido@widodh.nl>
Subject: Updated Qemu-KVM packages for Ubuntu 10.04 with RBD support
Date: Thu, 23 Dec 2010 13:15:52 +0100
Message-ID: <1293106552.2364.15.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:46338 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0LWMPx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Dec 2010 07:15:53 -0500
Received: from [192.168.6.106] (cable-191-148.zeelandnet.nl [82.176.191.148])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 7E9D47634B
	for <ceph-devel@vger.kernel.org>; Thu, 23 Dec 2010 13:15:51 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I've just updated my Qemu-KVM packages for Ubuntu 10.04, the packages
might work under Debian, but I haven't tested it, so be careful!

I backported the qemu-kvm-0.13.0 package from Ubuntu 11.04 (natty) to
10.04 (lucid) and included RBD support (From the Qemu GIT). On my test
machines this works fine, I've got a few VM's running without any
problems.

You can download the package from:

deb http://pcx.apt-get.eu/ubuntu lucid-backport unofficial

If you need the public key:

wget -O - http://www.apt-get.eu/pcextreme_archive_key.asc|apt-key add -

For those interested in my patch, it's available on
http://zooi.widodh.nl/ceph/qemu-kvm/qemu-kvm-0.13.0
+noroms/rbd-support.patch

This Qemu-KVM version should make it a bit easier to start testing RBD
with Qemu, saves you the trouble of building Qemu yourself.

I also have a backported libvirt version in the same repository, this
has support for a Virtual Disk, for example:

    <disk type='virtual' device='disk'>
      <driver name='qemu' type='rbd'/>
      <source path='rbd:rbd/alpha'/>
      <target dev='vda' bus='virtio'/>
    </disk>

This is NOT the new format which has been accepted into Qemu
( http://ceph.newdream.net/2010/12/rbd-upstream-updates/ ), but it works
for testing purposes.

Thanks,

Wido


