From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: KVM/RBD Block device hangs
Date: Mon, 21 May 2012 16:44:50 +0200
Message-ID: <4FBA54E2.3000703@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35132 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab2EUOov (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 10:44:51 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi List,

i'm testing the ceph / rbd block device with qemu and KVM. The creation
of a new disk went fine and i can also access the disk from the KVM client.

But after a short time while installing debian squeeze the osd seems to
crash and i see /core files on my machines.

What's next / wrong?

Greets
Stefan
