From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 16:24:23 +0300
Message-ID: <20150911132422.GC12899@gmail.com>
References: <20150911064256.GA12899@gmail.com>
 <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
 <20150911124704.GB12899@gmail.com>
 <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33036 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbbIKNY0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:24:26 -0400
Received: by wiclk2 with SMTP id lk2so64430020wic.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 06:24:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 11, 2015 at 05:59:56AM -0700, Sage Weil wrote:

> I wonder if, in addition, we should also allow scrub and deep-scrub 
> intervals to be set on a per-pool basis?

ceph osd pool set <pool> [deep-]scrub_interval N ?

I could do this too.

-- 
Mykola Golub
