From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: http://tracker.ceph.com/issues/16416
Date: Thu, 23 Jun 2016 10:03:36 +0800
Message-ID: <CACJqLyadVROF6u0MnFxRKPo2m4V39HhHU9VbPBC_EW4MFMZbww@mail.gmail.com>
References: <CAN=+7FXx6YMjeGUPuHgRGP+YMbwr19HD+A49SniDOHBNy-HNhQ@mail.gmail.com>
 <CAN=+7FWZ+Lr3VsgqBJbeVKOFqF67jQ1N5nFX9xCWDEvQAcZ8dA@mail.gmail.com> <CAN=+7FXTcW4Qc7DjhcKyB_guUsRTFgkZxRhzoM96X-rvCRhzCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36066 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbcFWCDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 22:03:38 -0400
Received: by mail-vk0-f46.google.com with SMTP id u64so86821007vkf.3
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 19:03:38 -0700 (PDT)
In-Reply-To: <CAN=+7FXTcW4Qc7DjhcKyB_guUsRTFgkZxRhzoM96X-rvCRhzCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 23, 2016 at 2:24 AM, Samuel Just <sjust@redhat.com> wrote:
> I just reverted back to simple by default on master.  Once we get a
> cleaner run with async, we can put it back (hopefully soon).
> -Sam
>
> On Wed, Jun 22, 2016 at 10:31 AM, Samuel Just <sjust@redhat.com> wrote:
>> http://tracker.ceph.com/issues/16418 also, I think.

Yes, we just merge the fix.

>> -Sam
>>
>> On Wed, Jun 22, 2016 at 9:45 AM, Samuel Just <sjust@redhat.com> wrote:
>>> I think this may be due to an async messenger thing, can you take a look?

Oh, I will look at these hang jobs.

>>> -sam



-- 
Best Regards,

Wheat
