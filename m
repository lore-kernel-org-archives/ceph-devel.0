From: "Moore, Shawn M" <smmoore@catawba.edu>
Subject: Utility to recover rbd image from raw files
Date: Fri, 26 Oct 2012 13:53:13 +0000
Message-ID: <AEBA0243790A484AA72D5CDF477159BC1CE2E7F3@SN2PRD0106MB178.prod.exchangelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:34398
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933043Ab2JZOIU convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 26 Oct 2012 10:08:20 -0400
Received: from mail91-co9 (localhost [127.0.0.1])	by mail91-co9-R.bigfish.com
 (Postfix) with ESMTP id 7F18AB000A4	for <ceph-devel@vger.kernel.org>; Fri, 26
 Oct 2012 13:53:17 +0000 (UTC)
Received: from CO9EHSMHS026.bigfish.com (unknown [10.236.132.237])	by
 mail91-co9.bigfish.com (Postfix) with ESMTP id 0B0CD780044	for
 <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 13:53:15 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

We had a need to be able to recover a rbd image from just the raw files in case the cluster itself was down or lost.  

As long as you already know the block prefix and rbd size this works in our testing.  We have tested with both rbd images for qemu (with partitions, bootable, etc) and rbd images for local block storage.

Hopefully most of the information you need can be found within the NOTES section of the utility.  But feel free to ask questions or make suggestions if you have them.

You can access the code via github:
https://github.com/smmoore/ceph/blob/master/rbd_restore.sh

Thanks to Josh Durgin for his testing and input.

Regards,
Shawn Moore
Catawba College
