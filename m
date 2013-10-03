From: Gregory Farnum <greg@inktank.com>
Subject: Re: thought on storing bloom (hit) info
Date: Wed, 2 Oct 2013 17:07:23 -0700
Message-ID: <CAPYLRzh06oKo1Ch74GU_Lx9buZDKmp7extv9g53W7FhatFwMfA@mail.gmail.com>
References: <alpine.DEB.2.00.1310021654060.12714@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:45448 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab3JCAHZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Oct 2013 20:07:25 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so1794236wes.36
        for <ceph-devel@vger.kernel.org>; Wed, 02 Oct 2013 17:07:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1310021654060.12714@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Oct 2, 2013 at 5:02 PM, Sage Weil <sage@inktank.com> wrote:
> If we make this a special internal object we need to complicate recovery
> and namespacing to keep is separate from user data.  We also need to
> implement a new API for retrieving, trimming, and so forth.
>
> Instead, we could just store the in-progress and completed bloom filters
> (or even explicit hit list) as regular rados objects in a separate
> namespace.  The namespace could be '.ceph' or similar by default, but
> configurable in case the user wants something different for some reason.
>
> Normal recovery should work unmodified.
>
> The normal rados API could be used to fetch (or even delete) old info.
>
> I think the main challenge is making an object_locator_t that maps cleanly
> into a specific PG so that a particular object is always stored exactly
> with the PG.  This should be a pretty easy change to object_locator_t.
> In the mapping process, all we're doing is hashing the key string and
> mixing in the pool hash; here we'd just be able to specify the resulting
> value explicitly.
>
> Thoughts?
> sage

PG splitting?
That and other internal mechanisms are already going to need to treat
it as a special object. I think recovery will as well; what happens if
we're serving up writes during a long-running recovery but haven't
gotten to recovering that object yet when we need to persist?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
