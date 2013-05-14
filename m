From: Wido den Hollander <wido@42on.com>
Subject: Re: QCOW2 to RBD format 2 in one step
Date: Tue, 14 May 2013 22:37:31 +0200
Message-ID: <855527822.511.1368563851103.open-xchange@websrv.42on.com>
References: <51920F00.406@42on.com> <51929725.9060807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:60150 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758111Ab3ENUhc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 May 2013 16:37:32 -0400
In-Reply-To: <51929725.9060807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Op 14 mei 2013 om 21:59 heeft "Josh Durgin" <josh.durgin@inktank.com> het volgende geschreven:

> On 05/14/2013 03:16 AM, Wido den Hollander wrote:
>> Hi,
>> 
>> While working on the CloudStack code for 4.2 I'm running into some
>> problems with QCOW2 and RBD format 2.
>> 
>> A quick cap of the problem:
>> 
>> CloudStack stores all the templates on "Secondary Storage" as QCOW2 files.
>> 
>> When a VM is deployed, this image will be copied (once) from Secondary
>> Storage to Primary Storage, this is done by qemu-img which does the
>> conversion.
>> 
>> When the image is on Primary Storage it will be copied to the
>> destination volume and the Instance/VM is started.
>> 
>> In that last step I want to use layering, but the problem is that my
>> image is RBD format 1 due to the qemu-img copy.
>> 
>> I can skip the qemu-img copy, but I have to find a way to go from QCOW2
>> to RBD format 2 in preferably one step. There is a issue about this in
>> the tracker [0], but that won't be finished on time.
>> 
>> Another idea would be to do QCOW2 -> RAW -> RBD format 2, but that extra
>> step will take a lot of time. It would also require some temporary
>> storage on the hypervisor.
>> 
>> I also thought of creating the RBD image prior to converting to it, but
>> that fails, since qemu-img won't let you convert to a already existing
>> image.
>> 
>> Any brights ideas? Maybe even doing the QCOW2 -> RAW format in memory?
>> In Java?
> 
> One way that wouldn't require a change in qemu would be adding ceph
> configuration options to change the behavior of librbd's rbd_create[2|3]().
> 
> For example, there could be just:
> 
> rbd_create_default_format UINT default 1
> 
> or we could add other options to adjust the rest of the image creation
> parameters i.e.:
> 
> rbd_create_default_object_order INT default 22
> 
> // these only apply to format 2
> rbd_create_default_features     UINT64 default 1 # 1 for layering, 3 for layering+stripingv2
> rbd_create_default_stripe_count UINT64 default 1 # changing requires stripingv2 feature
> rbd_create_default_stripe_unit  UINT64 default 4194304 # changing to non-object size requires stripingv2 feature
> 
> For backwards compatibility, the default values preserve the existing
> behavior of rbd_create(), but when you run qemu-img you could change
> them to create format 2 images and potentially change the striping
> as well. These options could be easily backported to cuttlefish
> and bobtail.
> 
> What do you think?

Something like that crossed my mind for a moment and seems like a very good solution!

On existing Ubuntu systems you could simply upgrade librbd and have it all working.

Wido

> 
>> The goal is to go from QCOW2 to RBD format 2 in one step.
>> 
>> [0]: http://tracker.ceph.com/issues/4897
> 
