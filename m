From: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Fri, 12 Aug 2016 18:40:35 +0000
Message-ID: <82369305-99D9-464E-B14A-D2E91AC7B76F@Teradata.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
 <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
 <4257DB75-0060-4867-A5D5-2AD374722452@Teradata.com>
 <CAOi1vP9mdNYRCD_cTa0=4tN71L1=tA24wXSr2NqhTH9BmUBAuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nat13.teradata.com ([153.65.16.13]:33462 "EHLO
	rpc7292.td.teradata.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752582AbcHLSkj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 14:40:39 -0400
In-Reply-To: <CAOi1vP9mdNYRCD_cTa0=4tN71L1=tA24wXSr2NqhTH9BmUBAuw@mail.gmail.com>
Content-Language: en-US
Content-ID: <68005E5694AB7443B2CE8CD140532885@TD.Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jason Dillaman <dillaman@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>


> On Aug 12, 2016, at 11:15 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Fri, Aug 12, 2016 at 7:42 PM, Kamble, Nitin A
> <Nitin.Kamble@teradata.com> wrote:
>> 
>>> On Aug 12, 2016, at 7:17 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
>>> 
>>> On Fri, Aug 12, 2016 at 1:38 AM, Kamble, Nitin A
>>> <Nitin.Kamble@teradata.com> wrote:
>>>> 
>>>> SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.
>>>> 
>>>> For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq
>>>> 
>>>> Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.
>>>> 
>>>> It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?
>>> 
>>> No, SG_IO hasn't come up before, and we don't really have a good
>>> established way of doing that at all - if we had one, wiring up SG_IO
>>> (assuming no objections from SCSI maintainers) wouldn't be a problem.
>>> One approach is to concatenate a cluster-wide UUID with pool, image and
>>> snapshot IDs, but the problem there is that images can be moved between
>>> pools and clusters and v1 images don't have an image ID.
>> 
>> I am surprised to know that images can be moved across pools and clusters. The feature request for moving images across pools was rejected here: http://tracker.ceph.com/issues/2305 . Also the rbd man page says rbd rename across pools is not supported. (http://docs.ceph.com/docs/master/man/8/rbd/)
>> 
>> Is it a currently available feature?
> 
> There are a couple of hacky, undocumented and unsupported ways which
> I won't describe.  The above was just a very bad way of saying that
> current v2 image IDs are guaranteed to be unique only within a pool and
> can be the duplicated between different pools on the same cluster and
> different clusters.
> 
>> 
>>> 
>>> Mike recently ran into the need to uniquely identify RBD devices for
>>> his multipath-tools work and I think he ended up using some variant of
>>> the above approach, grabbing IDs from /sys/bus/rbd.  (The cluster_uuid
>>> and snap_id attributes currently don't exist, but will be added in the
>>> next kernel release.)
>>> 
>>> It would make this a lot easier if we started generating a unique UUID
>>> for the image and each snapshot at image/snapshot creation time.  Jason?
>>> 
>> 
>> Image UUID seems like the right direction.
> 
> With UUIDs we would be in much better shape - current v2 image ID is
> relatively very short.  We can couple it with a cluster UUID too.
> 
>> If that UUID needs to be really unique, then image copy also need to create a new UUID.
> 
> It would be akin to the UUID of a partition.  I suppose including
> a tune2fs -U functionality wouldn't hurt.  I'll add that to the ticket.
> 

The rbd creation creation tool having an ability to assign a specific UUID to the image being created would be useful too.

> Thanks,
> 
>                Ilya

