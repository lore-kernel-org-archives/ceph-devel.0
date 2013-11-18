From: Milosz Tanski <milosz@adfin.com>
Subject: I'd like to see enable / disable cookie work from atomic context
Date: Mon, 18 Nov 2013 11:59:28 -0500
Message-ID: <CANP1eJFU8Rc4nwNm0pxxrqEZ39c-DP7KoA1LJ2Zu1J2eCR3xzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:44317 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3KRQ7a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 11:59:30 -0500
Received: by mail-wg0-f51.google.com with SMTP id m15so6349755wgh.18
        for <ceph-devel@vger.kernel.org>; Mon, 18 Nov 2013 08:59:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

David,

I'd like to continue our conversation from IRC about making enable /
disable cookie from from atomic context. Maybe this diagram and the
description will detail it better.

remote1         MDS         thread 1            thread2     thread N
                            file_open(READ)
                            enable_cache()
file_open(WR)
                revoke_read()
                            spinlock()
                            lose_cache_cap()
                            spinunlock()
                                                start_read()
                            disable_cookie()
                            wait_on_ops()                   start_read()

The issue here is what happens in my scenario in thread2 where is
manages to schedule a possibly stale read in thread 2 is worrying.

What's worse is that disabling of the cookie waits on operations count
to drop to 0. But it doesn't seam to me like anything is stopping more
operations from getting queued.

Ideally what I'd like to see is an ability to enqueue a disable
barrier in the operation queue. This way we avoid both scenarios
(thread2, other threads) in the diagram above.  Hopefully that can be
done in atomic context and the rest of the disable work can be
deferred till later.

-- 
Milosz Tanski
CTO
10 East 53rd Street, 37th floor
New York, NY 10022

p: 646-253-9055
e: milosz@adfin.com
