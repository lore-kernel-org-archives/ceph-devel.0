From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 12:57:25 -0700
Message-ID: <51929725.9060807@inktank.com>
References: <51920F00.406@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:39727 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3ENT6l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 15:58:41 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so709290pdi.6
        for <ceph-devel@vger.kernel.org>; Tue, 14 May 2013 12:58:40 -0700 (PDT)
In-Reply-To: <51920F00.406@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/14/2013 03:16 AM, Wido den Hollander wrote:
> Hi,
>
> While working on the CloudStack code for 4.2 I'm running into some
> problems with QCOW2 and RBD format 2.
>
> A quick cap of the problem:
>
> CloudStack stores all the templates on "Secondary Storage" as QCOW2 files.
>
> When a VM is deployed, this image will be copied (once) from Secondary
> Storage to Primary Storage, this is done by qemu-img which does the
> conversion.
>
> When the image is on Primary Storage it will be copied to the
> destination volume and the Instance/VM is started.
>
> In that last step I want to use layering, but the problem is that my
> image is RBD format 1 due to the qemu-img copy.
>
> I can skip the qemu-img copy, but I have to find a way to go from QCOW2
> to RBD format 2 in preferably one step. There is a issue about this in
> the tracker [0], but that won't be finished on time.
>
> Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that extra
> step will take a lot of time. It would also require some temporary
> storage on the hypervisor.
>
> I also thought of creating the RBD image prior to converting to it, but
> that fails, since qemu-img won't let you convert to a already existing
> image.
>
> Any brights ideas? Maybe even doing the QCOW2 -> RAW format in memory?
> In Java?

One way that wouldn't require a change in qemu would be adding ceph
configuration options to change the behavior of librbd's rbd_create[2|3]().

For example, there could be just:

rbd_create_default_format UINT default 1

or we could add other options to adjust the rest of the image creation
parameters i.e.:

rbd_create_default_object_order INT default 22

// these only apply to format 2
rbd_create_default_features     UINT64 default 1 # 1 for layering, 3 for 
layering+stripingv2
rbd_create_default_stripe_count UINT64 default 1 # changing requires 
stripingv2 feature
rbd_create_default_stripe_unit  UINT64 default 4194304 # changing to 
non-object size requires stripingv2 feature

For backwards compatibility, the default values preserve the existing
behavior of rbd_create(), but when you run qemu-img you could change
them to create format 2 images and potentially change the striping
as well. These options could be easily backported to cuttlefish
and bobtail.

What do you think?

> The goal is to go from QCOW2 to RBD format 2 in one step.
>
> [0]: http://tracker.ceph.com/issues/4897
>

