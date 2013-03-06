From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Usable Space
Date: Wed, 6 Mar 2013 09:49:02 -0800
Message-ID: <4394646E-A8B7-42AD-9F10-F7001845CAA8@inktank.com>
References: <CAP8Oy=JrQiNYcwPNTqdyDzDk1A4LBEcSFzwLAqcgSFcUu-WhJg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:50845 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213Ab3CFRtO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 12:49:14 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so6297818pbc.35
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 09:49:13 -0800 (PST)
In-Reply-To: <CAP8Oy=JrQiNYcwPNTqdyDzDk1A4LBEcSFzwLAqcgSFcUu-WhJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, "a.iwanowski@ogicom.pl" <a.iwanowski@ogicom.pl>

You're aware of the just-added ceph df?  I don't know it well enough to know if it's a solution, but it's in that space...

On Mar 6, 2013, at 6:48 AM, Patrick McGarry <patrick@inktank.com> wrote:

> Proxy-ing this in for a user I had a discussion with on irc this morning:
> 
> The question is "is there a way to display usable space based on
> replication level?"
> 
> Ultimately what would be nice is to see something like the following:
> 
> -------------------
> $: sudo ceph --usable-space
> 
> Total Space: X / Y  ||  Usable Space: A / B
> 
> By Pools:
> rbd -- J / K
> foo -- F / G
> bar -- H / I
> baz -- C / D
> 
> ---------------------
> 
> Would it be possible to add this in at some point? Seems like a great
> addition to go with some of the other 'usability enhancements' that
> are planned.  Or would this get computationally sticky based on having
> many pools with different replication levels?
> 
> 
> Best Regards,
> 
> -- 
> Patrick McGarry
> Director, Community
> Inktank
> 
> http://ceph.com  ||  http://inktank.com
> @scuttlemonkey || @ceph || @inktank
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
