From: Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Subject: Increasing pg_num
Date: Mon, 16 May 2016 15:56:48 +1000
Message-ID: <20160516055648.GA10765@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

I'm trying to understand the potential impact on an active cluster of
increasing pg_num/pgp_num.

The conventional wisdom, as gleaned from the mailing lists and general
google fu, seems to be to increase pg_num followed by pgp_num, both in
small increments, to the target size, using "osd max backfills" (and
perhaps "osd recovery max active"?) to control the rate and thus
performance impact of data movement.

I'd really like to understand what's going on rather than "cargo culting"
it.

I'm currently on Hammer, but I'm hoping the answers are broadly applicable
across all versions for others following the trail.

Why do we have both pg_num and pgp_num? Given the docs say "The pgp_num
should be equal to the pg_num": under what circumstances might you want
these different, apart from when actively increasing pg_num first then
increasing pgp_num to match? (If they're supposed to be always the same, why
not have a single parameter and do the "increase pg_num, then pgp_num"
within ceph's internals?)

What do "osd backfill scan min" and "osd backfill scan max" actually
control? The docs say "The minimum/maximum number of objects per backfill
scan" but what does this actually mean and how does it affect the impact (if
at all)?

Is "osd recovery max active" actually relevant to this situation? It's
mentioned in various places related to increasing pg_num/pgp_num but my
understanding is it's related to recovery (e.g. osd falls out and comes
back again and needs to catch up) rather than back filling (migrating
pgs misplaced due to increasing pg_num, crush map changes etc.)

Previously (back in Dumpling days):

----
http://article.gmane.org/gmane.comp.file-systems.ceph.user/11490
----
From: Gregory Farnum
Subject: Re: Throttle pool pg_num/pgp_num increase impact
Newsgroups: gmane.comp.file-systems.ceph.user
Date: 2014-07-08 17:01:30 GMT

On Tuesday, July 8, 2014, Kostis Fardelas wrote:
> Should we be worried that the pg/pgp num increase on the bigger pool will
> have a 300X larger impact?

The impact won't be 300 times bigger, but it will be bigger. There are two
things impacting your cluster here

1) the initial "split" of the affected PGs into multiple child PGs. You can
mitigate this by stepping through pg_num at small multiples.
2) the movement of data to its new location (when you adjust pgp_num). This
can be adjusted by setting the "OSD max backfills" and related parameters;
check the docs.
-Greg
----

Am I correct thinking "small multiples" in this context is along the lines
of "1.1" rather than "2" or "4"?.

Is there really much impact when increasing pg_num in a single large step
e.g. 1024 to 4096? If so, what causes this impact? An initial trial of
increasing pg_num by 10% (1024 to 1126) on one of my pools showed it
completed in a matter of tens of seconds, too short to really measure any
performance impact. But I'm concerned this could be exponential to the size
of the step such that increasing by a large step (e.g. the rest of the way
from 1126 to 4096) could cause problems.

Given the use of "osd max backfills" to limit the impact of the data
movement associated with increasing pgp_num, is there any advantage or
disadvantage to increasing pgp_num in small increments (e.g. 10% at a time)
vs "all at once", apart from small increments likely moving some data
multiple times? E.g. with a large step is there a higher potential for
problems if something else happens to the cluster the same time (e.g. an OSD
dies) because the current state of the system is further from the expected
state, or something like that?

If small increments of pgp_num are advisable, should the process be
"increase pg_num by a small increment, increase pgp_num to match, repeat
until target reached", or is that no advantage to increasing pg_num (in
multiple small increments or single large step) to the target, then
increasing pgp_num in small increments to the target - and why?

Given that increasing pg_num/pgp_num seem almost inevitable for a growing
cluster, and that increasing these can be one of the most
performance-impacting operations you can perform on a cluster, perhaps a
document going into these details would be appropriate?

Cheers,

Chris
