From: Mark Korondi <korondi.mark@gmail.com>
Subject: Re: Reimplemented `rbd cache writethrough until flush` broken?
Date: Wed, 17 Aug 2016 17:41:48 +0200
Message-ID: <CACiqYg5a+1rZ17uT39HKTW2Gbp-_ccWqHZiFGG9JiP2PO8x=PQ@mail.gmail.com>
References: <CACiqYg665Zt3uPUshXcJkT-OWf=Q7yokZ1U02yQs-0OoH8wxtQ@mail.gmail.com>
 <CA+aFP1AP-eAVzyzmcaE5GxBNe_V3CzrqtPkLpy1HdD2uP+UC4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34136 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371AbcHQPmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Aug 2016 11:42:31 -0400
Received: by mail-wm0-f52.google.com with SMTP id q128so38038433wma.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Aug 2016 08:42:30 -0700 (PDT)
In-Reply-To: <CA+aFP1AP-eAVzyzmcaE5GxBNe_V3CzrqtPkLpy1HdD2uP+UC4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Cool, thanks!

On Wed, Aug 17, 2016 at 5:39 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> Wow, thanks for elevating this issue to my attention. This is
> definitely a bug that was introduced accidentally during all the
> internal refactoring work in support the new journaling feature. I
> will get a fix up for review today against the master branch and we
> can hopefully include it in the next Jewel point release as well.
>
> Thanks,
> Jason
>
> On Wed, Aug 17, 2016 at 11:03 AM, Mark Korondi <korondi.mark@gmail.com> wrote:
>> Hi all,
>>
>> my team struggles with enabling rbd caching with Jewel clusters. In
>> Hammer, we successfully use rbd caching with the `writethrough until
>> flush` directive set to true and we get expected IOPS numbers.
>> However, with the same configuration using Jewel,  IOPS drops; after
>> analyzing logs it seems to us that the writeback caching mechanism
>> never gets enabled regardless of flush request is being sent.
>>
>> We found a bug entry describing an issue similar to ours:
>> http://tracker.ceph.com/issues/16654
>>
>> As our note #3 says, we concluded that it seems that the imagecontext
>> user_flushed() signal is missing from the later version, therefore the
>> caching mechanism will never be switched to writeback.
>>
>> Our questions are these:
>> 1) is this change intentional and one needs to configure their
>> environment differently? If yes, how?
>> 2) documentation states that this workaround is only needed with older
>> virtio kernel driver too old. With newer kernels, what would be the
>> possible implications of setting `rbd cache writethrough until flush`
>> to false? Is my understanding correct that this virtio driver version
>> what matters is that is *in the VM*?
>>
>> Thanks,
>> Mark
>
>
>
> --
> Jason
