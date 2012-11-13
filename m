From: Alex Jiang <alex.jiang.zju@gmail.com>
Subject: [Help] Use Ceph RBD as primary storage in CloudStack 4.0
Date: Tue, 13 Nov 2012 13:38:13 +0800
Message-ID: <CAGVY77c+mRcjh+qSJS2V2yj-snEtrA+hzp3RTy+LVkBp1CUNbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44464 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722Ab2KMFiP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Nov 2012 00:38:15 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7053499obb.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Nov 2012 21:38:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi, All

Has somebody used Ceph RBD in CloudStack as primary storage? I see
that in the new features of CS 4.0, RBD is supported for KVM. So I
tried using RBD as primary storage but met with some problems.

I use a CentOS6.3 server as host. First I erase the qemu-kvm(0.12.1)
and libvirt(0.9.10) because their versions are too low (Qemu on the
Hypervisor has to be compiled with RBD enabled .The libvirt version on
the Hypervisor has to be at least 0.10 with RBD enabled).Then I
download the latest qemu(1.2.0) and libvirt(1.0.0) source code and
compile and install them. But when compiling qemu source code,

#wget http://wiki.qemu-project.org/download/qemu-1.2.0.tar.bz2
#tar jxvf qemu-1.2.0.tar.bz2
# cd qemu-1.2.0
# ./configure --enable-rbd

the following errors occur:
ERROR: User requested feature rados block device
ERROR: configure was not able to find it

But on Ubuntu12.04 I tried compiling qemu source code and succeed.Now
I am very confused.How to use Ceph RBD as primary storage in
CloudStack on CentOS6.3?Anyone can help me?

Best Regards,

 Alex
