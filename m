From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: libcephfs invalidate upcalls
Date: Mon, 28 Sep 2015 10:03:55 -0400 (EDT)
Message-ID: <1451813289.22645427.1443449035074.JavaMail.zimbra@redhat.com>
References: <1591173292.22231917.1443293684497.JavaMail.zimbra@redhat.com> <1783969650.22232082.1443294220601.JavaMail.zimbra@redhat.com> <CALe9h7eSd_SBhzTFh5fQ6q6psKafygBSV1_+SqEPneRmmHOFFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53336 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932920AbbI1OD4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Sep 2015 10:03:56 -0400
In-Reply-To: <CALe9h7eSd_SBhzTFh5fQ6q6psKafygBSV1_+SqEPneRmmHOFFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-761-4689
fax.  734-769-8938
cel.  734-216-5309

----- Original Message -----
> From: "John Spray" <jspray@redhat.com>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Monday, September 28, 2015 9:01:28 AM
> Subject: Re: libcephfs invalidate upcalls
> 
> On Sat, Sep 26, 2015 at 8:03 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> > Hi John,
> >
> > I prototyped an invalidate upcall for libcephfs and the Gasesha Ceph fsal,
> > building on the Client invalidation callback registrations.
> >
> > As you suggested, NFS (or AFS, or DCE) minimally expect a more generic
> > "cached vnode may have changed" trigger than the current inode and dentry
> > invalidates, so I extended the model slightly to hook cap revocation,
> > feedback appreciated.
> 
> In cap_release, we probably need to be a bit more discriminating about
> when to drop, e.g. if we've only lost our exclusive write caps, the
> rest of our metadata might all still be fine to cache.  Is ganesha in
> general doing any data caching?  I think I had implicitly assumed that
> we were only worrying about metadata here but now I realise I never
> checked that.

Ganesha isn't currently, though it did once, and is likely to again, at some point.

The exclusive write cap is in fact something with a direct mapping to NFSv4 delegations,
so we do want to be able to trigger a recall, in this case.

> 
> The awkward part is Client::trim_caps.  In the Client::trim_caps case,
> the lru_is_expirable part won't be true until something has already
> been invalidated, so there needs to be an explicit hook there --
> rather than invalidating in response to cap release, we need to
> invalidate in order to get ganesha to drop its handle, which will
> render something expirable, and finally when we expire it, the cap
> gets released.

Ok, sure.

> 
> In that case maybe we need a hook in ganesha to say "invalidate
> everything you can" so that we don't have to make a very large number
> of function calls to invalidate things.  In the fuse/kernel case we
> can only sometimes invalidate a piece of metadata (e.g. we can't if
> its flocked or whatever), so we ask it to invalidate everything.  But
> perhaps in the NFS case we can always expect our invalidate calls to
> be respected, so we could just invalidate a smaller number of things
> (the difference between actual cache size and desired)?

As you noted above, what we're invalidating a cache entry.  With Dan's
mdcache work, we might no longer be caching at the Ganesha level, but
I didn't assume that here.

Matt

> 
> John
> 
> >
> > git@github.com:linuxbox2/ceph.git , branch invalidate
> > git@github.com:linuxbox2/nfs-ganesha.git , branch ceph-invalidates
> >
> > thanks,
> >
> > Matt
> >
> > --
> > Matt Benjamin
> > Red Hat, Inc.
> > 315 West Huron Street, Suite 140A
> > Ann Arbor, Michigan 48103
> >
> > http://www.redhat.com/en/technologies/storage
> >
> > tel.  734-761-4689
> > fax.  734-769-8938
> > cel.  734-216-5309
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
