From: David Howells <dhowells@redhat.com>
Subject: Re: API request
Date: Wed, 07 Aug 2013 11:05:57 +0100
Message-ID: <28791.1375869957@warthog.procyon.org.uk>
References: <CANP1eJG-QPi9Mfeh8yb08mDjKaRW-Jx4OsRYuJ5pyV==hKJ5+A@mail.gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932375Ab3HGKGC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Aug 2013 06:06:02 -0400
In-Reply-To: <CANP1eJG-QPi9Mfeh8yb08mDjKaRW-Jx4OsRYuJ5pyV==hKJ5+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

Milosz Tanski <milosz@adfin.com> wrote:

> I would like to find out if you could add a new API for re-validating
> a cookie. My use case is still FSCache support for Ceph.
> 
> Ceph has a notion of capabilities (like CACHE cap) that can be
> granted, revoked or given up. For example the code there to give up
> the cache cap when the inode file reference count goes to 0.

What exactly do you mean here?  When the last iput() happens and an inode is
merely discarded from memory (and not necessarily deleted)?

> In that case it calls a invalidate on the data. Obviously. I would like to
> have to avoid invalidating the data since it's entirely likely when we
> re-open it next it'll still not have changed.

You could instead just cease calling on fscache for that inode rather than
invalidating the cache object, perhaps by setting a flag to tell ceph's
read/write ignore caching.  Ideally you'd release the cooie if you're not
using it so that (a) it can be culled if the cache needs to make space and (b)
it doesn't use up unswappable kernel resources.

> There's also cases

There's an incomplete sentence here.  Was something missed or should this have
been deleted?

David
