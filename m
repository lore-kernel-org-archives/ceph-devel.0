From: Gregory Farnum <greg@inktank.com>
Subject: Suspend and the ceph clients
Date: Wed, 14 May 2014 15:07:44 -0700
Message-ID: <CAPYLRzhr7XA9sBArqe=5bPaXd3XPwgVGo_QOM024-J_ovh93BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:63261 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbaENWHp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 May 2014 18:07:45 -0400
Received: by mail-qc0-f181.google.com with SMTP id m20so356767qcx.26
        for <ceph-devel@vger.kernel.org>; Wed, 14 May 2014 15:07:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, Zheng Yan <ukernel@gmail.com>

There's a recent ticket discussing the behavior of ceph-fuse after the
machine it's running on has been suspended:
http://tracker.ceph.com/issues/8291

In short, CephFS clients which are disconnected from the cluster for a
sufficiently long time are generally forbidden from reconnecting =E2=80=
=94
after a configurable timeout, their "capabilities" on inodes and
dentries are revoked, and other users are allowed to change them. If
the client then comes back, it's entirely possible it has incompatible
changes to the tree, so we don't let it reconnect in order to prevent
that. (We could make the system smarter in some situations, if for
instance nobody has changed the given filesystem data in the
meanwhile, but that's hard and a problem for another day.)

Apparently, ceph-fuse does exactly this, as we expect (although we
have newly-merged features which let the admin force a reconnect). But
the kernel client does allow a reconnect. I haven't done this myself,
so the first question is just a fact check for Sage or Zheng:
1) What is the kernel client doing after suspend? Does it in fact
reconnect under situations where ceph-fuse won't, and what are they?

More interestingly, while suspended systems aren't part of our normal
target use case, they'd be nice to support well. The trivial solution
would be to somehow flush out all dirty data on suspend, and then on
wake or when we discover we have a reset session, we can clean out our
cache and reconnect as a new client if we have no dirty data.
Unfortunately, I don't know anything about Linux's suspend
functionality or APIs, and my weak attempts at googling and grepping
aren't turning anything up. So a question to everybody:

2) What notifications does Linux send, and what filesystem mechanisms
does it invoke, when it is suspending?
I see that it has in the past forced a sync whenever suspending, but I
think that's no longer required. Are there other interfaces we can
rely on, or use heuristically?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
