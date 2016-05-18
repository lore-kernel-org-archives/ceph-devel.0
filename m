From: John Spray <jspray@redhat.com>
Subject: Re: Update on ceph-mgr
Date: Wed, 18 May 2016 12:26:30 +0100
Message-ID: <CALe9h7fDcEOv8XLzsL64xzo6LY_okSFUtJ10QPaJWcXyi6uOzA@mail.gmail.com>
References: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
 <295874104.352.1463569858689@ox.pcextreme.nl> <CALe9h7cg=FtP7s_V-OgmxSwwfJSi4fAH90-ehLnMXU3PxdRqRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35919 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcERL0u (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 07:26:50 -0400
Received: by mail-oi0-f51.google.com with SMTP id x201so71186010oif.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2016 04:26:50 -0700 (PDT)
In-Reply-To: <CALe9h7cg=FtP7s_V-OgmxSwwfJSi4fAH90-ehLnMXU3PxdRqRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, May 18, 2016 at 12:21 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, May 18, 2016 at 12:10 PM, Wido den Hollander <wido@42on.com> wrote:
>>
>> So is the idea that when you install 'ceph-mon' you get the API by default?
>
> No, it's a separate service.

...although I should add that it would be a default part of ceph
releases, and I expect many people would just put a ceph-mgr instance
alongside each ceph-mon instance.

>
>> Having a REST API for Ceph enabled at all times or with a simple click would be great for integrations with for example Salt.
>>
>> And why do you need HA at all, the API mainly talks to the mon, right?
>
> ceph-mgr will talk to mons, but it will also talk directly to other
> daemons, for e.g. gathering statistics.  Check out the earlier
> discussions on where this fits in and what it's for:
>
> http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/28944
> 1:51:00 here: https://www.youtube.com/watch?v=0gIqgxrmrJw
>
> Cheers,
> John
>
>> Wido
>>
>>> Cheers,
>>> John
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
