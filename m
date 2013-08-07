From: Milosz Tanski <milosz@adfin.com>
Subject: API request
Date: Tue, 6 Aug 2013 23:46:19 -0400
Message-ID: <CANP1eJG-QPi9Mfeh8yb08mDjKaRW-Jx4OsRYuJ5pyV==hKJ5+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:56247 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab3HGDqU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Aug 2013 23:46:20 -0400
Received: by mail-we0-f182.google.com with SMTP id u55so1062769wes.41
        for <ceph-devel@vger.kernel.org>; Tue, 06 Aug 2013 20:46:19 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

David,

I would like to find out if you could add a new API for re-validating
a cookie. My use case is still FSCache support for Ceph.

Ceph has a notion of capabilities (like CACHE cap) that can be
granted, revoked or given up. For example the code there to give up
the cache cap when the inode file reference count goes to 0. In that
case it calls a invalidate on the data. Obviously. I would like to
have to avoid invalidating the data since it's entirely likely when we
re-open it next it'll still not have changed. There's also cases

I'm not sure if this would be the best solution, but what I imagined
would be a new call to revalidate the data cookie
(fscache_cookie_revalidate). The revalidate call could queue up task
to validate the data (not allow any reads / writes till then) and if
it's stale, then to invalidate the data. If an empty cookie it could
skip all this work.

I would use that functionality to re-validate my in memory cookie
after getting a cache cap granted and avoid a whole lot of mess
closing and opening the cookies (unless there's a local writer).

What do you think?

Thanks,
- Milosz
