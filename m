From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: rbd import from stdin
Date: Fri, 23 Nov 2012 11:15:11 +0100
Message-ID: <50AF4CAF.2090402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58977 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161082Ab2KWKPV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 05:15:21 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

i was looking at the wip-rbd-export-stdout branch which also allows to 
import from stdin.

But it doesn't seem to work:

gzip -d -c vm-101-disk-1.img.gz | rbd import - kvmpool1/vm-101-disk-1
rbd: unable to get size of file/block device: (25) Inappropriate ioctl 
for device
rbd: import failed: (25) Inappropriate ioctl for device

Greets,
Stefan
