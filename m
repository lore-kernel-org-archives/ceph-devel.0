From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 16:44:57 +0300
Message-ID: <CABYiri9Lpbj43ZdHxQ8c0gMCBCo5w1svPa8QdYE1KkQ7HWULNg@mail.gmail.com>
References: <20150911064256.GA12899@gmail.com> <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com>
 <20150911124704.GB12899@gmail.com> <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
 <20150911132422.GC12899@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33336 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbIKNpS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 09:45:18 -0400
Received: by lamp12 with SMTP id p12so47468567lam.0
        for <ceph-devel@vger.kernel.org>; Fri, 11 Sep 2015 06:45:17 -0700 (PDT)
In-Reply-To: <20150911132422.GC12899@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Sage Weil <sweil@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Sep 11, 2015 at 4:24 PM, Mykola Golub <mgolub@mirantis.com> wrote:
> On Fri, Sep 11, 2015 at 05:59:56AM -0700, Sage Weil wrote:
>
>> I wonder if, in addition, we should also allow scrub and deep-scrub
>> intervals to be set on a per-pool basis?
>
> ceph osd pool set <pool> [deep-]scrub_interval N ?

BTW it would be absolutely lovely to see a copy-aware scrubs, e.g.
parallel (deep-) scrubs on a non-intersecting set of PGs. Currently as
far as I can see if the scrub starts, the max_scrubs is in effect only
for a primary OSD, allowing situations when two scrubs, primary and
non-primary, can land on a same OSD.
