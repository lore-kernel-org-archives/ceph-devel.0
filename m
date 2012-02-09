From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: Questions about OSD recovery
Date: Wed, 08 Feb 2012 19:14:20 -0800
Message-ID: <4F333A0C.7080902@dreamhost.com>
References: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40051 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747Ab2BIDOW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2012 22:14:22 -0500
In-Reply-To: <CANExM-NCijMZX89Bp6wOGkLmkqKeqiqhnMJ8VKKN_QSQXnm7LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 02/07/2012 06:54 PM, Henry C Chang wrote:
> Hi all,
>
> I did some experiments on the OSD and had some questions about it.
>
> I removed one object directly from the osd data store. As expected,
> the osd didn't notice it until I manually scrubbed the pg. However,
> the scrubbing doen't trigger the recovery automatically. I had to do
> 'ceph pg repair' to fix it.
>
> So, my first question is: can the recovery process be triggered
> automatically once the scrubbing has detected the inconsistency?

It's possible to do what the current repair code does
automatically, but this would be a bad idea since it just takes
the first osd (with primary before replicas) to have the object
as authoritative, and copies it to all the relevant osds. If the
primary has a corrupt copy, this corruption will spread to other
osds. In your case, since you removed the object entirely, repair
could correct it.

In general, if an object is corrupted, there's no way to tell
which one is correct right now. You could use btrfs checksumming
underneath the osd to protect against this, but the osds don't
checksum the objects themselves. Scrub/repair could certainly be
a lot smarter. It's been on the todo list for a while, but we
haven't gotten to it yet.

> Then, I tried again and removed another object. But this time, I
> didn't scrub the pg. I restarted the osd. As expected, the osd didn't
> notice that, either.
>
> My second question is: is it possible to check the existence of the
> objects when scanning the pg during osd startup? Does it make sense to
> do so?

Detecting missing objects on startup is possible by looking at
the pg log and comparing it to the objects on disk, but this can
be a pretty expensive operation. The osd might also be out of
date, so it's log might be useless (for example it could have
divergent history that was not acked). It can't know how many
current objects that should be there aren't until it goes through
peering (to get an up to date and authoritative log) and
recovery (to get missing data the logs say should be there). This
is why scrub skips pgs that aren't active+clean. More details of
peering can be found at http://ceph.newdream.net/docs/latest/dev/peering/.
