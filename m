From: kefu chai <tchaikov@gmail.com>
Subject: Re: 12.2.2 status
Date: Mon, 30 Oct 2017 16:28:50 +0800
Message-ID: <CAJE9aONYprSpV=xBP2=zUtr-WaPwGn6+Ho6f7XBy1r=g6T0efg@mail.gmail.com>
References: <87fua6c4xy.fsf@suse.com> <CA+aFP1AVdD9Tt0q3ZThOQ7W24KdWHqp+C=fCjpJSAm5FCF56Vw@mail.gmail.com>
 <763BB32D-F660-40FD-9CCB-1DE4B543365B@suse.de> <CA+aFP1AfgPSYg83+48LOZmFzFc8+i3igwrtG-1KtTKNN5d2J_w@mail.gmail.com>
 <CA+aFP1Ax5NmAaXM6bJuHTUD4X9ieGUpfrea4m=4u8fOP5COVhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:52736 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbdJ3I2v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Oct 2017 04:28:51 -0400
Received: by mail-oi0-f54.google.com with SMTP id c202so20630218oih.9
        for <ceph-devel@vger.kernel.org>; Mon, 30 Oct 2017 01:28:51 -0700 (PDT)
In-Reply-To: <CA+aFP1Ax5NmAaXM6bJuHTUD4X9ieGUpfrea4m=4u8fOP5COVhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Karol Mroz <kmroz@suse.de>, Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Sadeh-Weinraub, Yehuda" <yehuda@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>

Abhishek,

 it'd be great if we can include:

- https://github.com/ceph/ceph/pull/18620
- https://github.com/ceph/ceph/pull/18621

On Fri, Oct 27, 2017 at 10:02 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> Hate to be that guy, but this [1] just popped up this morning and I
> think it should be backported into 12.2.2 once it's merged into
> master.
>
> Thanks.
>
> [1] http://tracker.ceph.com/issues/21956
>
> On Thu, Oct 26, 2017 at 6:42 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>> Awesome, thanks!
>>
>> On Thu, Oct 26, 2017 at 6:38 PM, Karol Mroz <kmroz@suse.de> wrote:
>>> Hi Jason,
>>>
>>> Following PRs are up to address your luminous backport tickets...
>>>
>>>> On Oct 26, 2017, at 8:40 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>
>>>> I would like to see the following additional tickets:
>>>>
>>>> http://tracker.ceph.com/issues/21918
>>>
>>> https://github.com/ceph/ceph/pull/18529
>>>
>>>
>>>> http://tracker.ceph.com/issues/21688
>>>
>>> https://github.com/ceph/ceph/pull/18564
>>>
>>>
>>>> http://tracker.ceph.com/issues/21914
>>>
>>> https://github.com/ceph/ceph/pull/18566
>>>
>>> Regards,
>>> Karol Mroz
>>> kmroz@suse.de
>>>
>>>
>>>
>>
>>
>>
>> --
>> Jason
>
>
>
> --
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
