From: Martin Mailand <martin@tuxadero.com>
Subject: ceph and ext4
Date: Mon, 14 Nov 2011 13:15:32 +0100
Message-ID: <4EC10664.1080501@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:43304 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab1KNMPk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 07:15:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,
I am not sure if you noticed, but your ext4 bug is fixed in mainline. I 
am running a ceph cluster with 40+ vms for over a week by now, without 
any problems. An fsck.ext4 shows the ext4 is clean.
The performance of ext4 is much better than btrfs, no rise in the load 
of the osd's.

-martin
