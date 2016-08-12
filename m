From: Mike Christie <mchristi@redhat.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Fri, 12 Aug 2016 12:19:41 -0500
Message-ID: <57AE052D.1040505@redhat.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbcHLRTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Aug 2016 13:19:43 -0400
In-Reply-To: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/11/2016 06:38 PM, Kamble, Nitin A wrote:
> 
> SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.
> 
> For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq
> 
> Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.
> 
> It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?
> 

What application do you need this for right now? Is it udev's scsi_id?

What pages do you need? Just 0x83?

