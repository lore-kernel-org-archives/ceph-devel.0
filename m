From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: SCSI inquiry interface for RBD devices
Date: Fri, 12 Aug 2016 16:17:54 +0200
Message-ID: <CAOi1vP_5gtQXd95M=qspgPeRnTDvxBpC2dknARNv=HXNFKHivQ@mail.gmail.com>
References: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f170.google.com ([209.85.217.170]:36267 "EHLO
	mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcHLOR4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 10:17:56 -0400
Received: by mail-ua0-f170.google.com with SMTP id 97so43724350uav.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 07:17:55 -0700 (PDT)
In-Reply-To: <27148ED4-95A8-4E8F-86C0-52CEEA9140E1@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, Jason Dillaman <dillaman@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>

On Fri, Aug 12, 2016 at 1:38 AM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>
> SCSI block devices has SG_IO IOCTL interface by which applications can identify the device uniquely. This helps applications identify the device uniquely without relying on the device file names or any other mechanisms.
>
> For more details l ook at the manpage of sg_inq commnad. https://manned.org/sg_inq
>
> Some of the non SCSI devices also support this SG_IO interface for inquiry. Examples include SATA, NVME, Virtual Disks.
>
> It is desired to identify every RBD uniquely just from the device file. It will help in using RBD devices as drop in replacement for SCSI/SATA devices. Currently the RBD code in ceph-client does not support the SG_IO ioctl interface for inquiry to identify the device uniquely. Has adding the SG_IO ioctl interface to the RBD devices ever been considered before?

No, SG_IO hasn't come up before, and we don't really have a good
established way of doing that at all - if we had one, wiring up SG_IO
(assuming no objections from SCSI maintainers) wouldn't be a problem.
One approach is to concatenate a cluster-wide UUID with pool, image and
snapshot IDs, but the problem there is that images can be moved between
pools and clusters and v1 images don't have an image ID.

Mike recently ran into the need to uniquely identify RBD devices for
his multipath-tools work and I think he ended up using some variant of
the above approach, grabbing IDs from /sys/bus/rbd.  (The cluster_uuid
and snap_id attributes currently don't exist, but will be added in the
next kernel release.)

It would make this a lot easier if we started generating a unique UUID
for the image and each snapshot at image/snapshot creation time.  Jason?

Thanks,

                Ilya
