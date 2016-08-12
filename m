From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Fri, 12 Aug 2016 17:42:19 +0000
Message-ID: <4257DB75-0060-4867-A5D5-2AD374722452@Teradata.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33431 "EHLO
	rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646AbcHLSBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 14:01:05 -0400
In-Reply-To: <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <2061A48049E2F74A876AD73B4A6512C3@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jason Dillaman <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>


> On Aug 12, 2016, at 7:17 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Fri, Aug 12, 2016 at 1:38 AM, Kamble, Nitin A
> <Nitin.Kamble@teradata.com> wrote:
>> 
>> SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.
>> 
>> For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq
>> 
>> Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.
>> 
>> It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?
> 
> No, SG_IO hasn't come up before, and we don't really have a good
> established way of doing that at all - if we had one, wiring up SG_IO
> (assuming no objections from SCSI maintainers) wouldn't be a problem.
> One approach is to concatenate a cluster-wide UUID with pool, image and
> snapshot IDs, but the problem there is that images can be moved between
> pools and clusters and v1 images don't have an image ID.

I am surprised to know that images can be moved across pools and clusters. The feature request for moving images across pools was rejected here: http://tracker.ceph.com/issues/2305 . Also the rbd man page says rbd rename across pools is not supported. (http://docs.ceph.com/docs/master/man/8/rbd/)

Is it a currently available feature?

> 
> Mike recently ran into the need to uniquely identify RBD devices for
> his multipath-tools work and I think he ended up using some variant of
> the above approach, grabbing IDs from /sys/bus/rbd.  (The cluster_uuid
> and snap_id attributes currently don't exist, but will be added in the
> next kernel release.)
> 
> It would make this a lot easier if we started generating a unique UUID
> for the image and each snapshot at image/snapshot creation time.  Jason?
> 

Image UUID seems like the right direction.
If that UUID needs to be really unique, then image copy also need to create a new UUID.

Thanks,
Nitin


> Thanks,
> 
>                Ilya

