From: Wido den Hollander <wido@42on.com>
Subject: Is rbd_discard enough to wipe an RBD image?
Date: Sun, 20 Dec 2015 22:21:50 +0100
Message-ID: <56771BEE.4050705@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:45538 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbLTVYA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Dec 2015 16:24:00 -0500
Received: from [192.168.8.128] (cable-178-107.zeelandnet.nl [82.176.178.107])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPSA id 5EA7940478
	for <ceph-devel@vger.kernel.org>; Sun, 20 Dec 2015 22:23:58 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I'm busy implementing the volume wiping method of the libvirt storage
pool backend and instead of writing to the whole RBD image with zeroes
I'm using rbd_discard.

Using a 4MB length I'm starting at offset 0 and work my way through the
whole RBD image.

A quick try shows me that my partition table + filesystem are gone on
the RBD image after I've run rbd_discard.

I just want to know if this is sufficient to wipe a RBD image? Or would
it be better to fully fill the image with zeroes?

-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
