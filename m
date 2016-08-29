From: Sage Weil <sage@newdream.net>
Subject: RE: pg_stat_t is 500+ bytes
Date: Mon, 29 Aug 2016 13:28:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608291323510.24244@piezo.us.to>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to> <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com> <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com> <alpine.DEB.2.11.1608241607360.25681@piezo.us.to>
 <e20c13f4-ae6f-e06a-ac1b-c5736737e642@redhat.com> <20160824162031.GA26181@predictor> <CACJqLyagS94AefE3vj6pEb5F7J74XTn5zLT+Sm65hHvzSXfqwg@mail.gmail.com> <CACJqLyY3H5cQ9=s6uwUtJrGNygWg-ChifuSCNtbJ+0819dhkzw@mail.gmail.com>
 <BL2PR02MB2115A0503FC241BBF5281E04F4EF0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-43200704-1472477330=:24244"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46555 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbcH2N2v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 09:28:51 -0400
In-Reply-To: <BL2PR02MB2115A0503FC241BBF5281E04F4EF0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Haomai Wang <haomai@xsky.com>, =?ISO-8859-2?Q?Piotr_Da=B3ek?= <branch@predictor.org.pl>, Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-43200704-1472477330=:24244
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 27 Aug 2016, Somnath Roy wrote:
> Sage/Sam,
> I was going through the pg_info_t structures and it seems the following 
> fields are duplicates among the different inner structures.
> 
> eversion_t last_scrub;                                ->   duplicate within  pg_stat_t, pg_history_t
> eversion_t last_deep_scrub;                    -> duplicate within  pg_stat_t, pg_history_t
> utime_t last_scrub_stamp;                        -> duplicate within  pg_stat_t, pg_history_t
> utime_t last_deep_scrub_stamp;           -> duplicate within  pg_stat_t, pg_history_t
> utime_t last_clean_scrub_stamp;            -> duplicate within  pg_stat_t, pg_history_t
> 
> pg_stat_t -> created is duplicate of pg_history_t -> epoch_created ?

Yeah, these look like dups to me..
 
> pg_stat_t->last_became_active is duplicate of pg_stat_t->last_active ?
> pg_stat_t->last_became_peered is duplicate of pg_stat_t->last_peered ?

The semantics of these are slightly different: lact_active,peered is the 
last time pg_stat_t refreshed and the pg was active or peered, while the 
_became_ ones are the last time they transitions to active or peered.  It 
may be we can drop the former since they could be inferred from 
last_fresh and state...

> Following quick optimization we could do as well probably..
> The following fields of object_stat_sum_t  can have value of 0 and 1 , so, why not replaced with structure bit field ?
> 
>   int32_t num_flush_mode_high;  // 1 when in high flush mode, otherwise 0
>   int32_t num_flush_mode_low;   // 1 when in low flush mode, otherwise 0
>   int32_t num_evict_mode_some;  // 1 when in evict some mode, otherwise 0
>   int32_t num_evict_mode_full;  // 1 when in evict full mode, otherwise 0
> 
> Same with the following field of pg_info_t , we can replace with bitfield.

This is done this way so that they structure can be summed over PGs and 
pools.

> bool last_backfill_bitwise

Yeah, this could be swapped for a single flags field and appropriate 
accessors.

sage

> These will replace 93 bytes with 5 bits.
> 
> Am I missing anything ?
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Somnath Roy
> Sent: Thursday, August 25, 2016 6:29 PM
> To: 'Haomai Wang'; Piotr Dałek
> Cc: Mark Nelson; Sage Weil; ceph-devel@vger.kernel.org
> Subject: RE: pg_stat_t is 500+ bytes
> 
> Sage,
> I can see for statistics we are storing 40 bytes for each IO..
> 
> Merge( Prefix = T key = 'bluestore_statfs' Value size = 40)
> 
> Should we really store it on each IO ?
> 
> 1. IMO, gathering/storing stats should be configurable
> 
> 2. If enabled, I think we can have counters maintained in memory and persist that to db between some configurable interval ?
> 
> BTW, as you mentioned, pg_info is huge, 855 bytes.
> 
> Put( Prefix = M key = 0x0000000000000746'._info' Value size = 855)
> 
> 
> Thanks & Regards
> Somnath
> 
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
> Sent: Thursday, August 25, 2016 5:56 AM
> To: Piotr Dałek
> Cc: Mark Nelson; Sage Weil; ceph-devel@vger.kernel.org
> Subject: Re: pg_stat_t is 500+ bytes
> 
> On Thu, Aug 25, 2016 at 8:54 PM, Haomai Wang <haomai@xsky.com> wrote:
> > I think there exists a lot of fields can't be discarded via judging
> > 0s, like utime_t, epoch_t. A simple way is to compare with previous
> > pg_info_t.
> 
> Oh, sorry. We may could use a fresh pg_info_t to indicate. But below also could apply this way.
> 
> >
> > BTW, I want to mentiond pg_info_t encoding occurs 6.05% cpu time in pg
> > thread(thread level not process level).
> >
> > looks we have three optimization from mark and Piotr:
> >
> > 1. reconstruct pg_info_t and make high frequent fields together.
> > 2. change some fields to smaller bits
> > 3. uses SIMD to optimize low frequency fields difference
> > comparison(optional)
> >
> > intel SSE4.2 pcmpistrm instructive could do very good 128bytes
> > comparison, pg_info_t is above 700bytes:
> >
> > inline const char *skip_same_128_bytes_SIMD(const char* p, const char* p2) {
> >     const __m128i w = _mm_load_si128((const __m128i *)p2);
> >
> >     for (;; p += 16) {
> >         const __m128i s = _mm_load_si128((const __m128i *)p);
> >         const unsigned r = _mm_cvtsi128_si32(_mm_cmpistrm(w, s,
> >             _SIDD_UBYTE_OPS | _SIDD_CMP_EQUAL_ANY |
> >             _SIDD_BIT_MASK | _SIDD_NEGATIVE_POLARITY));
> >
> >         if (r != 0) // some of characters isn't equal
> >             return p + __builtin_ffs(r) - 1;
> >     }
> > }
> >
> > On Thu, Aug 25, 2016 at 12:20 AM, Piotr Dałek <branch@predictor.org.pl> wrote:
> >> On Wed, Aug 24, 2016 at 11:12:24AM -0500, Mark Nelson wrote:
> >>>
> >>>
> >>> On 08/24/2016 11:09 AM, Sage Weil wrote:
> >>> >On Wed, 24 Aug 2016, Haomai Wang wrote:
> >>> >>On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote:
> >>> >>>On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
> >>> >>>>This is huge.  It takes the pg_info_t str from 306 bytes to 847
> >>> >>>>bytes, and this _info omap key is rewritten on *every* IO.
> >>> >>>>
> >>> >>>>We could shrink this down significant with varint and/or delta
> >>> >>>>encoding since a huge portion of it is just a bunch of uint64_t
> >>> >>>>counters.  This will probably cost some CPU time, but OTOH it'll
> >>> >>>>also shrink our metadata down a fair bit too which will pay off later.
> >>> >>>>
> >>> >>>>Anybody want to tackle this?
> >>> >>>
> >>> >>>what about separating "object_stat_collection_t stats" from pg_stat_t?
> >>> >>>pg info should be unchanged for most of times, we could only
> >>> >>>update object related stats. This may help to reduce half bytes.
> >>> >
> >>> >I don't think this will work, since every op changes last_update in
> >>> >pg_info_t *and* the stats (write op count, total bytes, objects, etc.).
> >>> >
> >>> >>Or we only store increment values and keep the full in memory(may
> >>> >>reduce to 20-30bytes). In period time we store the full
> >>> >>structure(only hundreds of bytes)....
> >>> >
> >>> >A delta is probably very compressible (only a few fields in the
> >>> >stats struct change).  The question is how fast can we make it in CPU time.
> >>> >Probably a simple delta (which will be almost all 0's) and a
> >>> >trivial run-length-encoding scheme that just gets rid of the 0's
> >>> >would do well enough...
> >>>
> >>> Do we have any rough idea of how many/often consecutive 0s we end up
> >>> with in the current encoding?
> >>
> >> Or how high these counters get? We could try transposing the matrix
> >> made of those counters. At least the two most significant bytes in
> >> most of those counters are mostly zeros, and after transposing,
> >> simple RLE would be feasible. In any case, I'm not sure if *all* of
> >> these fields need to be uint64_t.
> >>
> >> --
> >> Piotr Dałek
> >> branch@predictor.org.pl
> >> http://blog.predictor.org.pl
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-43200704-1472477330=:24244--
