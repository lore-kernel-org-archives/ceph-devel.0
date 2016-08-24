From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: pg_stat_t is 500+ bytes
Date: Wed, 24 Aug 2016 18:20:31 +0200
Message-ID: <20160824162031.GA26181@predictor>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
 <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
 <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
 <alpine.DEB.2.11.1608241607360.25681@piezo.us.to>
 <e20c13f4-ae6f-e06a-ac1b-c5736737e642@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:52940 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbcHXQaM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 12:30:12 -0400
Content-Disposition: inline
In-Reply-To: <e20c13f4-ae6f-e06a-ac1b-c5736737e642@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 11:12:24AM -0500, Mark Nelson wrote:
> 
> 
> On 08/24/2016 11:09 AM, Sage Weil wrote:
> >On Wed, 24 Aug 2016, Haomai Wang wrote:
> >>On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote:
> >>>On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
> >>>>This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
> >>>>this _info omap key is rewritten on *every* IO.
> >>>>
> >>>>We could shrink this down significant with varint and/or delta encoding
> >>>>since a huge portion of it is just a bunch of uint64_t counters.  This
> >>>>will probably cost some CPU time, but OTOH it'll also shrink our metadata
> >>>>down a fair bit too which will pay off later.
> >>>>
> >>>>Anybody want to tackle this?
> >>>
> >>>what about separating "object_stat_collection_t stats" from pg_stat_t?
> >>>pg info should be unchanged for most of times, we could only update
> >>>object related stats. This may help to reduce half bytes.
> >
> >I don't think this will work, since every op changes last_update in
> >pg_info_t *and* the stats (write op count, total bytes, objects, etc.).
> >
> >>Or we only store increment values and keep the full in memory(may
> >>reduce to 20-30bytes). In period time we store the full structure(only
> >>hundreds of bytes)....
> >
> >A delta is probably very compressible (only a few fields in the stats
> >struct change).  The question is how fast can we make it in CPU time.
> >Probably a simple delta (which will be almost all 0's) and a trivial
> >run-length-encoding scheme that just gets rid of the 0's would do well
> >enough...
> 
> Do we have any rough idea of how many/often consecutive 0s we end up
> with in the current encoding?

Or how high these counters get? We could try transposing the matrix made of
those counters. At least the two most significant bytes in most of those
counters are mostly zeros, and after transposing, simple RLE would be
feasible. In any case, I'm not sure if *all* of these fields need to be
uint64_t.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
