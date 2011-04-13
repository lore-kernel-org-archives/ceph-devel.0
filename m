From: Zenon Panoussis <oracle@provocation.net>
Subject: dkms client module
Date: Thu, 14 Apr 2011 00:04:49 +0200
Message-ID: <4DA61E01.9050505@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:60961 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab1DMWKE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2011 18:10:04 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hello all

I'm new to ceph and I'm having troubles with the client module.

I'm testing on SL6. RHEL6 and all its derivatives use kernel 2.6.32 and
will continue doing so for the next seven years. Therefore, the only
reasonable way to get ceph into RHEL6 is dkms. Luckily, that's already
supported.

I got ceph-client-standalone from git and fixed the specific 2.6.32
problems according to http://marc.info/?l=ceph-devel&m=129813044300561&w=2 .

Then I run into this:

 ./dkms/add-to-dkms-and-build

 Creating symlink /var/lib/dkms/ceph/2.6.37/source ->
                 /usr/src/ceph-2.6.37

 DKMS: add Completed.

 Kernel preparation unnecessary for this kernel.  Skipping...

 Building module:
 cleaning build area....
 make KERNELRELEASE=2.6.32-71.24.1.el6.x86_64 -C ceph/....(bad exit status: 2)

 Error! Bad return status for module build on kernel: 2.6.32-71.24.1.el6.x86_64 (x86_64)
 Consult the make.log in the build directory
 /var/lib/dkms/ceph/2.6.37/build/ for more information.
 0
 0

make.log says:

 DKMS make.log for ceph-2.6.37 for kernel 2.6.32-71.24.1.el6.x86_64 (x86_64)
 Wed Apr 13 23:47:41 CEST 2011
 make: Entering directory `/var/lib/dkms/ceph/2.6.37/build/ceph'
 make: *** No targets.  Stop.
 make: Leaving directory `/var/lib/dkms/ceph/2.6.37/build/ceph'

It seems to me there should be a Makefile in the root of ceph-client-standalone
that points make to the Makefiles of the subdirectories, but I'm an ignorant
wrt to make, so I'm not sure about anything.

Suggestions anyone how to get around this?

Z


