From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop DNS/topology details
Date: Wed, 20 Feb 2013 09:27:04 -0800
Message-ID: <E6DCD080-3F18-40D2-95F1-EE66B1C468CB@cs.ucsc.edu>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com> <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu> <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51224 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933947Ab3BTR1H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 12:27:07 -0500
Received: by mail-pa0-f45.google.com with SMTP id kl14so4127868pab.18
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 09:27:05 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>


On Feb 19, 2013, at 4:39 PM, Sage Weil <sage@inktank.com> wrote:

> However, we do have host and rack information in the crush map, at least 
> for non-customized installations.  How about something like
> 
>  string ceph_get_osd_crush_location(int osd, string type);
> 
> or similar.  We could call that with "host" and "rack" and get exactly 
> what we need, without making any changes to the data structures.

This would then be used in conjunction with an interface:

 ceph_offset_to_osds(offset, vector<int>& osds)
    ...
    osdmpa->pg_to_acting_osds(osds)
    ...

or something like this that replaces the current extent-to-sockaddr interface? The proposed interface about would do the host/ip mapping, as well as the topology mapping?

- Noah

