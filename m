From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: qemu : rbd block driver internal snapshot and vm_stop is hanging
 forever
Date: Mon, 9 Nov 2015 04:10:45 +0100 (CET)
Message-ID: <310812067.2785504.1447038645014.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:43925 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbbKIDKr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Nov 2015 22:10:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>

Hi,

with qemu (2.4.1), if I do an internal snapshot of an rbd device,
then I pause the vm with vm_stop,

the qemu process is hanging forever


monitor commands to reproduce:


# snapshot_blkdev_internal drive-virtio0 yoursnapname
# stop




I don't see this with qcow2 or sheepdog block driver for example.


Regards,

Alexandre
