From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Severe performance degradation with jewel rbd image
Date: Thu, 26 May 2016 09:28:47 -0400
Message-ID: <CA+aFP1DdPYWhRCeJ2buc7Gsz+gmti2BA4=7qoQHWP_Zi1_KyNQ@mail.gmail.com>
References: <BL2PR02MB2115AA33422B53D2C0B65E7AF4400@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1B_+TqDLNzxpvNYCz_3-Wsc4HAHUtKLzoJ+xUvqNHE0NQ@mail.gmail.com>
	<BL2PR02MB21158B4F676CFDF982E52704F4400@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DsqsTxgy4cXqJSRADqOYa2QsA8UUVTNUuA2__GHm0BFw@mail.gmail.com>
	<BL2PR02MB21154CCDABC8037F9D63DA7AF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CA+aFP1DapnzYpBDowdTjMVfrUcBSQy0tvYOEDM7QJJSy-kmPuw@mail.gmail.com>
	<BL2PR02MB2115791B5D2A2D163F7A2AEFF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34452 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbcEZN2s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2016 09:28:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id y69so31035868pfb.1
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2016 06:28:48 -0700 (PDT)
In-Reply-To: <BL2PR02MB2115791B5D2A2D163F7A2AEFF4410@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I create a ticket [1] a while ago to improve the documentation of RBD
image features.  The ticket is still open but I just added some
verbiage as a comment to the ticket in the meantime.

[1] http://tracker.ceph.com/issues/15000

On Thu, May 26, 2016 at 12:19 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Thanks Jason !
> My bad, I thought exclusive lock is to maintain the consistency.
> I think the features like objectmap , fast-diff , deep-flatten, journaling could not be enabled if I disable exclusive lock ?
> Could you please give a one liner or point me to the doc where I can find what the features like objectmap , fast-diff , deep-flatten does ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Jason Dillaman [mailto:jdillama@redhat.com]
> Sent: Wednesday, May 25, 2016 8:53 PM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Severe performance degradation with jewel rbd image
>
> For multi-client, single-image, you should be using the "--image-shared" option when creating the image (or just disable exclusive-lock after the fact) since the expected use case of exclusive-lock is single client, single image (e.g. single QEMU process that can live-migrate to a new host but both hosts won't be writing concurrently).
>
> Regardless of whether or not you use exclusive-lock or not, when you have multiple clients concurrently writing to the same image, the necessary coordination to provide consistency needs to be provided at the application layer (i.e. use a clustered filesystem on top of a single RBD image when being manipulated by multiple clients concurrently).
>
> On Wed, May 25, 2016 at 11:39 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Jason,
>> My use case is to find out how much write performance I can extract out of a single rbd image.
>> I don't want to use  --image-shared as writes will be inconsistent
>> then (?) It seems running a single fio job with high QD is the only option ?
>> Also, I believe the goal should be at least getting the similar aggregated throughput like single client/single image in case of multi client/single image (individual client will get less and that's fine).
>> Let me know if I am missing anything.
>>
>> Thanks & Regards
>> Somnath
>>
>>
>> -----Original Message-----
>> From: Jason Dillaman [mailto:jdillama@redhat.com]
>> Sent: Wednesday, May 25, 2016 5:51 PM
>> To: Somnath Roy
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Severe performance degradation with jewel rbd image
>>
>> Are you attempting to test a particular use-case where you would have multiple clients connected to a single RBD image?  The rbd CLI has a "--image-shared" option when creating/cloning images as a shortcut to easily disable the exclusive lock, object-map, fast-diff, and journaling features for such situations. You could also specify a different `rbdname` per job to simulate multiple clients accessing multiple images (instead of multiple clients sharing the same image).
>>
>> I have to be honest, I am actually pretty impressed by your 8K IOPS when you have multiple clients fighting over the exclusive lock since acquiring the lock requires inter-client cooperative coordination to request/release/acquire the lock from the current owner and any client without the lock has all writes blocked.
>>
>>
>> On Wed, May 25, 2016 at 7:08 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>>> Hi Jason,
>>> Yes, I am running on single image but with multiple fio jobs (with numjobs = 10 in the fio parameter) . I expected that this exclusive lock is locking between the jobs and that's why I have posted the single job result. Single job result is *not degrading*.
>>> But, we need numjob and QD combination to extract most performance from an image with fio-rbd. A single librbd instance performance seems to be stuck at 40K and we can't scale this image up without running multiple librbd instances on this in parallel.
>>> 16X performance degradation because of this lock seems very destructive.
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> -----Original Message-----
>>> From: Jason Dillaman [mailto:jdillama@redhat.com]
>>> Sent: Wednesday, May 25, 2016 3:47 PM
>>> To: Somnath Roy
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: Severe performance degradation with jewel rbd image
>>>
>>> Just to eliminate the most straightforward explanation, are you running multiple fio jobs against the same image concurrently?  If the exclusive lock had to ping-pong back-and-forth between clients, that would certainly explain the severe performance penalty.
>>>
>>> Otherwise, the exclusive lock is not in the IO path once the client has acquired the exclusive lock.  If you are seeing a performance penalty for a single-client scenario with exclusive lock enabled, this is something we haven't seen and will have to investigate ASAP.
>>>
>>> Thanks,
>>>
>>> On Wed, May 25, 2016 at 4:48 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>>>> Hi Mark/Josh,
>>>> As I mentioned in the performance meeting today , if we create rbd image with default 'rbd create' command in jewel , the individual image performance for 4k RW is not scaling up well. But, multiple of rbd images running in parallel aggregated throughput is scaling.
>>>> For the same QD and numjob combination, image created with image format 1 (and with hammer like rbd_default_features = 3) is producing *16X* more performance. I did some digging and here is my findings.
>>>>
>>>> Setup:
>>>> --------
>>>>
>>>> 32 osds (all SSD) over 4 nodes. Pool size = 2 , min_size = 1.
>>>>
>>>> root@stormeap-1:~# ceph -s
>>>>     cluster db0febf1-d2b0-4f8d-8f20-43731c134763
>>>>      health HEALTH_WARN
>>>>             noscrub,nodeep-scrub,sortbitwise flag(s) set
>>>>      monmap e1: 1 mons at {a=10.60.194.10:6789/0}
>>>>             election epoch 5, quorum 0 a
>>>>      osdmap e139: 32 osds: 32 up, 32 in
>>>>             flags noscrub,nodeep-scrub,sortbitwise
>>>>       pgmap v20532: 2500 pgs, 1 pools, 7421 GB data, 1855 kobjects
>>>>             14850 GB used, 208 TB / 223 TB avail
>>>>                 2500 active+clean
>>>>
>>>> IO profile : Fio rbd with QD 128 and numjob = 10 rbd cache is
>>>> disabled.
>>>>
>>>> Result:
>>>> --------
>>>> root@stormeap-1:~# rbd info recovery_test/rbd_degradation rbd image
>>>> 'rbd_degradation':
>>>>         size 1953 GB in 500000 objects
>>>>         order 22 (4096 kB objects)
>>>>         block_name_prefix: rb.0.5f5f.6b8b4567
>>>>         format: 1
>>>>
>>>> On the above image with format 1 it is giving *~102K iops*
>>>>
>>>> root@stormeap-1:~# rbd info
>>>> recovery_test/rbd_degradation_with_hammer_features
>>>> rbd image 'rbd_degradation_with_hammer_features':
>>>>         size 195 GB in 50000 objects
>>>>         order 22 (4096 kB objects)
>>>>         block_name_prefix: rbd_data.5f8d6b8b4567
>>>>         format: 2
>>>>         features: layering
>>>>         flags:
>>>>
>>>> On the above image with hammer rbd features on , it is giving *~105K
>>>> iops*
>>>>
>>>> root@stormeap-1:~# rbd info recovery_test/rbd_degradation_with_7
>>>> rbd image 'rbd_degradation_with_7':
>>>>         size 195 GB in 50000 objects
>>>>         order 22 (4096 kB objects)
>>>>         block_name_prefix: rbd_data.5fd86b8b4567
>>>>         format: 2
>>>>         features: layering, exclusive-lock
>>>>         flags:
>>>>
>>>> On the above image with feature 7 (exclusive lock feature on) , it
>>>> is giving *~8K iops*...So, >12X degradation
>>>>
>>>> Tried with single numjob and QD = 128 , performance bumped up till ~40K..Further increasing QD , performance is not going up.
>>>>
>>>>
>>>> root@stormeap-1:~# rbd info recovery_test/rbd_degradation_with_15
>>>> rbd image 'rbd_degradation_with_15':
>>>>         size 195 GB in 50000 objects
>>>>         order 22 (4096 kB objects)
>>>>         block_name_prefix: rbd_data.5fab6b8b4567
>>>>         format: 2
>>>>         features: layering, exclusive-lock, object-map
>>>>         flags:
>>>>
>>>> On the above image with feature 15 (exclusive lock, object map
>>>> feature
>>>> on) , it is giving *~8K iops*...So, >12X degradation
>>>>
>>>> Tried with single numjob and QD = 128 , performance bumped up till ~40K..Further increasing QD , performance is not going up.
>>>>
>>>>
>>>> root@stormeap-1:~# rbd info recovery_test/ceph_recovery_img_1 rbd
>>>> image 'ceph_recovery_img_1':
>>>>         size 4882 GB in 1250000 objects
>>>>         order 22 (4096 kB objects)
>>>>         block_name_prefix: rbd_data.371b6b8b4567
>>>>         format: 2
>>>>         features: layering, exclusive-lock, object-map, fast-diff, deep-flatten
>>>>         flags:
>>>>
>>>> On the above image with feature 61 (Jewel default) , it is giving
>>>> *~6K iops*...So, *>16X* degradation
>>>>
>>>> Tried with single numjob and QD = 128 , performance bumped up till ~35K..Further increasing QD , performance is not going up.
>>>>
>>>> Summary :
>>>> ------------
>>>>
>>>> 1. It seems exclusive lock feature is degrading performance.
>>>>
>>>> 2. It is degrading a bit further on enabling fast-diff, deep-flatten
>>>>
>>>>
>>>> Let me know if you need more information on this.
>>>>
>>>> Thanks & Regards
>>>> Somnath
>>>>
>>>>
>>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Jason
>>
>>
>> --
>> Jason
>
>
>
> --
> Jason



-- 
Jason
