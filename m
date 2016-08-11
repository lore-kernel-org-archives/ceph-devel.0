From: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: cephfs performance benchmark -- metadata intensive
Date: Thu, 11 Aug 2016 11:07:10 +0100
Message-ID: <CALe9h7fqrOCGn564HLPyMS6ouOHaY0phuZ64OHnq0Vx8VJWoug@mail.gmail.com>
References: <CAEYCsVKksnVV+HeNBo4YofPz4Re1CRT3jCTCE2L12NqieMVYWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAEYCsVKksnVV+HeNBo4YofPz4Re1CRT3jCTCE2L12NqieMVYWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, james.liu-gPhfCIXyaqCqndwCJWfcng@public.gmane.org, "Chen, Xiaoxi" <xiaoxchen-ZuctOmHWJ9c@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Aug 11, 2016 at 8:29 AM, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi ,
>
>
>      Here is the slide I shared yesterday on performance meeting.
> Thanks and hoping for inputs.
>
>
> http://www.slideshare.net/XiaoxiChen3/cephfs-jewel-mds-performance-benchmark

These are definitely useful results and I encourage everyone working
with cephfs to go and look at Xiaoxi's slides.

The main thing that this highlighted for me was our lack of testing so
far on systems with full caches.  Too much of our existing testing is
done on freshly configured systems that never fill the MDS cache.

Test 2.1 notes that we don't enable directory fragmentation by default
currently -- this is an issue, and I'm hoping we can switch it on by
default in Kraken (see thread "Switching on mds_bal_frag by default").
In the meantime we have the fix that Patrick wrote for Jewel which at
least prevents people creating dirfrags too large for the OSDs to
handle.

Test 2.2: since a "failing to respond to cache pressure" bug is
affecting this, I would guess we see the performance fall off at about
the point where the *client* caches fill up (so they start trimming
things even though they're ignore cache pressure).  It would be
interesting to see this chart with addition lines for some related
perf counters like mds_log.evtrm and mds.inodes_expired, that might
make it pretty obvious where the MDS is entering different stages that
see a decrease in the rate of handling client requests.

We really need to sort out the "failing to respond to cache pressure"
issues that keep popping up, especially if they're still happening on
a comparatively simple test that is just creating files.  We have a
specific test for this[1] that is currently being run against the fuse
client but not the kernel client[2].  This is a good time to try and
push that forward so I've kicked off an experimental run here:
http://pulpito.ceph.com/jspray-2016-08-10_16:14:52-kcephfs:recovery-master-testing-basic-mira/

In the meantime, although there are reports of similar issues with
newer kernels, it would be very useful to confirm if the same issue is
still occurring with more recent kernels.  Issues with cache trimming
have occurred due to various (separate) bugs, so it's possible that
while some people are still seeing cache trimming issues with recent
kernels, the specific case you're hitting might be fixed.

Test 2.3: restarting the MDS doesn't actually give you a completely
empty cache (everything in the journal gets replayed to pre-populate
the cache on MDS startup).  However, the results are still valid
because you're using a different random order in the non-caching test
case, and the number of inodes in your journal is probably much
smaller than the overall cache size so it's only a little bit
populated.  We don't currently have a "drop cache" command built into
the MDS but it would be pretty easy to add one for use in testing
(basically just call mds->mdcache->trim(0)).

As one would imagine, the non-caching case is latency-dominated when
the working set is larger than the cache, where each client is waiting
for one open to finish before proceeding to the next.  The MDS is
probably capable of handling many more operations per second, but it
would need more parallel IO operations from the clients.  When a
single client is doing opens one by one, you're potentially seeing a
full network+disk latency for each one (though in practice the OSD
read cache will be helping a lot here).  This non-caching case would
be the main argument for giving the metadata pool low latency (SSD)
storage.

Test 2.5: The observation that the CPU bottleneck makes using fast
storage for the metadata pool less useful (in sequential/cached cases)
is valid, although it could still be useful to isolate the metadata
OSDs (probably SSDs since not so much capacity is needed) to avoid
competing with data operations.  For random access in the non-caching
cases (2.3, 2.4) I think you would probably see an improvement from
SSDs.

Thanks again to the team from ebay for sharing all this.

John



1. https://github.com/ceph/ceph-qa-suite/blob/master/tasks/cephfs/test_client_limits.py#L96
2. http://tracker.ceph.com/issues/9466


>
> Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
