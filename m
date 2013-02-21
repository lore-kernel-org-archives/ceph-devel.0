From: Martin B Nielsen <martin@unity3d.com>
Subject: Re: pg stuck in peering
Date: Thu, 21 Feb 2013 11:26:13 +0100
Message-ID: <CAD3n6hEzrMACSbFygh7=PM2z4zmXzKQ=n8oY7WiYy5JKUqMx2g@mail.gmail.com>
References: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:58055 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3BUK0O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Feb 2013 05:26:14 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so8703648obb.9
        for <ceph-devel@vger.kernel.org>; Thu, 21 Feb 2013 02:26:13 -0800 (PST)
In-Reply-To: <CAJH6TXiVQ8cqyL5Z-XKz8PqjyuVyg=wM67eg5830sMSp546ReA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

I think this one would better fit the ceph-user maillinglist.

Can you supply more information? You have some pgs down - seems like
you have some osd down; can you list output of ceph osd tree and
verify all your osd are actually running?

/Martin

On Thu, Feb 21, 2013 at 11:09 AM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> Hi
> I have some trouble on a test cluster.
> Many PGs are stuck in "peering" state from yesterday:
>
> pg 1.2 is peering, acting [3,4]
> pg 0.3 is peering, acting [3,4]
> pg 2.1 is peering, acting [3,4]
> pg 3.0 is peering, acting [3,4]
> pg 1.3 is peering, acting [1,4]
> pg 0.2 is peering, acting [3,4]
> pg 2.0 is peering, acting [3,4]
> pg 3.1 is peering, acting [1,4]
> pg 4.6 is down+peering, acting [4,0]
> pg 5.7 is peering, acting [3,1]
> pg 6.4 is down+peering, acting [4,0]
> pg 7.5 is peering, acting [3,1]
> pg 0.1 is active+degraded, acting [4,0]
> pg 2.3 is peering, acting [3,4]
> pg 3.2 is peering, acting [3,4]
> pg 4.5 is down+peering, acting [2,4]
> pg 5.4 is down+peering, acting [2,4]
> pg 6.7 is peering, acting [0,4]
> pg 7.6 is peering, acting [0,4]
> pg 1.1 is peering, acting [3,4]
> pg 0.0 is active+degraded, acting [4,0]
> pg 2.2 is peering, acting [1,4]
> pg 3.3 is peering, acting [2,4]
> pg 4.4 is peering, acting [1,4]
> pg 5.5 is down+peering, acting [4,0]
> pg 6.6 is peering, acting [3,1]
> pg 7.7 is down+peering, acting [2,4]
>
> HEALTH_WARN 332 pgs degraded; 316 pgs down; 316 pgs peering; 93 pgs
> stale; 316 pgs stuck inactive; 93 pgs stuck stale; 764 pgs stuck
> unclean
>
>
>
> any advice ? I think that a not healthy cluster prevent me to run RGW
> due to some timeout.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
