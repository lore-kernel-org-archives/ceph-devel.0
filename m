From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Fri, 12 Aug 2016 18:23:36 +0000
Message-ID: <6CAC1BBC-5517-4DBD-BCAB-E299422DAC2B@Teradata.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <57AE052D.1040505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33448 "EHLO
	rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751900AbcHLSXj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 14:23:39 -0400
In-Reply-To: <57AE052D.1040505@redhat.com>
Content-Language: en-US
Content-ID: <9434EB07CBCE96448E5E991B90FB430D@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On Aug 12, 2016, at 10:19 AM, Mike Christie <mchristi@redhat.com> wrote:
> 
> On 08/11/2016 06:38 PM, Kamble, Nitin A wrote:
>> 
>> SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.
>> 
>> For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq
>> 
>> Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.
>> 
>> It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?
>> 
> 
> What application do you need this for right now? Is it udev's scsi_id?

The sg_inq command is one of such application. Or any application calling sg_simple_inquiry() function from /usr/include/scsi/sg_cmds_basic.h

> 
> What pages do you need? Just 0x83?
> 

The pages 0x83 & 0x80 are good to have. The Inquiry command 0x12 is of most interest. It is described in the section 3.6.1 of this SCSI commands reference manual: http://www.seagate.com/files/staticfiles/support/docs/manual/Interface%20manuals/100293068h.pdf .

Thanks,
Nitin


