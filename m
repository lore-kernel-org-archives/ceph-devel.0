From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] libceph: use keepalive2 to verify the mon session is alive
Date: Wed, 2 Sep 2015 17:25:25 +0800
Message-ID: <3313E8D4-6363-416A-AF0D-7BFF0C7ED0B8@redhat.com>
References: <CAOi1vP-c_VRVOSvF-YW7Q-+GXhWw8PZYzPha-K5Fr9yQbtjDtA@mail.gmail.com> <AFB5599E-A06C-480C-8A9C-C42C9FC9EFE1@redhat.com> <CAOi1vP-3Ea=4x01JhRGDC1xvtuyvt+oq0jOVQYxTw+NHoKsbeQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbbIBJZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Sep 2015 05:25:27 -0400
In-Reply-To: <CAOi1vP-3Ea=4x01JhRGDC1xvtuyvt+oq0jOVQYxTw+NHoKsbeQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> On Sep 2, 2015, at 17:12, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Wed, Sep 2, 2015 at 5:22 AM, Yan, Zheng <zyan@redhat.com> wrote:
>> timespec_to_jiffies() does not work this way. it convert time delta in form of timespec to time delta in form of jiffies.
> 
> Ah sorry, con->last_keepalive_ack is a realtime timespec from
> userspace.
> 
>> 
>> I will updated the patch according  to the rest comments .
> 
> I still want ceph_con_keepalive_expired() to handle interval == 0
> internally, so that opt->monc_ping_timeout can be passed without any
> checks in the caller.
> 
> I also noticed you added delay = max_t(unsigned long, delay, HZ); to
> __schedule_delayed().  Is it really necessary?
> 

Updated. please review.

Regards
Yan, Zheng