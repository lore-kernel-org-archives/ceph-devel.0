From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop DNS/topology details
Date: Wed, 20 Feb 2013 09:59:29 -0800
Message-ID: <D405F6AD-81F8-440D-AEFF-5DC051A028B9@cs.ucsc.edu>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com> <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu> <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net> <E6DCD080-3F18-40D2-95F1-EE66B1C468CB@cs.ucsc.edu> <alpine.DEB.2.00.1302200930060.26205@cobra.newdream.net> <648CA9DB-73D5-4C1B-8852-9E41F5784788@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:43078 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab3BTR7b convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 12:59:31 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so3629785dal.1
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 09:59:30 -0800 (PST)
In-Reply-To: <648CA9DB-73D5-4C1B-8852-9E41F5784788@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>


On Feb 20, 2013, at 9:57 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> 
>    vector<int> osds;
>  }
> 
>  ceph_get_file_extents(file, offset, length, vector<extent>& extents);
> 
> Then we could re-use the Striper or something?
> 
> -Noah

Although, I think your previous suggestion would be much simpler to do for the C api :)