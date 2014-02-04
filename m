From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: poor data distribution
Date: Mon, 3 Feb 2014 16:33:10 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402031619540.10983@cobra.newdream.net>
References: <CAMNMNTw2u9r-Uab7+Fa1y0Wem53f9hvx77yxjTwB+tgTfnPF2A@mail.gmail.com>
	<CAMNMNTxfw=T+-D-=qXeO65hQzuAsuVhJU1fuLGFECDcCow0isg@mail.gmail.com>
	<alpine.DEB.2.00.1401300842550.22642@cobra.newdream.net>
	<CAMNMNTyh6RN4xRg-tAZzu19EDaEPbau+b-Q+XxGWZq8nN1B9vQ@mail.gmail.com>
	<alpine.DEB.2.00.1401300908040.24840@cobra.newdream.net>
	<CAMNMNTwCRydaWffc6q5n+ruvKu_xYP_FFh+SBR96VXzRUun2fw@mail.gmail.com>
	<CAFMfnwoB5+x7RqwoKmz8Pc9PWxnsiiTUtPCa7wp2sSQtefxT-g@mail.gmail.com>
	<CAMNMNTz4XiwF0H_SfhBiTswj4GNFnrRFX0fdQhCcdArg0Pd0=w@mail.gmail.com>
	<CAMNMNTwQ9uPXfFkpo3VFkiVjzxgY6-Sgq9+mK=dY3X63rsV_YA@mail.gmail.com>
	<alpine.DEB.2.00.1402012219070.17892@cobra.newdream.net>
	<CAMNMNTxMS-dErrtHzrd0hch1wjHKfc7USJJ5hFueac7+f6_tLQ@mail.gmail.com>
	<CAMNMNTzjn=AzbLr-ZRVKMSFYMC_ibyGjSHcuwpB-C4WBWDN16w@mail.gmail.com>
	<CAMNMNTx7k1J4a7oCNMXq0b1Pp1RAS_xCco9Mw4tAZj9k0PS1gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTx7k1J4a7oCNMXq0b1Pp1RAS_xCco9Mw4tAZj9k0PS1gA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I spent a couple hours looking at your map because it did look like there 
was something wrong.  After some experimentation and adding a bucnh of 
improvements to osdmaptool to test the distribution, though, I think 
everything is working as expected.  For pool 3, your map has a standard 
deviation in utilizations of ~8%, and we should expect ~9% for this number 
of PGs.  For all pools, it is slightly higher (~9% vs expected ~8%).  
This is either just in the noise, or slightly confounded by the lack of 
the hashpspool flag on the pools (which slightly amplifies placement 
nonuniformity with multiple pools... not enough that it is worth changing 
anything though).

The bad news is that that order of standard deviation results in pretty 
wide min/max range of 118 to 202 pgs.  That seems a *bit* higher than we a 
perfectly random placement generates (I'm seeing a spread in that is 
usually 50-70 pgs), but I think *that* is where the pool overlap (no 
hashpspool) is rearing its head; for just pool three the spread of 50 is 
about what is expected.

Long story short: you have two options.  One is increasing the number of 
PGs.  Note that this helps but has diminishing returns (doubling PGs 
only takes you from ~8% to ~6% standard deviation, quadrupling to ~4%).

The other is to use reweight-by-utilization.  That is the best approach, 
IMO.  I'm not sure why you were seeing PGs stuck in the remapped state 
after you did that, though, but I'm happy to dig into that too.

BTW, the osdmaptool addition I was using to play with is here:
	https://github.com/ceph/ceph/pull/1178

sage


On Mon, 3 Feb 2014, Dominik Mostowiec wrote:

> In other words,
> 1. we've got 3 racks ( 1 replica per rack )
> 2. in every rack we have 3 hosts
> 3. every host has 22 OSD's
> 4. all pg_num's are 2^n for every pool
> 5. we enabled "crush tunables optimal".
> 6. on every machine we disabled 4 unused disk's (osd out, osd reweight
> 0 and osd rm)
> 
> Pool ".rgw.buckets": one osd has 105 PGs and other one (on the same
> machine) has 144 PGs (37% more!).
> Other pools also have got this problem. It's not efficient placement.
> 
> --
> Regards
> Dominik
> 
> 
> 2014-02-02 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > Hi,
> > For more info:
> >   crush: http://dysk.onet.pl/link/r4wGK
> >   osd_dump: http://dysk.onet.pl/link/I3YMZ
> >   pg_dump: http://dysk.onet.pl/link/4jkqM
> >
> > --
> > Regards
> > Dominik
> >
> > 2014-02-02 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >> Hi,
> >> Hmm,
> >> You think about sumarize PGs from different pools on one OSD's i think.
> >> But for one pool (.rgw.buckets) where i have almost of all my data, PG
> >> count on OSDs is aslo different.
> >> For example 105 vs 144 PGs from pool .rgw.buckets. In first case it is
> >> 52% disk usage, second 74%.
> >>
> >> --
> >> Regards
> >> Dominik
> >>
> >>
> >> 2014-02-02 Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>:
> >>> It occurs to me that this (and other unexplain variance reports) could
> >>> easily be the 'hashpspool' flag not being set.  The old behavior had the
> >>> misfeature where consecutive pool's pg's would 'line up' on the same osds,
> >>> so that 1.7 == 2.6 == 3.5 == 4.4 etc would map to the same nodes.  This
> >>> tends to 'amplify' any variance in the placement.  The default is still to
> >>> use the old behavior for compatibility (this will finally change in
> >>> firefly).
> >>>
> >>> You can do
> >>>
> >>>  ceph osd pool set <poolname> hashpspool true
> >>>
> >>> to enable the new placement logic on an existing pool, but be warned that
> >>> this will rebalance *all* of the data in the pool, which can be a very
> >>> heavyweight operation...
> >>>
> >>> sage
> >>>
> >>>
> >>> On Sun, 2 Feb 2014, Dominik Mostowiec wrote:
> >>>
> >>>> Hi,
> >>>> After scrubbing almost all PGs has equal(~) num of objects.
> >>>> I found something else.
> >>>> On one host PG coun on OSDs:
> >>>> OSD with small(52%) disk usage:
> >>>> count, pool
> >>>>     105 3
> >>>>      18 4
> >>>>       3 5
> >>>>
> >>>> Osd with larger(74%) disk usage:
> >>>>     144 3
> >>>>      31 4
> >>>>       2 5
> >>>>
> >>>> Pool 3 is .rgw.buckets (where is almost of all data).
> >>>> Pool 4 is .log, where is no data.
> >>>>
> >>>> Count of PGs shouldn't be the same per OSD ?
> >>>> Or maybe PG hash algorithm is disrupted by wrong count of PG for pool
> >>>> '4'. There is 1440 PGs ( this is not power of 2 ).
> >>>>
> >>>> ceph osd dump:
> >>>> pool 0 'data' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 64 pgp_num 64 last_change 28459 owner 0
> >>>> crash_replay_interval 45
> >>>> pool 1 'metadata' rep size 3 min_size 1 crush_ruleset 1 object_hash
> >>>> rjenkins pg_num 64 pgp_num 64 last_change 28460 owner 0
> >>>> pool 2 'rbd' rep size 3 min_size 1 crush_ruleset 2 object_hash
> >>>> rjenkins pg_num 64 pgp_num 64 last_change 28461 owner 0
> >>>> pool 3 '.rgw.buckets' rep size 3 min_size 1 crush_ruleset 0
> >>>> object_hash rjenkins pg_num 8192 pgp_num 8192 last_change 73711 owner
> >>>> 0
> >>>> pool 4 '.log' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 1440 pgp_num 1440 last_change 28463 owner 0
> >>>> pool 5 '.rgw' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 128 pgp_num 128 last_change 72467 owner 0
> >>>> pool 6 '.users.uid' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 28465 owner 0
> >>>> pool 7 '.users' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 28466 owner 0
> >>>> pool 8 '.usage' rep size 2 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 28467 owner
> >>>> 18446744073709551615
> >>>> pool 9 '.intent-log' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 28468 owner
> >>>> 18446744073709551615
> >>>> pool 10 '.rgw.control' rep size 3 min_size 1 crush_ruleset 0
> >>>> object_hash rjenkins pg_num 8 pgp_num 8 last_change 33485 owner
> >>>> 18446744073709551615
> >>>> pool 11 '.rgw.gc' rep size 3 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 33487 owner
> >>>> 18446744073709551615
> >>>> pool 12 '.rgw.root' rep size 2 min_size 1 crush_ruleset 0 object_hash
> >>>> rjenkins pg_num 8 pgp_num 8 last_change 44540 owner 0
> >>>> pool 13 '' rep size 2 min_size 1 crush_ruleset 0 object_hash rjenkins
> >>>> pg_num 8 pgp_num 8 last_change 46912 owner 0
> >>>>
> >>>> --
> >>>> Regards
> >>>> Dominik
> >>>>
> >>>> 2014-02-01 Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>> > Hi,
> >>>> >> Did you bump pgp_num as well?
> >>>> > Yes.
> >>>> >
> >>>> > See: http://dysk.onet.pl/link/BZ968
> >>>> >
> >>>> >> 25% pools is two times smaller from other.
> >>>> > This is changing after scrubbing.
> >>>> >
> >>>> > --
> >>>> > Regards
> >>>> > Dominik
> >>>> >
> >>>> > 2014-02-01 Kyle Bader <kyle.bader-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>> >>
> >>>> >>> Change pg_num for .rgw.buckets to power of 2, an 'crush tunables
> >>>> >>> optimal' didn't help :(
> >>>> >>
> >>>> >> Did you bump pgp_num as well? The split pgs will stay in place until pgp_num
> >>>> >> is bumped as well, if you do this be prepared for (potentially lots) of data
> >>>> >> movement.
> >>>> >
> >>>> >
> >>>> >
> >>>> > --
> >>>> > Pozdrawiam
> >>>> > Dominik
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Pozdrawiam
> >>>> Dominik
> >>>>
> >>>>
> >>
> >>
> >>
> >> --
> >> Pozdrawiam
> >> Dominik
> >
> >
> >
> > --
> > Pozdrawiam
> > Dominik
> 
> 
> 
> -- 
> Pozdrawiam
> Dominik
> 
> 
