From: Sage Weil <sweil@redhat.com>
Subject: Re: mon switch from leveldb to rocksdb
Date: Tue, 3 May 2016 13:17:18 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605031314160.26967@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1605021444320.26967@cpach.fuggernut.com> <5727A3DC.7070102@symas.com> <bee8107b-0d3e-3ebc-d029-ed27e0165137@redhat.com> <CAJ4mKGbsJBk_8N8tkmqhYOipXXQC-LdiV=XOZ8S22HCCXh8_OA@mail.gmail.com>
 <ffb1914f-0321-c5d7-bab6-4c5fb0f67441@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-133383375-1462295841=:26967"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756343AbcECRRK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 3 May 2016 13:17:10 -0400
In-Reply-To: <ffb1914f-0321-c5d7-bab6-4c5fb0f67441@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Howard Chu <hyc@symas.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-133383375-1462295841=:26967
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 3 May 2016, Mark Nelson wrote:
> On 05/03/2016 11:41 AM, Gregory Farnum wrote:
> > On Tue, May 3, 2016 at 6:34 AM, Mark Nelson <mnelson@redhat.com> wrote:
> > > On 05/02/2016 02:00 PM, Howard Chu wrote:
> > > > 
> > > > Sage Weil wrote:
> > > > > 
> > > > > 1) Thoughts on moving to rocksdb in general?
> > > > 
> > > > 
> > > > Are you actually prepared to undertake all of the measurement and tuning
> > > > required to make RocksDB actually work well? You're switching from an
> > > > (abandoned/unsupported) engine with only a handful of config parameters
> > > > to one with ~40-50 params, all of which have critical but unpredictable
> > > > impact on resource consumption and performance.
> > > > 
> > > 
> > > You are absolutely correct, and there are definitely pitfalls we need to
> > > watch out for with the number of tunables in rocksdb.  At least on the
> > > performance side two of the big issues we've hit with leveldb compaction
> > > related.  In some scenarios compaction happens slower than the number of
> > > writes coming in resulting in ever-growing db sizes.  The other issue is
> > > that compaction is single threaded and this can cause stalls and general
> > > mayhem when things get really heavily loaded.  My hope is that if we do go
> > > with rocksdb, even in a sub-optimally tuned state, we'll be better off
> > > than
> > > we were with leveldb.
> > > 
> > > We did some very preliminary benchmarks a couple of years ago (admittedly
> > > a
> > > too-small dataset size) basically comparing the (at the time) stock ceph
> > > leveldb settings vs rocksdb.  On this set size, leveldb looked much better
> > > for reads, but much worse for writes.
> > 
> > That's actually a bit troubling — many of our monitor problems have
> > arisen from slow reads, rather than slow writes. I suspect we want to
> > eliminate this before switching, if it's a concern.
> > 
> > ...Although I think I did see a monitor caching layer go by, so maybe
> > it's a moot point now?
> 
> Yeah, I suspect that's helping significantly.  I think based at least one what
> I remember seeing I'm more concerned about high latency events than average
> read performance though.  IE if there is a compaction storm, which store is
> going to handle it more gracefully with less spikey behavior?

I'm most worried about the read storm that happens on each commit to fetch 
all the just-updated PG stat keys.  The other data in the mon is just 
noise in comparison, I think, with the exception of the OSDMaps... which 
IIRC is what the cache you mention was for.

The initial PR,

	https://github.com/ceph/ceph/pull/8888

just makes the backend choice persistent.  Rocksdb is still experimental.  
There's an accompanying ceph-qa-suite pr so that we test both.  Once we 
do some performance evaluation we can decide whether the switch is safe 
as-is, if more work (caching layer or tuning) is needed, or if it's a bad 
idea.

> In those leveldb tests we only saw writes and write trims hit by those
> periodic 10-60 second high-latency spikes, but if I recall the mon has (or at
> least had?) a global lock where write stalls would basically make the whole
> monitor stall.  I think Joao might have improved that after we did this
> testing but I don't remember the details at this point.

I don't think any of this locking has changed...

sage

--8323329-133383375-1462295841=:26967--
