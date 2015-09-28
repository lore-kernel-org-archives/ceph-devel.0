From: John Spray <jspray@redhat.com>
Subject: Re: libcephfs invalidate upcalls
Date: Mon, 28 Sep 2015 14:01:28 +0100
Message-ID: <CALe9h7eSd_SBhzTFh5fQ6q6psKafygBSV1_+SqEPneRmmHOFFQ@mail.gmail.com>
References: <1591173292.22231917.1443293684497.JavaMail.zimbra@redhat.com> <1783969650.22232082.1443294220601.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33397 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933535AbbI1NBt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 09:01:49 -0400
Received: by oixx17 with SMTP id x17so89384985oix.0
        for <ceph-devel@vger.kernel.org>; Mon, 28 Sep 2015 06:01:48 -0700 (PDT)
In-Reply-To: <1783969650.22232082.1443294220601.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Sep 26, 2015 at 8:03 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi John,
>
> I prototyped an invalidate upcall for libcephfs and the Gasesha Ceph fsal, building on the Client invalidation callback registrations.
>
> As you suggested, NFS (or AFS, or DCE) minimally expect a more generic "cached vnode may have changed" trigger than the current inode and dentry invalidates, so I extended the model slightly to hook cap revocation, feedback appreciated.

In cap_release, we probably need to be a bit more discriminating about
when to drop, e.g. if we've only lost our exclusive write caps, the
rest of our metadata might all still be fine to cache.  Is ganesha in
general doing any data caching?  I think I had implicitly assumed that
we were only worrying about metadata here but now I realise I never
checked that.

The awkward part is Client::trim_caps.  In the Client::trim_caps case,
the lru_is_expirable part won't be true until something has already
been invalidated, so there needs to be an explicit hook there --
rather than invalidating in response to cap release, we need to
invalidate in order to get ganesha to drop its handle, which will
render something expirable, and finally when we expire it, the cap
gets released.

In that case maybe we need a hook in ganesha to say "invalidate
everything you can" so that we don't have to make a very large number
of function calls to invalidate things.  In the fuse/kernel case we
can only sometimes invalidate a piece of metadata (e.g. we can't if
its flocked or whatever), so we ask it to invalidate everything.  But
perhaps in the NFS case we can always expect our invalidate calls to
be respected, so we could just invalidate a smaller number of things
(the difference between actual cache size and desired)?

John

>
> git@github.com:linuxbox2/ceph.git , branch invalidate
> git@github.com:linuxbox2/nfs-ganesha.git , branch ceph-invalidates
>
> thanks,
>
> Matt
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-761-4689
> fax.  734-769-8938
> cel.  734-216-5309
>
