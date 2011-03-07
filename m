From: Wido den Hollander <wido@widodh.nl>
Subject: Updated Qemu-KVM packages for Ubuntu 10.04
Date: Mon, 07 Mar 2011 16:02:51 +0100
Message-ID: <1299510171.2433.92.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57535 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab1CGPCy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2011 10:02:54 -0500
Received: from [IPv6:2a00:f10:113:1:224:1dff:fedd:9061] (unknown [IPv6:2a00:f10:113:1:224:1dff:fedd:9061])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 995FA7633F
	for <ceph-devel@vger.kernel.org>; Mon,  7 Mar 2011 16:02:52 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've just updated my Ubuntu (10.04) packages to the latest RBD code, but
it's still using Qemu 0.13 which comes with Ubuntu 11.04

The new RBD code relies on the new librbd library, so in the future you
only have to update your librbd code to get the bug fixes into Qemu
instead of recompiling Qemu.

The packages can be found at:

deb http://pcx.apt-get.eu/ubuntu lucid unofficial

GPG Key: http://www.apt-get.eu/pcextreme_archive_key.asc

I'm running them on my Ubuntu 10.04 servers right now and seems to be
running fine.

I also have a backport mirror at:

deb http://pcx.apt-get.eu/ubuntu lucid-backport unofficial

That also holds a backport/patched version of libvirt which gives you
the new snapshot features.

The libvirt packages are a bit outdated though, the new libvirt code
which has support for RBD, Sheepdog and NBD natively hasn't been
packaged yet (Not by me).

Wido

