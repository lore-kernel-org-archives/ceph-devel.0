From: Dan Mick <dan.mick@inktank.com>
Subject: new version of stgt pushed to ceph-extras
Date: Mon, 04 Nov 2013 20:32:50 -0800
Message-ID: <527874F2.5020903@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:41338 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab3KEEcx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Nov 2013 23:32:53 -0500
Received: by mail-qc0-f177.google.com with SMTP id u18so4432207qcx.8
        for <ceph-devel@vger.kernel.org>; Mon, 04 Nov 2013 20:32:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hey, all, we just refreshed stgt to its latest released version 
(1.0.41), and I also tweaked the rbd backend to be a little more
flexible and useful.

stgt is a userspace iSCSI target implementation (using tgtd) that can 
export several types of storage entities as iSCSI LUNs; backends include 
files in synchronous or asynchronous mode, "passthrough" to
real SCSI devices, tape-device emulation on a file, sheepdog block 
images, and Ceph RBD images.

New bs_rbd features include:

* fixed up tgt-admin to work with rbd images (so .conf files work)

* no more 20-rbd-image-per-tgtd limit

* tgtadm accepts --bsopts for each image
   conf= to set path to ceph.conf file
   id= to set clientid

   This means that each image can have different logging and access
   rights, or even refer to a different cluster.

The stgt source has also been refactored so that packagers can
build with or without bs_rbd, now built into an .so, and distribute
that module separately if desired; thus the base package doesn't
require Ceph libraries librbd and librados.

The source is available upstream at http://github.com/fujita/stgt.
Packages are built and available in the ceph-extras repository at 
http://ceph.com/packages/ceph-extras/.

Enjoy!

-- 
Dan Mick, Filesystem Engineering
Inktank Storage, Inc.	http://inktank.com
Ceph docs: http://ceph.com/docs
