From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Mon, 28 Jul 2014 13:05:35 -0700
Message-ID: <CABBk=J-fSR8mc7LQBLcUQDPkgC8NaSfvRB-2ED71qSvQzLX8Cw@mail.gmail.com>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com>
	<CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
	<alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
	<CANA9Uk468XOE1cr935HY1y+tSnu-xp6QPaj7uCpZNQbJhg-pOA@mail.gmail.com>
	<CABBk=J8+3K28M-RNf+ULx0TnTMmGxdymJDLeFMft-EX8PhS_4A@mail.gmail.com>
	<CANA9Uk4JGm_2L_VnGsOgfpsX17=Ja4LLDaVNXzKJe-ZkY=ya9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:52384 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaG1UFf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 16:05:35 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so7407059ier.13
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jul 2014 13:05:35 -0700 (PDT)
In-Reply-To: <CANA9Uk4JGm_2L_VnGsOgfpsX17=Ja4LLDaVNXzKJe-ZkY=ya9A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Bucket lifecycle:
http://tracker.ceph.com/issues/8929

Bucket notification:
http://tracker.ceph.com/issues/8956

On Sun, Jul 27, 2014 at 12:54 AM, M Ranga Swami Reddy
<swamireddy@gmail.com> wrote:
> Good no know the details. Can you please share the issue ID for bucket
> lifecycle? My team also could start help here.
> Regarding the notification - Do we have the issue ID?
> Yes, the object versioning will be backlog one - I strongly feel we
> start working on this asap.
>
> Thanks
> Swami
>
> On Fri, Jul 25, 2014 at 11:31 PM, Yehuda Sadeh <yehuda@redhat.com> wrote:
>> On Fri, Jul 25, 2014 at 10:14 AM, M Ranga Swami Reddy
>> <swamireddy@gmail.com> wrote:
>>> Thanks for quick reply.
>>> Yes,  versioned object - missing in ceph ATM
>>> Iam looking for: bucket lifecylce (get/put/delete), bucket location,
>>> put object notification and object restore (ie versioned object) S3
>>> API support.
>>> Please let me now any of the above work is in progress or some one
>>> planned to work on.
>>
>>
>> I opened an issue for bucket lifecycle (we already had an issue open
>> for object expiration though). We do have bucket location already
>> (part of the multi-region feature). Object versioning is definitely on
>> our backlog and one that we'll hopefully implement sooner rather
>> later.
>> With regard to object notification, it'll require having a
>> notification service which is a bit out of the scope. Integrating the
>> gateway with such a service whouldn't be hard, but we'll need to have
>> that first.
>>
>> Yehuda
>>
>>>
>>> Thanks
>>> Swami
>>>
>>>
>>> On Fri, Jul 25, 2014 at 9:19 PM, Sage Weil <sweil@redhat.com> wrote:
>>>> On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
>>>>> Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
>>>>>
>>>>> Link: http://ceph.com/docs/master/radosgw/s3/
>>>>>
>>>>> Is there plan to support the ?n supported item in the above table?
>>>>> or
>>>>> Any working on this?
>>>>
>>>> Yes.  Unfortunately this table isn't particularly detailed or accurate or
>>>> up to date.   The main gap, I think, is versioned objects.
>>>>
>>>> Are there specfiic parts of the S3 API that are missing that you need?
>>>> That sort of info is very helpful for prioritizing effort...
>>>>
>>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
