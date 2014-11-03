From: Sage Weil <sage@newdream.net>
Subject: RE: cache tiering sessions at CDS
Date: Mon, 3 Nov 2014 06:11:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411030606210.7489@cobra.newdream.net>
References: <alpine.DEB.2.00.1410311327280.31314@cobra.newdream.net> <CABOLqNLsOhzbg0HkRHyWfAUPVY6XMKz8yXNb_P9cCCo0zJo51w@mail.gmail.com> <51FC7A40FB29414D88A121A7FFEF9A4710FA35EA@SHSMSX104.ccr.corp.intel.com> <A9F57F2ABA6BB2469F01E127557C6C9B110F414B@SHSMSX104.ccr.corp.intel.com>
 <06E7D85B3BA36C4DB207FEDE871C53489516C0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-867079707-1415023909=:7489"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42951 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbaKCOLu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 09:11:50 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489516C0@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "Duan, Jiangang" <jiangang.duan@intel.com>, "Zhang, Jian" <jian.zhang@intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-867079707-1415023909=:7489
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Nov 2014, Wang, Zhiqiang wrote:
> Sage,
>=20
> Thank you for summarize this. I still have some questions and want to=20
> clarify with you.
>=20
> For the wip-promote-forward, you said that it can't guarantee ordering.=
=20
> Does this problem exists in the proxy and promote approach? If not, how=
=20
> does the cache tier osd preserve the ordering? According to my=20
> understanding, a simple scenario can be like this: a read comes in, the=
=20
> cache tier osd proxies it. The pg lock is unlocked after sending the=20
> proxy request to base tier. A subsequent read request of the same objec=
t=20
> comes in. Somehow the cache tier osd just finishes the promotion for=20
> this object. And the 2nd read request is served at the cache tier. It=20
> may respond to the client first than the 1st read request.

That is one scenario, although it is one we could solve by requeuing all=20
in-progress proxy reads in the cache tier when promote completes.  The=20
problem I was alluding to is with redirects, where we reply to the client=
=20
and say "go look over there".  Then you can get

 - read 1 arrives at cache osd; redirect sent to client
 - osd initiates promote
 - promote completes
 - read 2 arrives at cache osd, replies
 - read 1 arrives at base osd, replies
 - client gets read 2 ack, then read 1 ack

or something similar.

I think the best answers to all of this is to not guarantee that reads=20
will complete in order (only do that for writes).  We'll need to take a=20
careful look at current uesrs to make sure it is safe to relax that,=20
though, and probably make it possible to request that reads *are* ordered=
=20
(similar to how we can request a particular read is ordered with respect=20
to writes via the RWORDERED flag).

But in any case, with proxying, it's still possible to maintain the=20
ordering with a bit of effort.

> If you don't already have someone working on this, definitely we can=20
> help on this. We can come back with the detail implementation later.

That would be great!  Nobody is working on this yet.  I started the=20
wip-promote-forward branch, but I think I didn't use the best approach=20
because we should be divorcing the promote from the triggering request(s)=
=20
entirely.

But it probably makes more sense to first implement that read=20
proxying as that is a prerequisite and useful on its own...

sage

 >=20
> -----Original Message-----
> From: Sage Weil <sage@inktank.com>
> Date: 2014-11-01 5:01 GMT+08:00
> Subject: cache tiering sessions at CDS
> To: ceph-devel@vger.kernel.org
>=20
>=20
> There were a pair of CDS sessions Wednesday on cache tiering that promp=
ted a great discussion about the current performance problems we're seein=
g and ways to address them.=C2=A0 It was a long discussion but I'll do my=
 best to summarize.=C2=A0 Please chime in if I miss anything or if you di=
sagree with my conclusions!
>=20
> The first session was about fine-grained promotion.=C2=A0 I.e., promoti=
ng or storing only portions of an object in the cache.=C2=A0 Currently an=
 object always exists in its entirely in the cache tier, but the latency =
from promotion can be expensive if the original write is small.
>=20
> Sam and I generally agreed that there are advantages to doing this, but=
 that the implementation will be quite complex.=C2=A0 There are also seve=
ral simpler improvements that can be made that address many (most?) of th=
e problematic workload patterns and are significantly simpler.
>=20
> -- Reads --
>=20
> Currently we either forward a read (decline to promote) or block a read=
 while we promote.=C2=A0 Doing more declining (e.g. promote on 2nd read) =
is shown to help, but we should be able to do a lot better.
>=20
> The first step is wip-promote-forward, or something similar, which forw=
ards the read *and* initiates a promote.=C2=A0 The the original IO isn't =
delayed, only subsequent reads that arrive shortly after.
>=20
> Second, even those subsequent reads need not wait for a promote: we can=
 safely forward them too while promotion is in progress without breaking =
consistency from the client's perspective, as long as we preserve the ord=
er of reads and writes for each client.
>=20
> 9979 osd: cache: proxy reads (instead of redirect)
> 9980 osd: cache: proxy reads during promote
>=20
> Note: I belive there is some ordering problems with *redirecting* reads=
 and then stopping (e.g., redirect, start promote, finish promote, read f=
rom cache ... the second read reply could reach the client before the fir=
st).=C2=A0 We may need to proxy in general?=C2=A0 :/
>=20
> Anyway, proxying reads during promotion effectively makes the promotion=
 asynchronous and transparent to the read workload, modulo the extra IO t=
hat the cache and base tiers will do (competition for network and disk IO=
).=C2=A0 I believe this will mitigate most of the impact on reads.
>=20
> More importantly, it is least as good as the more complicated proposal =
of satisfying the read from the intermediate promotion result before it i=
s written into the cache tier.=C2=A0 In particular, I think the *only* ti=
me using the intermediate promote result is better is when the read falls=
 entirely within the current in-flight copy-get operation (in flight to t=
he base tier, or in the process of being written to the cache but still i=
n memory).=C2=A0 Any other time (unaligned read, read arrives before prom=
ote
> starts) it's better to proxy it.
>=20
> Also, note that it is mainly small reads that we care about.=C2=A0 We e=
xpect large reads to be less frequent and, when they happen, to be genera=
lly okay with sending those to the base tier anyway.
>=20
> -> Stategies that hide promotion cost are probably more useful than
> strategies that promote less (or partial) object data.
>=20
> -- Writes --
>=20
> The situation for writes is a bit more complex.=C2=A0 First, if we add =
the ability to proxy writes to the backend, we give ourselves the ability=
 to decide if/when to promote (currently we unconditionally promote on wr=
ite).
> This would allow a 'promote on 2nd write' type of behavior (similar to =
what we did for read).
>=20
> We talked about the possibility of combining the small write into the p=
romotion's write of the full object into the cache.=C2=A0 Since these are=
 currently pipelined, it is not clear that this will improve things very =
much.=C2=A0 Promoting only object metadata and writing a partial bit of d=
ata into the cache tier is the big win, but it's complex, and we should d=
o all the simple things (like write proxying) first.
>=20
> Finally, we talked about making a write-full on an object skip the data=
 portion of the promote.=C2=A0 This is only moderately complex and seems =
doable.
> However, it would be helpful to know how frequent write_full is in real=
 workloads first.=C2=A0 Also, a write_full is arguably the type of operat=
ion where we might decline to promote at all, and simply proxy the write =
back to the base tier.
>=20
> I think in the short term, the next step should be:
>=20
> 9981 osd: cache: proxy writes (instead of unconditionally promoting)
>=20
> -- read-only cache --
>=20
> Finally, we brought up the idea of a read-only cache tier:
>=20
> =C2=A0- reads would promote (or not) just as they do now
> =C2=A0- writes would invalidate (delete object from cache) and then for=
ward/proxy
>=20
> h/t to Dan Lambright for that suggestion.=C2=A0 Note that we already ha=
ve a readonly cache mode; the delta here is how we handle the writes.
>=20
> 9982 osd: cache: make writes in readonly mode invalidate and then forwa=
rd
>=20
>=20
> There was a lot of discussion here so if you're interested you way want=
 to check the pads or watch the videos.
>=20
> http://pad.ceph.com/p/hammer-osd_tiering_promotion_unit
> http://pad.ceph.com/p/hammer-osd_tiering_latencies_cache_tier_miss
> http://youtu.be/7p8ZkOIJjUA
> http://youtu.be/AGDOnJFffrc
>=20
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n the body of a message to majordomo@vger.kernel.org More majordomo info =
at=C2=A0 http://vger.kernel.org/majordomo-info.html
>=20
> N?????r??y??????X???v???)?{.n?????z?]z????ay?=1D????j=07??f???h?????=1E=
?w???=0C???j:+v???w????????=07????zZ+???????j"????i
--557981400-867079707-1415023909=:7489--
