From: Patrick McGarry <patrick@inktank.com>
Subject: Usable Space
Date: Wed, 6 Mar 2013 06:48:09 -0800
Message-ID: <CAP8Oy=JrQiNYcwPNTqdyDzDk1A4LBEcSFzwLAqcgSFcUu-WhJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:65185 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282Ab3CFOsK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 09:48:10 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so6143351pbc.14
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 06:48:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>
Cc: a.iwanowski@ogicom.pl

Proxy-ing this in for a user I had a discussion with on irc this morning:

The question is "is there a way to display usable space based on
replication level?"

Ultimately what would be nice is to see something like the following:

-------------------
$: sudo ceph --usable-space

Total Space: X / Y  ||  Usable Space: A / B

By Pools:
rbd -- J / K
foo -- F / G
bar -- H / I
baz -- C / D

---------------------

Would it be possible to add this in at some point? Seems like a great
addition to go with some of the other 'usability enhancements' that
are planned.  Or would this get computationally sticky based on having
many pools with different replication levels?


Best Regards,

-- 
Patrick McGarry
Director, Community
Inktank

http://ceph.com  ||  http://inktank.com
@scuttlemonkey || @ceph || @inktank
