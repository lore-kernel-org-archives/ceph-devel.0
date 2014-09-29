From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH v3 0/4] buffer alignment for erasure code SIMD
Date: Mon, 29 Sep 2014 11:18:03 -0400
Message-ID: <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
	<1411994072-18850-1-git-send-email-j@jannau.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:59442 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaI2PSF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 11:18:05 -0400
Received: by mail-ob0-f176.google.com with SMTP id vb8so4043241obc.35
        for <ceph-devel@vger.kernel.org>; Mon, 29 Sep 2014 08:18:03 -0700 (PDT)
In-Reply-To: <1411994072-18850-1-git-send-email-j@jannau.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Janne, I have a couple questions and forgive me if I missed something
from the past.

Did you consider using std::aligned_storage? That way you don't have
to worry as much about portability yourself. Also, there is a
boost::aligned_storage as well if Ceph can't build against C++11
goodness.

A second more general Ceph question is somewhat off-topic. What about
C++11 use in the Ceph code base (like in this case)? It's not
explicitly prohibited by the coding style document, but I imagine the
goal is to build on as many systems as possible and quite a few
supported distros have pretty old versions of GCC. I'm asking this
because I imagine some of the performance work that's about to happen
will want to use things like lockless queues, and then you get into
C++11 memory model and std::atomic... etc.

- Milosz

On Mon, Sep 29, 2014 at 8:34 AM, Janne Grunau <j@jannau.net> wrote:
> Hi,
>
> reworked patchset to address the comments in https://github.com/ceph/ceph/pull/2558
>
> variable alignment instead of the hardcoded 32-byte alignment
> fixed copy and paste error in a comment
> change buffer alignment for decoding too (much simpler than the encoding
> changes)
>
> I'll do a github pull request once the last make check run finishes
> locally.
>
> Also available from http://git.jannau.net/ceph.git/log/?h=buffer_align
>
> regards
>
> Janne
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
