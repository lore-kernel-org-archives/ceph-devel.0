From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: use keepalive2 to verify the mon session is alive
Date: Wed, 2 Sep 2015 18:59:19 +0300
Message-ID: <CAOi1vP_6JsWg6tbaftCcUA6w_MS27m0pC8nb12OMHUXJ5NyzqQ@mail.gmail.com>
References: <CAOi1vP-c_VRVOSvF-YW7Q-+GXhWw8PZYzPha-K5Fr9yQbtjDtA@mail.gmail.com>
	<AFB5599E-A06C-480C-8A9C-C42C9FC9EFE1@redhat.com>
	<CAOi1vP-3Ea=4x01JhRGDC1xvtuyvt+oq0jOVQYxTw+NHoKsbeQ@mail.gmail.com>
	<3313E8D4-6363-416A-AF0D-7BFF0C7ED0B8@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34950 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213AbbIBP7V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 11:59:21 -0400
Received: by lbpo4 with SMTP id o4so8867765lbp.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2015 08:59:20 -0700 (PDT)
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

One other thing you might want to do is to / 3 instead of >> 2 in
delayed_work().  That way the tick interval in the non-hunting case is
going to be 10 seconds, which matches the default for ping interval
(mon_client_ping_interval) in userspace.

Thanks,

                Ilya
