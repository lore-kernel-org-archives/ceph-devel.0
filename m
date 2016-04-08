From: Shinobu Kinjo <shinobu.kj@gmail.com>
Subject: Re: Started developing a deduplication feature
Date: Sat, 9 Apr 2016 06:50:50 +0900
Message-ID: <CAFdRU72ebRqvdVaV81+RbW8FotHYdLkfoU3aX3kh2fN2tKhEXQ@mail.gmail.com>
References: <8737r5w89m.fsf@uni-mainz.de>
	<alpine.DEB.2.11.1604011723500.22014@cpach.fuggernut.com>
	<87wpodv99m.fsf@uni-mainz.de>
	<871t6gkuuz.fsf@uni-mainz.de>
Reply-To: skinjo@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37041 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203AbcDHVuv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 17:50:51 -0400
Received: by mail-ig0-f175.google.com with SMTP id g8so27616126igr.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 14:50:51 -0700 (PDT)
In-Reply-To: <871t6gkuuz.fsf@uni-mainz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <lauhoff@uni-mainz.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Apr 9, 2016 at 12:01 AM, Marcel Lauhoff <lauhoff@uni-mainz.de> wrote:
>
> Hi list,
> short recap of the dedup topic from the CDM on Wednesday:
>
>
> The main change from the original mail is not to add a PG backend, but
> rather use Object Redirects (Tiering v2).
> Another backend would have to implement its own replication for
> recipes and increase the OSD code base just for dedup. Redirects are
> useful beyond deduplication.
>
>
> The CAS pool design was refined: An object class should handle the ref
> counting and content addressing. The pool should also only
> allow access through this object class to prevent collisions with
> regular objects and support immutable objects.
>
>
> There was also the idea of client-side deduplication by using metadata
> that clients like RGW store. This would save the additional round trip
> that object redirects add.

Sounds good.

>
>
> I'll be working on the CAS pool first, since there
> is ongoing refactoring in the ReplicatedPG code base. I'll work out a
> more detailed design document for the CAS pool soon.

I will be able to test it against if you don't mind.

>
>
> ~irq0
> --
> Marcel Lauhoff
> Mail: lauhoff@uni-mainz.de
> XMPP: mlauhoff@jabber.uni-mainz.de
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Shinobu

-- 
Email:
shinobu@linux.com
GitHub:
shinobu-x
Blog:
Life with Distributed Computational System based on OpenSource
