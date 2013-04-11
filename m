From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: expected I/O / rand 4k iops
Date: Thu, 11 Apr 2013 09:27:12 +0200
Message-ID: <516665D0.8080704@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:36213 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab3DKH1V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 03:27:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello list,

is there any calculation of expected I/O available?

I've a test system running 6 hosts 4 OSDs each using SSD - i get 20.000
to 40.000 IOP/s not as much as i expected but OK right now.

If i replace the SSDs on one host with spinning disks but still using
dedicated journal on ssd (20GB / Disk/OSDK), i'm not able to get more
than 300 to 400 iop/s this seems to be pretty low.

Everything tested using 0.56.4 and Qemu RBD.

Greets,
Stefan
