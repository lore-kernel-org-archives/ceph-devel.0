From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RBD format changes and layering
Date: Tue, 29 May 2012 15:08:42 -0700
Message-ID: <CADvuQRF3Wo9VL9n7dnsu8ADBjJ+rUqkq33bk0QPwDo+z2WDbLw@mail.gmail.com>
References: <4FBEBECD.6040403@inktank.com> <4FC010B9.3030101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47140 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754303Ab2E2WJE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 May 2012 18:09:04 -0400
Received: by pbbrp8 with SMTP id rp8so6550409pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 May 2012 15:09:03 -0700 (PDT)
In-Reply-To: <4FC010B9.3030101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 25, 2012 at 4:07 PM, Josh Durgin <josh.durgin@inktank.com> wrote:
> To check whether children exist, you can iterate over
> all the pools and check the rbd_clones object in each one.
> Since the number of pools is relatively small, this isn't
> very expensive. If the pool is deleted, by definition all the children in it
> are deleted.
>
> With separate namespaces in the future, this will be a bit more
> expensive, but it's only needed at base image deletion time,
> which is relatively rare. Deleting the image itself already
> requires an I/O per object, so this is probably not the slow
> part anyway.
>
> Yehuda, Tv, did I miss anything?

One thing: that's still racy, and we discussed a solution.

1. A: walk through all pools, look for clones, find none
2. B: create a clone
3. A: rbd unpreserve parent
4. A: rbd rm parent

Oopsie.

To avoid that, I proposed a "deleting" flag. Clones can only be
created when parent is preserved && !deleting. Now,

1. A: rbd deleting parent
2. A: walk through all pools, look for clones, find none
3. B: attempt to create a clone, fails
...

Now, that doesn't have to be strictly "deleting".. "going_unpreserved"
or something; instead of deletion, the intended operation might be
starting a vm against the parent image to e.g. add security updates.

And, as we discussed, these flags would be per snapshot (or also on
the master image, if you want to support that). Thus, one snapshot can
preserved while an older one is scheduled for deletion.
