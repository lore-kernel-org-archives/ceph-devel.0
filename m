From: Brett Niver <bniver-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: cephfs performance benchmark -- metadata intensive
Date: Thu, 11 Aug 2016 08:24:46 -0400
Message-ID: <CAMdDSN3gKZCV0+6nVC7ba_9KqvWQgMrGq1jPxm9EPws4Ls286Q@mail.gmail.com>
References: <CAEYCsVKksnVV+HeNBo4YofPz4Re1CRT3jCTCE2L12NqieMVYWA@mail.gmail.com>
	<CALe9h7fqrOCGn564HLPyMS6ouOHaY0phuZ64OHnq0Vx8VJWoug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1986535236=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7fqrOCGn564HLPyMS6ouOHaY0phuZ64OHnq0Vx8VJWoug-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "Chen, Xiaoxi" <xiaoxchen-ZuctOmHWJ9c@public.gmane.org>, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, james.liu-gPhfCIXyaqCqndwCJWfcng@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1986535236==
Content-Type: multipart/alternative; boundary=001a113ddff207c5870539cada44

--001a113ddff207c5870539cada44
Content-Type: text/plain; charset=UTF-8

Patrick and I had a related question yesterday, are we able to dynamically
vary cache size to artificially manipulate cache pressure?

On Thu, Aug 11, 2016 at 6:07 AM, John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> On Thu, Aug 11, 2016 at 8:29 AM, Xiaoxi Chen <superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi ,
> >
> >
> >      Here is the slide I shared yesterday on performance meeting.
> > Thanks and hoping for inputs.
> >
> >
> > http://www.slideshare.net/XiaoxiChen3/cephfs-jewel-mds-
> performance-benchmark
>
> These are definitely useful results and I encourage everyone working
> with cephfs to go and look at Xiaoxi's slides.
>
> The main thing that this highlighted for me was our lack of testing so
> far on systems with full caches.  Too much of our existing testing is
> done on freshly configured systems that never fill the MDS cache.
>
> Test 2.1 notes that we don't enable directory fragmentation by default
> currently -- this is an issue, and I'm hoping we can switch it on by
> default in Kraken (see thread "Switching on mds_bal_frag by default").
> In the meantime we have the fix that Patrick wrote for Jewel which at
> least prevents people creating dirfrags too large for the OSDs to
> handle.
>
> Test 2.2: since a "failing to respond to cache pressure" bug is
> affecting this, I would guess we see the performance fall off at about
> the point where the *client* caches fill up (so they start trimming
> things even though they're ignore cache pressure).  It would be
> interesting to see this chart with addition lines for some related
> perf counters like mds_log.evtrm and mds.inodes_expired, that might
> make it pretty obvious where the MDS is entering different stages that
> see a decrease in the rate of handling client requests.
>
> We really need to sort out the "failing to respond to cache pressure"
> issues that keep popping up, especially if they're still happening on
> a comparatively simple test that is just creating files.  We have a
> specific test for this[1] that is currently being run against the fuse
> client but not the kernel client[2].  This is a good time to try and
> push that forward so I've kicked off an experimental run here:
> http://pulpito.ceph.com/jspray-2016-08-10_16:14:52-
> kcephfs:recovery-master-testing-basic-mira/
>
> In the meantime, although there are reports of similar issues with
> newer kernels, it would be very useful to confirm if the same issue is
> still occurring with more recent kernels.  Issues with cache trimming
> have occurred due to various (separate) bugs, so it's possible that
> while some people are still seeing cache trimming issues with recent
> kernels, the specific case you're hitting might be fixed.
>
> Test 2.3: restarting the MDS doesn't actually give you a completely
> empty cache (everything in the journal gets replayed to pre-populate
> the cache on MDS startup).  However, the results are still valid
> because you're using a different random order in the non-caching test
> case, and the number of inodes in your journal is probably much
> smaller than the overall cache size so it's only a little bit
> populated.  We don't currently have a "drop cache" command built into
> the MDS but it would be pretty easy to add one for use in testing
> (basically just call mds->mdcache->trim(0)).
>
> As one would imagine, the non-caching case is latency-dominated when
> the working set is larger than the cache, where each client is waiting
> for one open to finish before proceeding to the next.  The MDS is
> probably capable of handling many more operations per second, but it
> would need more parallel IO operations from the clients.  When a
> single client is doing opens one by one, you're potentially seeing a
> full network+disk latency for each one (though in practice the OSD
> read cache will be helping a lot here).  This non-caching case would
> be the main argument for giving the metadata pool low latency (SSD)
> storage.
>
> Test 2.5: The observation that the CPU bottleneck makes using fast
> storage for the metadata pool less useful (in sequential/cached cases)
> is valid, although it could still be useful to isolate the metadata
> OSDs (probably SSDs since not so much capacity is needed) to avoid
> competing with data operations.  For random access in the non-caching
> cases (2.3, 2.4) I think you would probably see an improvement from
> SSDs.
>
> Thanks again to the team from ebay for sharing all this.
>
> John
>
>
>
> 1. https://github.com/ceph/ceph-qa-suite/blob/master/tasks/
> cephfs/test_client_limits.py#L96
> 2. http://tracker.ceph.com/issues/9466
>
>
> >
> > Xiaoxi
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113ddff207c5870539cada44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Patrick and I had a related question yesterday, are we abl=
e to dynamically vary cache size to artificially manipulate cache pressure?=
<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu,=
 Aug 11, 2016 at 6:07 AM, John Spray <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Thu, Aug 11, 2016=
 at 8:29 AM, Xiaoxi Chen &lt;<a href=3D"mailto:superdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">supe=
rdebuger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; Hi ,<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Here is the slide I shared yesterday on performanc=
e meeting.<br>
&gt; Thanks and hoping for inputs.<br>
&gt;<br>
&gt;<br>
&gt; <a href=3D"http://www.slideshare.net/XiaoxiChen3/cephfs-jewel-mds-perf=
ormance-benchmark" rel=3D"noreferrer" target=3D"_blank">http://www.slidesha=
re.net/<wbr>XiaoxiChen3/cephfs-jewel-mds-<wbr>performance-benchmark</a><br>
<br>
</span>These are definitely useful results and I encourage everyone working=
<br>
with cephfs to go and look at Xiaoxi&#39;s slides.<br>
<br>
The main thing that this highlighted for me was our lack of testing so<br>
far on systems with full caches.=C2=A0 Too much of our existing testing is<=
br>
done on freshly configured systems that never fill the MDS cache.<br>
<br>
Test 2.1 notes that we don&#39;t enable directory fragmentation by default<=
br>
currently -- this is an issue, and I&#39;m hoping we can switch it on by<br=
>
default in Kraken (see thread &quot;Switching on mds_bal_frag by default&qu=
ot;).<br>
In the meantime we have the fix that Patrick wrote for Jewel which at<br>
least prevents people creating dirfrags too large for the OSDs to<br>
handle.<br>
<br>
Test 2.2: since a &quot;failing to respond to cache pressure&quot; bug is<b=
r>
affecting this, I would guess we see the performance fall off at about<br>
the point where the *client* caches fill up (so they start trimming<br>
things even though they&#39;re ignore cache pressure).=C2=A0 It would be<br=
>
interesting to see this chart with addition lines for some related<br>
perf counters like mds_log.evtrm and mds.inodes_expired, that might<br>
make it pretty obvious where the MDS is entering different stages that<br>
see a decrease in the rate of handling client requests.<br>
<br>
We really need to sort out the &quot;failing to respond to cache pressure&q=
uot;<br>
issues that keep popping up, especially if they&#39;re still happening on<b=
r>
a comparatively simple test that is just creating files.=C2=A0 We have a<br=
>
specific test for this[1] that is currently being run against the fuse<br>
client but not the kernel client[2].=C2=A0 This is a good time to try and<b=
r>
push that forward so I&#39;ve kicked off an experimental run here:<br>
<a href=3D"http://pulpito.ceph.com/jspray-2016-08-10_16:14:52-kcephfs:recov=
ery-master-testing-basic-mira/" rel=3D"noreferrer" target=3D"_blank">http:/=
/pulpito.ceph.com/<wbr>jspray-2016-08-10_16:14:52-<wbr>kcephfs:recovery-mas=
ter-<wbr>testing-basic-mira/</a><br>
<br>
In the meantime, although there are reports of similar issues with<br>
newer kernels, it would be very useful to confirm if the same issue is<br>
still occurring with more recent kernels.=C2=A0 Issues with cache trimming<=
br>
have occurred due to various (separate) bugs, so it&#39;s possible that<br>
while some people are still seeing cache trimming issues with recent<br>
kernels, the specific case you&#39;re hitting might be fixed.<br>
<br>
Test 2.3: restarting the MDS doesn&#39;t actually give you a completely<br>
empty cache (everything in the journal gets replayed to pre-populate<br>
the cache on MDS startup).=C2=A0 However, the results are still valid<br>
because you&#39;re using a different random order in the non-caching test<b=
r>
case, and the number of inodes in your journal is probably much<br>
smaller than the overall cache size so it&#39;s only a little bit<br>
populated.=C2=A0 We don&#39;t currently have a &quot;drop cache&quot; comma=
nd built into<br>
the MDS but it would be pretty easy to add one for use in testing<br>
(basically just call mds-&gt;mdcache-&gt;trim(0)).<br>
<br>
As one would imagine, the non-caching case is latency-dominated when<br>
the working set is larger than the cache, where each client is waiting<br>
for one open to finish before proceeding to the next.=C2=A0 The MDS is<br>
probably capable of handling many more operations per second, but it<br>
would need more parallel IO operations from the clients.=C2=A0 When a<br>
single client is doing opens one by one, you&#39;re potentially seeing a<br=
>
full network+disk latency for each one (though in practice the OSD<br>
read cache will be helping a lot here).=C2=A0 This non-caching case would<b=
r>
be the main argument for giving the metadata pool low latency (SSD)<br>
storage.<br>
<br>
Test 2.5: The observation that the CPU bottleneck makes using fast<br>
storage for the metadata pool less useful (in sequential/cached cases)<br>
is valid, although it could still be useful to isolate the metadata<br>
OSDs (probably SSDs since not so much capacity is needed) to avoid<br>
competing with data operations.=C2=A0 For random access in the non-caching<=
br>
cases (2.3, 2.4) I think you would probably see an improvement from<br>
SSDs.<br>
<br>
Thanks again to the team from ebay for sharing all this.<br>
<br>
John<br>
<br>
<br>
<br>
1. <a href=3D"https://github.com/ceph/ceph-qa-suite/blob/master/tasks/cephf=
s/test_client_limits.py#L96" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/ceph/ceph-<wbr>qa-suite/blob/master/tasks/<wbr>cephfs/test_client=
_limits.py#<wbr>L96</a><br>
2. <a href=3D"http://tracker.ceph.com/issues/9466" rel=3D"noreferrer" targe=
t=3D"_blank">http://tracker.ceph.com/<wbr>issues/9466</a><br>
<span class=3D""><br>
<br>
&gt;<br>
&gt; Xiaoxi<br>
&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe ceph-de=
vel&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">=
majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
</span>______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</blockquote></div><br></div>

--001a113ddff207c5870539cada44--

--===============1986535236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1986535236==--
