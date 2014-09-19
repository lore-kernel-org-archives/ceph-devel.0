From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Fri, 19 Sep 2014 21:23:23 +0530
Message-ID: <CANA9Uk5ae+3EBemx=UrRgNoMowUS1SBor=wV4RjWxj8kNn_Svw@mail.gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
	<CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
	<alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
	<CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com>
	<CABBk=J8+3K28M-RNf+ULx0TnTMmGxdymJDLeFMft-EX8PhS_4A@mail.gmail.com>
	<CANA9Uk4JGm_2L_VnGsOgfpsX17=Ja4LLDaVNXzKJe-ZkY=ya9A@mail.gmail.com>
	<CABBk=J-fSR8mc7LQBLcUQDPkgC8NaSfvRB-2ED71qSvQzLX8Cw@mail.gmail.com>
	<CANA9Uk75TsXUyfMSibJRMeaWFEMKj-RxyFQqp=s1YZerNzM0mw@mail.gmail.com>
	<CANA9Uk49OgVtOSW9Yria-3ig8L8doV3X1ZqL+C_E0e4e9ShQxQ@mail.gmail.com>
	<CANA9Uk6LTc=HEV5mb+q1-QR3P-gPhAOYst-p9MHkQfxDBga-rA@mail.gmail.com>
	<alpine.DEB.2.00.1409182234140.18018@cobra.newdream.net>
	<CANA9Uk6_zg7f6UQKNoBWLB_VEUJ+oicz4fe-tq7y3upFWoZEGA@mail.gmail.com>
	<alpine.DEB.2.00.1409190833500.18018@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40417 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaISPxY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 11:53:24 -0400
Received: by mail-lb0-f170.google.com with SMTP id n15so1535981lbi.15
        for <ceph-devel@vger.kernel.org>; Fri, 19 Sep 2014 08:53:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409190833500.18018@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Yehuda Sadeh <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>What do you mean by "RRS storage-low cost storage"?  My read of the RRS
>numbers is that they simply have a different tier of S3 that runs fewer
>replicas and (probably) cheaper disks.  In radosgw-land, this would just
>be a different rados pool with 2x replicas and (probably) a CRUSH rule
>mapping it to different hardware (with bigger and/or cheaper disks).

Thats correct. If we could do the with a different rados pool  using
2x replicas along with CURSH
mapping it to different h/w (with bigger and cheaper disks) , then its
same as RRS support in AWS.


>> >What isn't currently supported is the ability to reduce the redundancy of
>> >individual objects in a bucket.  I don't think there is anything
>> >architecturally preventing that, but it is not implemented or supported.
>>
>> OK. Do we have the issue id for the above? Else, we can file one. Please advise.

>There is the main #4099 issue for object expiration, but there is no real
>detail there.  The plan is (as always) to have equivalent functionality to S3.

>Do you mind creating a new feature ticket that specifically references the
>ability to move objects to a second storage tier based on policy?  Any
>references to AWS docs about the API or functionality would be helpful in
>the ticket.


Sure, I will create a new feature ticket and add the needful information  there.

Thanks
Swami

On Fri, Sep 19, 2014 at 9:08 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 19 Sep 2014, M Ranga Swami Reddy wrote:
>> Hi Sage,
>> Thanks for quick reply.
>>
>> >what you mean.
>> >For RRS, though, I assume you mean the ability to create buckets with
>> >reduced redundancy with radosgw?  That is supported, although not quite
>> >the way AWS does it.  You can create different pools that back RGW
>> >buckets, and each bucket is stored in one of those pools.  So you could
>> >make one of them 2x instead of 3x, or use an erasure code of your choice.
>>
>> Yes, we can confiure ceph to use 2x replicas, which will look like
>> reduced redundancy, but AWS uses a separate RRS storage-low cost
>> (instead of
>> standard) storage for this purpose. I am checking, if we could
>> similarly in ceph too.
>
> What do you mean by "RRS storage-low cost storage"?  My read of the RRS
> numbers is that they simply have a different tier of S3 that runs fewer
> replicas and (probably) cheaper disks.  In radosgw-land, this would just
> be a different rados pool with 2x replicas and (probably) a CRUSH rule
> mapping it to different hardware (with bigger and/or cheaper disks).
>
>> >What isn't currently supported is the ability to reduce the redundancy of
>> >individual objects in a bucket.  I don't think there is anything
>> >architecturally preventing that, but it is not implemented or supported.
>>
>> OK. Do we have the issue id for the above? Else, we can file one. Please advise.
>
> There is the main #4099 issue for object expiration, but there is no real
> detail there.  The plan is (as always) to have equivalent functionality to
> S3.
>
> Do you mind creating a new feature ticket that specifically references the
> ability to move objects to a second storage tier based on policy?  Any
> references to AWS docs about the API or functionality would be helpful in
> the ticket.
>
>> >When we look at the S3 archival features in more detail (soon!) I'm sure
>> >this will come up!  The current plan is to address object versioning
>> >first.  That is, unless a developer surfaces who wants to start hacking on
>> >this right away...
>>
>> Great to know this. Even we are keen with S3 support in Ceph and we
>> are happy support you here.
>
> Great to hear!
>
> Thanks-
> sage
>
>
>>
>> Thanks
>> Swami
>>
>> On Fri, Sep 19, 2014 at 11:08 AM, Sage Weil <sweil@redhat.com> wrote:
>> > On Fri, 19 Sep 2014, M Ranga Swami Reddy wrote:
>> >> Hi Sage,
>> >> Could you please advise, if Ceph support the low cost object
>> >> storages(like Amazon Glacier or RRS) for archiving objects like log
>> >> file etc.?
>> >
>> > Ceph doesn't interact at all with AWS services like Glacier, if that's
>> > what you mean.
>> >
>> > For RRS, though, I assume you mean the ability to create buckets with
>> > reduced redundancy with radosgw?  That is supported, although not quite
>> > the way AWS does it.  You can create different pools that back RGW
>> > buckets, and each bucket is stored in one of those pools.  So you could
>> > make one of them 2x instead of 3x, or use an erasure code of your choice.
>> >
>> > What isn't currently supported is the ability to reduce the redundancy of
>> > individual objects in a bucket.  I don't think there is anything
>> > architecturally preventing that, but it is not implemented or supported.
>> >
>> > When we look at the S3 archival features in more detail (soon!) I'm sure
>> > this will come up!  The current plan is to address object versioning
>> > first.  That is, unless a developer surfaces who wants to start hacking on
>> > this right away...
>> >
>> > sage
>> >
>> >
>> >
>> >>
>> >> Thanks
>> >> Swami
>> >>
>> >> On Thu, Sep 18, 2014 at 6:20 PM, M Ranga Swami Reddy
>> >> <swamireddy@gmail.com> wrote:
>> >> > Hi ,
>> >> >
>> >> > Could you please check and clarify the below question on object
>> >> > lifecycle and notification S3 APIs support:
>> >> >
>> >> > 1. To support the bucket lifecycle - we need to support the
>> >> > moving/deleting the objects/buckets based lifecycle settings.
>> >> > For ex: If an object lifecyle set as below:
>> >> >           1. Archive it after 10 days - means move this object to low
>> >> > cost object storage after 10 days of the creation date.
>> >> >            2. Remove this object after 90days - mean remove this
>> >> > object from the low cost object after 90days of creation date.
>> >> >
>> >> > Q1- Does the ceph support the above concept like moving to low cost
>> >> > storage and delete from that storage?
>> >> >
>> >> > 2. To support the object notifications:
>> >> >       - First there should be low cost and high availability storage
>> >> > with single replica only. If an object created with this type of
>> >> > object storage,
>> >> >         There could be chances that object could lose, so if an object
>> >> > of this type of storage lost, set the notifications.
>> >> >
>> >> > Q2- Does Ceph support low cost and high availability storage type?
>> >> >
>> >> > Thanks
>> >> >
>> >> > On Fri, Sep 12, 2014 at 8:00 PM, M Ranga Swami Reddy
>> >> > <swamireddy@gmail.com> wrote:
>> >> >> Hi Yehuda,
>> >> >>
>> >> >> Could you please check and clarify the below question on object
>> >> >> lifecycle and notification S3 APIs support:
>> >> >>
>> >> >> 1. To support the bucket lifecycle - we need to support the
>> >> >> moving/deleting the objects/buckets based lifecycle settings.
>> >> >> For ex: If an object lifecyle set as below:
>> >> >>           1. Archive it after 10 days - means move this object to low
>> >> >> cost object storage after 10 days of the creation date.
>> >> >>            2. Remove this object after 90days - mean remove this
>> >> >> object from the low cost object after 90days of creation date.
>> >> >>
>> >> >> Q1- Does the ceph support the above concept like moving to low cost
>> >> >> storage and delete from that storage?
>> >> >>
>> >> >> 2. To support the object notifications:
>> >> >>       - First there should be low cost and high availability storage
>> >> >> with single replica only. If an object created with this type of
>> >> >> object storage,
>> >> >>         There could be chances that object could lose, so if an object
>> >> >> of this type of storage lost, set the notifications.
>> >> >>
>> >> >> Q2- Does Ceph support low cost and high availability storage type?
>> >> >>
>> >> >> Thanks
>> >> >> Swami
>> >> >>
>> >> >>
>> >> >>
>> >> >>
>> >> >>
>> >> >>
>> >> >>
>> >> >> On Tue, Jul 29, 2014 at 1:35 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> >> >>> Bucket lifecycle:
>> >> >>> http://tracker.ceph.com/issues/8929
>> >> >>>
>> >> >>> Bucket notification:
>> >> >>> http://tracker.ceph.com/issues/8956
>> >> >>>
>> >> >>> On Sun, Jul 27, 2014 at 12:54 AM, M Ranga Swami Reddy
>> >> >>> <swamireddy@gmail.com> wrote:
>> >> >>>> Good no know the details. Can you please share the issue ID for bucket
>> >> >>>> lifecycle? My team also could start help here.
>> >> >>>> Regarding the notification - Do we have the issue ID?
>> >> >>>> Yes, the object versioning will be backlog one - I strongly feel we
>> >> >>>> start working on this asap.
>> >> >>>>
>> >> >>>> Thanks
>> >> >>>> Swami
>> >> >>>>
>> >> >>>> On Fri, Jul 25, 2014 at 11:31 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> >> >>>>> On Fri, Jul 25, 2014 at 10:14 AM, M Ranga Swami Reddy
>> >> >>>>> <swamireddy@gmail.com> wrote:
>> >> >>>>>> Thanks for quick reply.
>> >> >>>>>> Yes,  versioned object - missing in ceph ATM
>> >> >>>>>> Iam looking for: bucket lifecylce (get/put/delete), bucket location,
>> >> >>>>>> put object notification and object restore (ie versioned object) S3
>> >> >>>>>> API support.
>> >> >>>>>> Please let me now any of the above work is in progress or some one
>> >> >>>>>> planned to work on.
>> >> >>>>>
>> >> >>>>>
>> >> >>>>> I opened an issue for bucket lifecycle (we already had an issue open
>> >> >>>>> for object expiration though). We do have bucket location already
>> >> >>>>> (part of the multi-region feature). Object versioning is definitely on
>> >> >>>>> our backlog and one that we'll hopefully implement sooner rather
>> >> >>>>> later.
>> >> >>>>> With regard to object notification, it'll require having a
>> >> >>>>> notification service which is a bit out of the scope. Integrating the
>> >> >>>>> gateway with such a service whouldn't be hard, but we'll need to have
>> >> >>>>> that first.
>> >> >>>>>
>> >> >>>>> Yehuda
>> >> >>>>>
>> >> >>>>>>
>> >> >>>>>> Thanks
>> >> >>>>>> Swami
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>> On Fri, Jul 25, 2014 at 9:19 PM, Sage Weil <sweil@redhat.com> wrote:
>> >> >>>>>>> On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
>> >> >>>>>>>> Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
>> >> >>>>>>>>
>> >> >>>>>>>> Link: http://ceph.com/docs/master/radosgw/s3/
>> >> >>>>>>>>
>> >> >>>>>>>> Is there plan to support the ?n supported item in the above table?
>> >> >>>>>>>> or
>> >> >>>>>>>> Any working on this?
>> >> >>>>>>>
>> >> >>>>>>> Yes.  Unfortunately this table isn't particularly detailed or accurate or
>> >> >>>>>>> up to date.   The main gap, I think, is versioned objects.
>> >> >>>>>>>
>> >> >>>>>>> Are there specfiic parts of the S3 API that are missing that you need?
>> >> >>>>>>> That sort of info is very helpful for prioritizing effort...
>> >> >>>>>>>
>> >> >>>>>>> sage
>> >> >>>>>> --
>> >> >>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> >>>>>> the body of a message to majordomo@vger.kernel.org
>> >> >>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
