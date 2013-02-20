From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Hadoop DNS/topology details
Date: Wed, 20 Feb 2013 09:57:59 -0800
Message-ID: <648CA9DB-73D5-4C1B-8852-9E41F5784788@cs.ucsc.edu>
References: <13BF7821-647C-4234-B696-5AA41ECCD6E5@cs.ucsc.edu> <CAPYLRzjy-TCTobh1mi1=d9omx0ZWvEce6ZB9vvf3ON5MVaC-MA@mail.gmail.com> <16038FC6-8930-46AE-A5C5-1169230CDDA8@cs.ucsc.edu> <alpine.DEB.2.00.1302191637520.18860@cobra.newdream.net> <E6DCD080-3F18-40D2-95F1-EE66B1C468CB@cs.ucsc.edu> <alpine.DEB.2.00.1302200930060.26205@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:64206 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933769Ab3BTR6B convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 12:58:01 -0500
Received: by mail-da0-f53.google.com with SMTP id g27so537124dan.12
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 09:58:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302200930060.26205@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joe Buck <jbbuck@gmail.com>


On Feb 20, 2013, at 9:31 AM, Sage Weil <sage@inktank.com> wrote:

>> or something like this that replaces the current extent-to-sockaddr 
>> interface? The proposed interface about would do the host/ip mapping, as 
>> well as the topology mapping?
> 
> Yeah.  The ceph_offset_to_osds should probably also have an (optional?) 
> out argument that tells you how long the extent is starting from offset 
> that is on those devices.  Then you can do another call at offset+len to 
> get the next segment.


It'd be nice to hide the striping strategy so we don't have to reproduce it in the Hadoop shim as we currently do, and which is needed with an interface using only an offset (we have to know the stripe unit to jump to the next extent). So, something like this might work:

  struct extent {
    loff_t offset, length;
    vector<int> osds;
  }

  ceph_get_file_extents(file, offset, length, vector<extent>& extents);

Then we could re-use the Striper or something?

-Noah