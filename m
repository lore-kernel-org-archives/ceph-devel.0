From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: use keepalive2 to verify the mon session is alive
Date: Wed, 2 Sep 2015 18:23:41 +0300
Message-ID: <CAOi1vP_iL2mUyQ2eQKoqf8tccKpBfdMBLwxYo=aCAT+rYbkMLQ@mail.gmail.com>
References: <CAOi1vP-c_VRVOSvF-YW7Q-+GXhWw8PZYzPha-K5Fr9yQbtjDtA@mail.gmail.com>
	<AFB5599E-A06C-480C-8A9C-C42C9FC9EFE1@redhat.com>
	<CAOi1vP-3Ea=4x01JhRGDC1xvtuyvt+oq0jOVQYxTw+NHoKsbeQ@mail.gmail.com>
	<3313E8D4-6363-416A-AF0D-7BFF0C7ED0B8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34764 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbbIBPXo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 11:23:44 -0400
Received: by laeb10 with SMTP id b10so9728564lae.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2015 08:23:42 -0700 (PDT)
In-Reply-To: <3313E8D4-6363-416A-AF0D-7BFF0C7ED0B8@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 2, 2015 at 12:25 PM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On Sep 2, 2015, at 17:12, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Wed, Sep 2, 2015 at 5:22 AM, Yan, Zheng <zyan@redhat.com> wrote:
>>> timespec_to_jiffies() does not work this way. it convert time delta in form of timespec to time delta in form of jiffies.
>>
>> Ah sorry, con->last_keepalive_ack is a realtime timespec from
>> userspace.
>>
>>>
>>> I will updated the patch according  to the rest comments .
>>
>> I still want ceph_con_keepalive_expired() to handle interval == 0
>> internally, so that opt->monc_ping_timeout can be passed without any
>> checks in the caller.
>>
>> I also noticed you added delay = max_t(unsigned long, delay, HZ); to
>> __schedule_delayed().  Is it really necessary?
>>
>
> Updated. please review.

I was concerned about user facing option names and timeouts, since
that's what I had to deal with recently - those parts look OK to me
now.

Thanks,

                Ilya
