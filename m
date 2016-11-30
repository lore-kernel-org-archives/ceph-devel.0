From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Ceph PG Number
Date: Wed, 30 Nov 2016 09:31:05 +0100
Message-ID: <20161130083105.GM26997@predictor>
References: <CAOmt5rK42=8DcdrkeHgqsY6o2NjaQ+5wWOeZToZNsPd0GtS2ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:50121 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754165AbcK3I3F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 03:29:05 -0500
Content-Disposition: inline
In-Reply-To: <CAOmt5rK42=8DcdrkeHgqsY6o2NjaQ+5wWOeZToZNsPd0GtS2ew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhen Cao <juehuiconst@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Nov 30, 2016 at 04:22:10PM +0800, Zhen Cao wrote:
> Hi,
> I am reading the RADOS paper,but i could not understand why more PGs
> per OSD result in a more balanced distribution.I konw the mapping
> procedure between oid and osd，but it is neverless difficult to
> understand for me.
> Thanks for your help!

In a nuthshell - because each PG corresponds to multiple objects.
And because of this, it is possible that some PGs will aggregate more
objects than other PGs, resulting in lack of acutal balance. Also see here:
http://docs.ceph.com/docs/jewel/rados/operations/placement-groups/ 

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
