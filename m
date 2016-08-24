From: Sage Weil <sweil@redhat.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Wed, 24 Aug 2016 16:09:54 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608241607360.25681@piezo.us.to>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to> <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com> <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753474AbcHXQJ6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 12:09:58 -0400
In-Reply-To: <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 24 Aug 2016, Haomai Wang wrote:
> On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote:
> > On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
> >> This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
> >> this _info omap key is rewritten on *every* IO.
> >>
> >> We could shrink this down significant with varint and/or delta encoding
> >> since a huge portion of it is just a bunch of uint64_t counters.  This
> >> will probably cost some CPU time, but OTOH it'll also shrink our metadata
> >> down a fair bit too which will pay off later.
> >>
> >> Anybody want to tackle this?
> >
> > what about separating "object_stat_collection_t stats" from pg_stat_t?
> > pg info should be unchanged for most of times, we could only update
> > object related stats. This may help to reduce half bytes.

I don't think this will work, since every op changes last_update in 
pg_info_t *and* the stats (write op count, total bytes, objects, etc.).
 
> Or we only store increment values and keep the full in memory(may
> reduce to 20-30bytes). In period time we store the full structure(only
> hundreds of bytes)....

A delta is probably very compressible (only a few fields in the stats 
struct change).  The question is how fast can we make it in CPU time.  
Probably a simple delta (which will be almost all 0's) and a trivial 
run-length-encoding scheme that just gets rid of the 0's would do well 
enough...

sage
