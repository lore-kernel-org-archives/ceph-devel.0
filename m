From: Milosz Tanski <milosz@adfin.com>
Subject: Re: API request
Date: Wed, 7 Aug 2013 09:15:43 -0400
Message-ID: <CANP1eJFQ-H8qje1YEDLP+YOCStX51OGqK=6SR=UibBhE9OwMdg@mail.gmail.com>
References: <CANP1eJG-QPi9Mfeh8yb08mDjKaRW-Jx4OsRYuJ5pyV==hKJ5+A@mail.gmail.com>
	<28791.1375869957@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:61489 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab3HGNPp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Aug 2013 09:15:45 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so3990411wiw.4
        for <ceph-devel@vger.kernel.org>; Wed, 07 Aug 2013 06:15:44 -0700 (PDT)
In-Reply-To: <28791.1375869957@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>, jiayisuse@gmail.com

On Wed, Aug 7, 2013 at 6:05 AM, David Howells <dhowells@redhat.com> wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
>
>> I would like to find out if you could add a new API for re-validating
>> a cookie. My use case is still FSCache support for Ceph.
>>
>> Ceph has a notion of capabilities (like CACHE cap) that can be
>> granted, revoked or given up. For example the code there to give up
>> the cache cap when the inode file reference count goes to 0.
>
> What exactly do you mean here?  When the last iput() happens and an inode is
> merely discarded from memory (and not necessarily deleted)?

Well there's a inode caching, and when the last userspace reference
(file handle) goes away the code tries to dispose of the cache cap
quickly.

>
>> In that case it calls a invalidate on the data. Obviously. I would like to
>> have to avoid invalidating the data since it's entirely likely when we
>> re-open it next it'll still not have changed.
>
> You could instead just cease calling on fscache for that inode rather than
> invalidating the cache object, perhaps by setting a flag to tell ceph's
> read/write ignore caching.  Ideally you'd release the cooie if you're not
> using it so that (a) it can be culled if the cache needs to make space and (b)
> it doesn't use up unswappable kernel resources.

The funny thing is, I'm looking for the same API that Hongyi
implemented in these patches:

0001-interface-to-check-cache-consistency.patch
0004-fscache-interface-to-check-cache-consistency.patch
0006-check-fscache-consistency-before-invalidating.patch

I can already check if I can have the cache cap from the server to see
if i should read or write to the fscache. What I want to solve is
basically the situation here:

1. gain cache cap -> 2. meta server revokes cache cap (or we release
it due to open files) -> 3. gain cache cap from meta (or reopen the
file)

What I'd like to avoid is having to release the cache cap at step 2,
and then just revalidate the file at step 3.

Because the we could get stuck in this gain cach cap, lose cap cycle
in a file due to a large activity I learned how incredibly racy this
can be. Like if we're disposing of a cookie in the the beginning of a
readpages call. One solution is to add lots of locking (I considered a
rw semaphore here) but you still end up having cases when you're
inside spin locks.

The other solution is to create the cookie the first the time file is
open for read and keep it around for the lifetime of the inode.
Calling invalidate the when the file is open for write and using the
re-check cookie when we get the cache cap (and invalidating as
needed). This is my pefered solutions, it's a lot easier to get right.

>
>> There's also cases
>
> There's an incomplete sentence here.  Was something missed or should this have
> been deleted?

Sorry it was like 1am when I wrote it this after like 8 hours or so of
hacking. What I meant to say is, there's cases when there's cases when
the cache cap get revoked what seams spuriously due to operations from
other clients that do not change the file.


>
> David
