From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: SCSI inquiry interface for RBD devices
Date: Thu, 11 Aug 2016 23:38:41 +0000
Message-ID: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33454 "EHLO
	rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751570AbcHKXiq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Aug 2016 19:38:46 -0400
Received: from rpc7292.td.teradata.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A990E258005
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 19:39:02 -0400 (EDT)
Received: from RPC4168.td.teradata.com (unknown [153.65.10.242])
	by rpc7292.td.teradata.com (Postfix) with ESMTP id 9DC8332F25D
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 19:39:02 -0400 (EDT)
Received: from SUSHDC7998.TD.TERADATA.COM (unknown [153.65.10.254])
	by Websense Email Security Gateway with ESMTPS id 613E796AFB664
	for <ceph-devel@vger.kernel.org>; Thu, 11 Aug 2016 19:38:40 -0400 (EDT)
Content-Language: en-US
Content-ID: <5367A17307482344BD940AA7125CF2C7@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.

For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq

Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.

It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?



Thanks,
Nitin