From: Gregory Farnum <greg@inktank.com>
Subject: Re: cache tier blueprint (part 2)
Date: Fri, 8 Nov 2013 11:16:41 -0800
Message-ID: <CAPYLRzgmhso21XgOM8ZAvfr6Hcsuvbu0yd6g6NeNZcCOr_9Umw@mail.gmail.com>
References: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36353 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478Ab3KHTQm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Nov 2013 14:16:42 -0500
Received: by mail-wg0-f41.google.com with SMTP id b13so127580wgh.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 Nov 2013 11:16:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 7, 2013 at 6:56 AM, Sage Weil <sage@inktank.com> wrote:
> I typed up what I think is remaining for the cache tier work for firefly.
> Greg, can you take a look?  I'm most likely missing a bunch of stuff here.
>
>  http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rados_cache_pool_(part_2)
>
> This will be one of the meatier sessions at the upcoming CDS.  There will
> be a fair bit of work not just on the OSD side but also in building
> testing tools that exercise and validate the functionality, here, that
> may be a great way for a new contributer to get involved and help out.

This looks reasonably complete to me as an enumeration of areas, but
is definitely targeted at the cache pool use case rather than demoting
to cold storage. I'm not sure yet if we're going to want to use the
same agent/process/whatever in both use cases; do you want a separate
blueprint for that, or should we broaden this one?
-Greg
