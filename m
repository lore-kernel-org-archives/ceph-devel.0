From: Sage Weil <sage@newdream.net>
Subject: Re: Adding Data-At-Rest compression support to Ceph
Date: Wed, 23 Sep 2015 07:37:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509230734350.11876@cobra.newdream.net>
References: <56018A05.6090100@mirantis.com> <alpine.DEB.2.00.1509221201570.11876@cobra.newdream.net> <56029F66.3070503@mirantis.com> <alpine.DEB.2.00.1509230613410.11876@cobra.newdream.net> <5602B269.1090806@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41808 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbbIWOhO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 10:37:14 -0400
In-Reply-To: <5602B269.1090806@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 23 Sep 2015, Igor Fedotov wrote:
> Sage,
> 
> so you are saying that radosgw tend to use EC pools directly without caching,
> right?
> 
> I agree that we need offset mapping anyway.
> 
> And the difference between cache writes and direct writes is mainly in block
> size granularity: 8 Mb vs. 4 Kb. In the latter case we have higher overhead
> for both offset mapping and compression. But I agree - no real difference from
> implementation point of view.
> OK, let's try to handle both use cases.
> 
> So what do you think - can proceed with this feature implementation or we need
> more discussion on that?

I think we should consider other options before moving forward.

Greg mentions doing this in the fs layer or even devicemapper.  That's 
attractive because it requires no work on our end.

Another option is to do this in the ObjectStore implementation.  It would 
be horribly inefficient to do in all cases, but we could provide a hint 
that all writes to an object will be appends.  This is something that 
NewStore, for example, coule probably do without too much trouble.

sage


> 
> Thanks,
> Igor.
> 
> On 23.09.2015 16:15, Sage Weil wrote:
> > On Wed, 23 Sep 2015, Igor Fedotov wrote:
> > > Hi Sage,
> > > thanks a lot for your feedback.
> > > 
> > > Regarding issues with offset mapping and stripe size exposure.
> > > What's about the idea to apply compression in two-tier (cache+backing
> > > storage)
> > > model only ?
> > I'm not sure we win anything by making it a two-tier only thing... simply
> > making it a feature of the EC pool means we can also address EC pool users
> > like radosgw.
> > 
> > > I doubt single-tier one is widely used for EC pools since there is no
> > > random
> > > write support in such mode. Thus this might be an acceptable limitation.
> > > At the same time it seems that appends caused by cached object flush have
> > > fixed block size (8Mb by default). And object is totally rewritten on the
> > > next
> > > flush if any. This makes offset mapping less tricky.
> > > Decompression should be applied in any model though as cache tier shutdown
> > > and
> > > subsequent compressed data access is possibly  a valid use case.
> > Yeah, we need to handle random reads either way, so I think the offset
> > mapping is going to be needed anyway.  And I don't think there is any
> > real difference from teh EC pool's perspective between a direct user
> > like radosgw and the cache tier writing objects--in both cases it's
> > doing appends and deletes.
> > 
> > sage
> > 
> > 
> > > Thanks,
> > > Igor
> > > 
> > > On 22.09.2015 22:11, Sage Weil wrote:
> > > > On Tue, 22 Sep 2015, Igor Fedotov wrote:
> > > > > Hi guys,
> > > > > 
> > > > > I can find some talks about adding compression support to Ceph. Let me
> > > > > share
> > > > > some thoughts and proposals on that too.
> > > > > 
> > > > > First of all I?d like to consider several major implementation options
> > > > > separately. IMHO this makes sense since they have different
> > > > > applicability,
> > > > > value and implementation specifics. Besides that less parts are easier
> > > > > for
> > > > > both understanding and implementation.
> > > > > 
> > > > >     * Data-At-Rest Compression. This is about compressing basic data
> > > > > volume
> > > > > kept
> > > > > by the Ceph backing tier. The main reason for that is data store costs
> > > > > reduction. One can find similar approach introduced by Erasure Coding
> > > > > Pool
> > > > > implementation - cluster capacity increases (i.e. storage cost
> > > > > reduces) at
> > > > > the
> > > > > expense of additional computations. This is especially effective when
> > > > > combined
> > > > > with the high-performance cache tier.
> > > > >     *  Intermediate Data Compression. This case is about applying
> > > > > compression
> > > > > for intermediate data like system journals, caches etc. The intention
> > > > > is
> > > > > to
> > > > > improve expensive storage resource  utilization (e.g. solid state
> > > > > drives
> > > > > or
> > > > > RAM ). At the same time the idea to apply compression ( feature that
> > > > > undoubtedly introduces additional overhead ) to the crucial heavy-duty
> > > > > components probably looks contradictory.
> > > > >     *  Exchange Data ?ompression. This one to be applied to messages
> > > > > transported
> > > > > between client and storage cluster components as well as internal
> > > > > cluster
> > > > > traffic. The rationale for that might be the desire to improve cluster
> > > > > run-time characteristics, e.g. limited data bandwidth caused by the
> > > > > network or
> > > > > storage devices throughput. The potential drawback is client
> > > > > overburdening
> > > > > -
> > > > > client computation resources might become a bottleneck since they take
> > > > > most of
> > > > > compression/decompression tasks.
> > > > > 
> > > > > Obviously it would be great to have support for all the above cases,
> > > > > e.g.
> > > > > object compression takes place at the client and cluster components
> > > > > handle
> > > > > that naturally during the object life-cycle. Unfortunately significant
> > > > > complexities arise on this way. Most of them are related to partial
> > > > > object
> > > > > access, both reading and writing. It looks like huge development (
> > > > > redesigning, refactoring and new code development ) and testing
> > > > > efforts
> > > > > are
> > > > > required on this way. It?s hard to estimate the value of such
> > > > > aggregated
> > > > > support at the current moment too.
> > > > > Thus the approach I?m suggesting is to drive the progress eventually
> > > > > and
> > > > > consider cases separately. At the moment my proposal is to add
> > > > > Data-At-Rest
> > > > > compression to Erasure Coded pools as the most definite one from both
> > > > > implementation and value points of view.
> > > > > 
> > > > > How we can do that.
> > > > > 
> > > > > Ceph Cluster Architecture suggests two-tier storage model for
> > > > > production
> > > > > usage. Cache tier built on high-performance expensive storage devices
> > > > > provides
> > > > > performance. Storage tier with low-cost less-efficient devices
> > > > > provides
> > > > > cost-effectiveness and capacity. Cache tier is supposed to use
> > > > > ordinary
> > > > > data
> > > > > replication while storage one can use erasure coding (EC) for
> > > > > effective
> > > > > and
> > > > > reliable data keeping. EC provides less store costs with the same
> > > > > reliability
> > > > > comparing to data replication approach at the expenses of additional
> > > > > computations. Thus Ceph already has some trade off between capacity
> > > > > and
> > > > > computation efforts. Actually Data-At-Rest compression is exactly
> > > > > about
> > > > > the
> > > > > same. Moreover one can tie EC and Data-At-Rest compression together to
> > > > > achieve
> > > > > even better storage effectiveness.
> > > > > There are two possible ways on adding Data-At-Rest compression:
> > > > >     *  Use data compression built into a file system beyond the Ceph.
> > > > >     *  Add compression to Ceph OSD.
> > > > > 
> > > > > At first glance Option 1. looks pretty attractive but there are some
> > > > > drawbacks
> > > > > for this approach. Here they are:
> > > > >     *  File System lock-in. BTRFS is the only file system supporting
> > > > > transparent
> > > > > compression among ones recommended for Ceph usage.
> > > > > Moreover
> > > > > AFAIK it?s still not recommended for production usage, see:
> > > > > http://ceph.com/docs/master/rados/configuration/filesystem-recommendations/
> > > > >      *  Limited flexibility - one can use compression methods and
> > > > > policies
> > > > > supported by FS only.
> > > > >      *  Data compression depends on volume or mount point properties
> > > > > (and
> > > > > is
> > > > > bound to OSD). Without additional support Ceph lacks the ability to
> > > > > have
> > > > > different compression policies for different pools residing at the
> > > > > same
> > > > > OSD.
> > > > >      *  File Compression Control isn?t standardized among file
> > > > > systems. If
> > > > > (or
> > > > > when) new compression-equipped File System appears Ceph might require
> > > > > corresponding changes to handle that properly.
> > > > > 
> > > > > Having compression at OSD helps to eliminate these drawbacks.
> > > > > As mentioned above Data-At-Rest compression purposes are pretty the
> > > > > same
> > > > > as
> > > > > for Erasure Coding. It looks quite easy to add compression support to
> > > > > EC
> > > > > pools. This way one can have even more storage space for higher CPU
> > > > > load.
> > > > > Additional Pros for combining compression and erasure coding are:
> > > > >     *  Both EC and compression have complexities in partial writing.
> > > > > EC
> > > > > pools
> > > > > don?t have partial write support (data append only) and the solution
> > > > > for
> > > > > that
> > > > > is cache tier insertion.  Thus we can transparently reuse the same
> > > > > approach in
> > > > > case of compression.
> > > > >     *  Compression becomes a pool property thus Ceph users will have
> > > > > direct
> > > > > control what pools to apply compression with.
> > > > >     *  Original write performance isn?t impacted by the compression
> > > > > for
> > > > > two-tier
> > > > > model - write data goes to the cache uncompressed and there is no
> > > > > corresponding compression latency. Actual compression happens in
> > > > > background
> > > > > when backing storage filling takes place.
> > > > >     *  There is an additional benefit in network bandwidth saving when
> > > > > primary
> > > > > OSD performs a compression as resulting object shards for replication
> > > > > are
> > > > > less.
> > > > >     *  Data-at-rest compression can also bring an additional
> > > > > performance
> > > > > improvement for HDD-based storage. Reducing the amount of data written
> > > > > to
> > > > > slow
> > > > > media can provide a net performance improvement even taking into
> > > > > account
> > > > > the
> > > > > compression overhead.
> > > > I think this approach makes a lot of sense.  The tricky bit will be
> > > > storing the additional metadata that maps logical offsets to compressed
> > > > offsets.
> > > > 
> > > > > Some implementation notes:
> > > > > 
> > > > > The suggested approach is to perform data compression prior to Erasure
> > > > > Coding
> > > > > to reduce data portion passed to coding and avoid the need to
> > > > > introduce
> > > > > additional means to disable EC-generated chunks compression.
> > > > At first glance, the compress-before-ec approach sounds attractive: the
> > > > complex EC striping stuff doesn't need to change, and we just need to
> > > > map
> > > > logical offsets to compressed offsets before doing the EC
> > > > read/reconstruct
> > > > as we normally would.  The problem is with appends: the EC stripe size
> > > > is exposed to the user and they write in those increments.  So if we
> > > > compress before we pass it to EC, then we need to have variable stripe
> > > > sizes for each write (depending on how well it compressed).  The upshot
> > > > here is that if we end up support variable EC stripe sizes we *could*
> > > > allow librados appends of any size (not just the stripe size as we
> > > > currently do).  I'm not sure how important/useful that is...
> > > > 
> > > > On the other hand, ec-before-compression still means we need to map
> > > > coded
> > > > stripe offsets to compressed offsets.. and you're right that it puts a
> > > > bit
> > > > more data through the EC transform.
> > > > 
> > > > Either way, it will be a reasonably complex change.
> > > > 
> > > > > Data-At-Rest compression should support plugin architecture to enable
> > > > > multiple
> > > > > compression backends.
> > > > Haomai has started some simple compression infrastructure to support
> > > > compression over the wire; see
> > > > 
> > > > 	https://github.com/ceph/ceph/pull/5116
> > > > 
> > > > We should reuse or extend the plugin interface there to cover both
> > > > users.
> > > > 
> > > > > Compression engine should mark stored objects with some tags to
> > > > > indicate
> > > > > if
> > > > > compression took place and what algorithm was used.
> > > > > To avoid (reduce) backing storage CPU overload caused by
> > > > > compression/decompression ( e.g. this can happen during massive reads
> > > > > ) we
> > > > > can
> > > > > introduce additional means to detect such situations and temporary
> > > > > disable
> > > > > compression for current write requests. Since there is way to mark
> > > > > objects
> > > > > as
> > > > > compressed/uncompressed this produces almost no issues for future
> > > > > handling.
> > > > > Hardware compression support usage, e.g. Intel QuickAssist can be an
> > > > > additional helper for this issue.
> > > > Great to see this moving forward!
> > > > sage
> > > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
