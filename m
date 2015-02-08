From: David McBride <dwm37@cam.ac.uk>
Subject: Bounding OSD memory requirements during peering/recovery
Date: Sun, 08 Feb 2015 16:05:13 +0000
Message-ID: <54D78939.4000708@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:34928 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390AbbBHQEy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Feb 2015 11:04:54 -0500
Received: from cpc17-cmbg14-2-0-cust484.5-4.cable.virginm.net ([86.6.155.229]:55009 helo=[192.168.8.2])
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1.2:DHE-RSA-AES128-SHA:128)
	id 1YKULs-0005yy-ru (Exim 4.82_3-c0e5623) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Sun, 08 Feb 2015 16:04:52 +0000
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I'm trying to understand the memory requirements for a Ceph node,
particularly when it is undergoing recovery.

Comments, suggestions, pointers are all welcome.

(This is my second attempt at sending this email; it appeared to get=20
eaten the first time =E2=80=94 probably because it had a 1MB .heap file=
 attached.)


Background:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I've got a fairly tortured prototype Ceph cluster.  It was left
unattended for several months, as I'd been needed to work elsewhere =E2=
=80=94
but now I'm returning to it, with an eye to continue to building
production services on it if I have sufficient confidence in its
capabilities.

In the intervening time, several root filesystems on cluster nodes went
full (because of poorly configured logging, as well as MONs being
co-located with OSDs for expediency) and several drives were also
unceremoniously pulled out for reuse elsewhere.

A subsequent recovery is proving problematic: if all OSDs are started
concurrently, they are substantially exceeding the amount of RAM
available on the hosts during peering, and are being killed off by the
kernel OOM killer.

(And then subsequently being restarted by Upstart, resulting in
thrashing for a while, up until something unknown goes awry and the
machine stops sending telemetry and no-longer responds to SSH.  That's =
a=20
separate problem.)

Looking at tcmalloc-accounted heap statistics, I've seen individual OSD=
s
using 9GB+ of RAM; looking at RSS sizes of individual machines, I've
seen process-images exceeding 16GB.  On 12-disk machines with 32GB of
RAM each, this is problematic.

So, I've started looking at the data-structures and algorithms that
govern OSD recovery.  I've found the following references:

  http://ceph.com/docs/master/dev/placement-group/
  http://ceph.com/docs/master/dev/peering/
  http://ceph.com/docs/master/rados/operations/monitoring-osd-pg/
  http://ceph.com/docs/master/dev/osd_internals/map_message_handling/
  http://dachary.org/?p=3D2061

=E2=80=A6 and hope to develop an understanding of an upper bound on mem=
ory
utilization that an efficient implementation of the algorithms describe=
d
would require.

I've also been trying to collect memory profiles for OSD processes as
they're operating, to compare theory with reality.


Memory profiling:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46or example, having found an OSD using ~6GB of memory, I turned on he=
ap
profiling, and dumped its state using `ceph tell osd.N heap
start_profiler; ceph tell osd.N heap dump`:

> ------------------------------------------------
> MALLOC:     6167528240 ( 5881.8 MiB) Bytes in use by application
> MALLOC: +     18309120 (   17.5 MiB) Bytes in page heap freelist
> MALLOC: +     39689152 (   37.9 MiB) Bytes in central cache freelist
> MALLOC: +      4750960 (    4.5 MiB) Bytes in transfer cache freelist
> MALLOC: +     25223840 (   24.1 MiB) Bytes in thread cache freelists
> MALLOC: +     27603096 (   26.3 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D   6283104408 ( 5992.0 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +      2080768 (    2.0 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   6285185176 ( 5994.0 MiB) Virtual address space used
> MALLOC:
> MALLOC:         374907              Spans in use
> MALLOC:            335              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

However, the heap dumps so generated only appear to show memory
allocations (made? touched?) since heap profiling was enabled:

> google-pprof --text /usr/bin/ceph-osd osd.25.profile.0001.heap
> Using local file /usr/bin/ceph-osd.
> Using local file osd.25.profile.0001.heap.
> Total: 0.0 MB
>      0.0  46.7%  46.7%      0.0  59.0% SimpleMessenger::add_accept_pi=
pe
> [...]

Note the "Total: 0.0MB", which differs wildly from the stats reported b=
y=20
tcmalloc, and the RSS of the process reported by the kernel.

So, for testing purposes, I selectively started up ~20% of the OSDs,
each invoked with the setting

   CEPH_HEAP_PROFILER_INIT=3D1

=E2=80=A6 defined in their environmentment to cause the heap profiler t=
o be
started at OSD start-time.  This has a significant CPU and memory
overhead.

Also set were the cluster flags:

   noout,nobackfill,norecover,noscrub,nodeep-scrub

=E2=80=A6 to avoid commingling memory requirements due to peering with =
other
factors.

I've produced a number of .heap files which show >=3D 1000MB of memory
allocated in an RB tree as a result of
PG::RecoveryState::RecoveryMachine::send_notify, PG::read_info and
MOSDPGNotify::decode_payload (or descendants).

An example heapfile from a fairly typical OSD can currently be fetched =
from:

   http://people.ds.cam.ac.uk/dwm37/tmp/osd.0.profile.0124.heap

This was produced by the binaries from the Ceph 'trusty' repository;=20
`ceph -v` returns:

> ceph version 0.92 (00a3ac3b67d93860e7f0b6e07319f11b14d0fec0)

Running pprof in interactive mode and running `top30 --cum` on this=20
heapfile reports:

> Total: 2172.3 MB
>   1705.9  78.5%  78.5%   1748.4  80.5% __gnu_cxx::new_allocator::cons=
truct (inline)
>      0.0   0.0%  78.5%   1600.7  73.7% std::_Rb_tree::_M_create_node =
(inline)
>      0.0   0.0%  78.5%   1367.9  63.0% start_thread
>      0.0   0.0%  78.5%   1367.6  63.0% ioperm
>      0.0   0.0%  78.5%    963.4  44.4% ThreadPool::worker
>      0.0   0.0%  78.5%    963.3  44.3% ThreadPool::WorkThread::entry
>      0.0   0.0%  78.5%    951.0  43.8% OSD::process_peering_events
>      0.0   0.0%  78.5%    950.9  43.8% OSD::PeeringWQ::_process
>      0.0   0.0%  78.5%    949.8  43.7% PG::RecoveryState::handle_even=
t (inline)
>      0.0   0.0%  78.5%    949.8  43.7% boost::statechart::detail::sen=
d_function::operator (inline)
>      0.0   0.0%  78.5%    949.8  43.7% boost::statechart::simple_stat=
e::react_impl
>      0.0   0.0%  78.5%    949.8  43.7% boost::statechart::state_machi=
ne::process_event (inline)
>      0.0   0.0%  78.5%    949.8  43.7% boost::statechart::state_machi=
ne::send_event
>      0.0   0.0%  78.5%    949.8  43.7% local_react (inline)
>      0.0   0.0%  78.5%    949.8  43.7% local_react_impl (inline)
>      0.0   0.0%  78.5%    949.8  43.7% operator (inline)
>      0.0   0.0%  78.5%    949.8  43.7% react (inline)
>      0.0   0.0%  78.5%    948.5  43.7% std::vector::push_back (inline=
)
>      0.0   0.0%  78.5%    948.3  43.7% PG::RecoveryState::RecoveryMac=
hine::send_notify
>      0.0   0.0%  78.5%    947.1  43.6% std::vector::_M_insert_aux
>      0.0   0.0%  78.5%    947.0  43.6% _Rb_tree (inline)
>      0.0   0.0%  78.5%    947.0  43.6% map (inline)
>      0.0   0.0%  78.5%    947.0  43.6% std::_Rb_tree::_M_clone_node (=
inline)
>      0.0   0.0%  78.5%    947.0  43.6% std::_Rb_tree::_M_copy
>      0.0   0.0%  78.5%    809.8  37.3% construct (inline)
>      0.0   0.0%  78.5%    808.4  37.2% std::pair::pair
>      0.0   0.0%  78.5%    804.2  37.0% __libc_start_main
>      0.0   0.0%  78.5%    804.2  37.0% _start
>      0.0   0.0%  78.5%    804.2  37.0% main
>      0.0   0.0%  78.5%    803.6  37.0% OSD::init

This appears to show a large amount of memory =E2=80=94 nearly a gigaby=
te =E2=80=94=20
allocated by boost::statechart, which is slightly surprising as the FAQ=
=20
for boost::statechart quotes a ~1KB memory footprint per state-machine:

=20
http://www.boost.org/doc/libs/1_35_0/libs/statechart/doc/faq.html#Embed=
dedApplications

Perhaps something unexpected is happening here?  I'm almost hoping that=
=20
perhaps statechart is perhaps being subtly misused or misconfigured in=20
some way that, if fixed, would result in a significant drop in memory=20
utilization=E2=80=A6!


Quantifying problem-size:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Given that it appears to be the log-merging stage of PG recovery that
seems to be expensive, I queried the statistics of those PGs which
seemed to be taking a long time to peer, via `ceph pg <pgid> query`.

These showed that (at least a handful) of those PG's recovery_state
past_intervals list contained on the order of ~200-300 entries.

(I have no feel as to whether this is excessive.)


Unused memory:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

One thing I note is that I still sometimes see OSDs with large fraction=
s=20
of their memory allocation sitting on the tcmalloc freelist, e.g.:

> osd.0 tcmalloc heap stats:-------------------------------------------=
-----
> MALLOC:     2226810584 ( 2123.7 MiB) Bytes in use by application
> MALLOC: +   1421361152 ( 1355.5 MiB) Bytes in page heap freelist
> MALLOC: +     41864920 (   39.9 MiB) Bytes in central cache freelist
> MALLOC: +      5215680 (    5.0 MiB) Bytes in transfer cache freelist
> MALLOC: +     18508944 (   17.7 MiB) Bytes in thread cache freelists
> MALLOC: +     16216216 (   15.5 MiB) Bytes in malloc metadata
> MALLOC:   ------------
> MALLOC: =3D   3729977496 ( 3557.2 MiB) Actual memory used (physical +=
 swap)
> MALLOC: +     32792576 (   31.3 MiB) Bytes released to OS (aka unmapp=
ed)
> MALLOC:   ------------
> MALLOC: =3D   3762770072 ( 3588.5 MiB) Virtual address space used
> MALLOC:
> MALLOC:         144565              Spans in use
> MALLOC:            225              Thread heaps in use
> MALLOC:           8192              Tcmalloc page size
> ------------------------------------------------

This is despite having:

   TCMALLOC_RELEASE_RATE=3D10

=E2=80=A6 set in the environment of each OSD process.  This doesn't hel=
p with
contention for RAM between processes!

(I have mentioned this before, though hadn't at that time yet tried=20
running OSDs with TCMALLOC_RELEASE_RATE. See also:

   http://www.spinics.net/lists/ceph-devel/msg18769.html

=E2=80=A6 for history.

Note for anyone intending to reproduce this experiment: Upstart=20
overrides should be written to a file named=20
/etc/init/ceph-{osd,mon}.override, not ceph-{osd,mon}.conf.override as =
I=20
incorrectly specified previously.)


Leak detection:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Not yet being familiar with the the data-structures or algorithms that
govern PG recovery, it's not clear to me whether this is memory usage
that is expected or not for a 120-OSD cluster with 2048 PGs =E2=80=94 o=
r
whether there might be some variety of leak (or inefficient memory-use
pattern.)

It doesn't help that I'm not a C++ hacker. :-)

Reading around the subject, I came across `leaksanitiser`, a clang/LLVM=
:
facility:

  https://code.google.com/p/address-sanitizer/wiki/LeakSanitizer

=E2=80=A6 as well as ticket #9756, which suggests using Clang's other s=
tatic
analysis capabilities to help flag potentially problematic code:

  http://tracker.ceph.com/issues/9756

I might spend some time this weekend to see if I can help advance that
ticket.

(I note that http://ceph.com/gitbuilders.cgi now returns 404; perhaps
that has been superceded by some RedHat-internal facility?)

Cheers,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
