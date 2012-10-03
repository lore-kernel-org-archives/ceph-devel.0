From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Wed, 03 Oct 2012 10:55:11 -0400
Message-ID: <201210031455.q93EtBki025151@ayesha.phys.virginia.edu>
References: <CAPYLRzh8UggCDRfiMv2fzQ4=h2cdm9P1FejMpAntfRrq6nY_GQ@mail.gmail.com>
Reply-To: bryan@Virginia.EDU
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:38596 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367Ab2JCOzM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 10:55:12 -0400
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id q93EtBki025151
	for <ceph-devel@vger.kernel.org>; Wed, 3 Oct 2012 10:55:11 -0400
In-reply-to: Your message of "Mon, 01 Oct 2012 10:00:15 PDT."
             <CAPYLRzh8UggCDRfiMv2fzQ4=h2cdm9P1FejMpAntfRrq6nY_GQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again,

	A few answers to questions from various people on the list
after my last e-mail:

greg@inktank.com said:
> Yes. Bryan, you mentioned that you didn't see a lot of resource usage=
 =97 was it
> perhaps flatlined at (100 * 1 / num_cpus)? The MDS is multi-threaded =
in
> theory, but in practice it has the equivalent of a Big Kernel Lock so=
 it's not
> going to get much past one cpu core of time...=20

	The CPU usage on the MDSs hovered around a few percent.
They're quad-core machines, and I didn't see it ever get as high
as 25% usage on any of the cores while watching with atop.

greg@inktank.com said:
> The rados bench results do indicate some pretty bad small-file write
> performance as well though, so I guess it's possible your testing is =
running
> long enough that the page cache isn't absorbing that hit. Did perform=
ance
> start out higher or has it been flat?=20

	Looking at the details of the rados benchmark output, it does=20
look like performance starts out better for the first few iterations,
and then goes bad.  Here's the begining of a typical small-file run:

 Maintaining 256 concurrent writes of 4096 bytes for at least 900 secon=
ds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1     255      3683      3428   13.3894   13.3906  0.002569 0.0696=
906
     2     256      7561      7305   14.2661   15.1445  0.106437 0.0669=
534
     3     256     10408     10152   13.2173   11.1211  0.002176 0.0689=
543
     4     256     11256     11000    10.741    3.3125  0.002097 0.0846=
414
     5     256     11256     11000    8.5928         0         - 0.0846=
414
     6     256     11370     11114   7.23489  0.222656  0.002399 0.0962=
989
     7     255     12480     12225   6.82126   4.33984  0.117658  0.142=
335
     8     256     13289     13033   6.36311   3.15625  0.002574  0.151=
261
     9     256     13737     13481   5.85051      1.75  0.120657  0.158=
865
    10     256     14341     14085   5.50138   2.35938  0.022544  0.178=
298

I see the same behavior every time I repeat the small-file=20
rados benchmark.  Here's a graph showing the first 100 "cur MB/s" value=
s
for a short-file benchmark:

http://ayesha.phys.virginia.edu/~bryan/rados-bench-t256-b4096-run1-0928=
2012-curmbps.pdf

	On the other hand, with 4MB files, I see results that start out like=20
this:

 Maintaining 256 concurrent writes of 4194304 bytes for at least 900 se=
conds.
   sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   avg =
lat
     0       0         0         0         0         0         -       =
  0
     1      49        49         0         0         0         -       =
  0
     2      76        76         0         0         0         -       =
  0
     3     105       105         0         0         0         -       =
  0
     4     133       133         0         0         0         -       =
  0
     5     159       159         0         0         0         -       =
  0
     6     188       188         0         0         0         -       =
  0
     7     218       218         0         0         0         -       =
  0
     8     246       246         0         0         0         -       =
  0
     9     256       274        18   7.99904         8   8.97759   8.66=
218
    10     255       301        46   18.3978       112    9.1456   8.94=
095
    11     255       330        75   27.2695       116   9.06968     9.=
013
    12     255       358       103   34.3292       112   9.12486   9.04=
374

Here's a graph showing the first 100 "cur MB/s" values for a typical
4MB file benchmark:

http://ayesha.phys.virginia.edu/~bryan/rados-bench-t256-b4MB-run1-09282=
012-curmbps.pdf

mark.nelson@inktank.com said:
> When you were doing this, what kind of results did collectl give you =
for
> average write sizes to the underlying OSD disks?=20

	The average "rwsize" reported by collectl hovered around=20
6 +/- a few (in whatever units collectl reports) for the RAID
array, and around 15 for the journal SSD, while doing the small-file
rados benchmark.  Here's a screenshot showing atop running on
each of the MDS hosts, and collectl running on each of the OSD
hosts, while the benchmark was running:

http://ayesha.phys.virginia.edu/~bryan/collectl-atop-t256-b4096.png

Here's the same, but with collectl running on the MDSs instead of atop:

http://ayesha.phys.virginia.edu/~bryan/collectl-collectl-t256-b4096.png

Looking at the last screenshot again, it does look like the disks on
the MDSs are getting some exercise, with ~40% utilization (if I'm
interpreting the collectl output correctly).

Here's a similar snapshot for the 4MB test:

http://ayesha.phys.virginia.edu/~bryan/collectl-collectl-t256-b4MB.png

It looks like similar "pct util" on the MDS disks, but much higher
average rwsize values on the OSDs.

mark.nelson@inktank.com said:
> There's multiple issues potentially here.  Part of it might be how  w=
rites are
> coalesced by XFS in each scenario.  Part of it might also be  overhea=
d due to
> XFS metadata reads/writes.  You could probably get a  better idea of =
both of
> these by running blktrace during the tests and  making seekwatcher mo=
vies of
> the results.  You not only can look at the  numbers of seeks, but als=
o the
> kind (read/writes) and where on the disk  they are going.  That, and =
some of
> the raw blktrace data can give you a  lot of information about what i=
s going
> on and whether or not seeks are =20

	I'll take a look at blktrace and see what I can find out.

mark.nelson@inktank.com said:
> Beyond that, I do think you are correct in suspecting that there are =
 some
> Ceph limitations as well.  Some things that may be interesting to try=
:

> - 1 OSD per Disk - Multiple OSDs on the RAID array. - Increasing vari=
ous
> thread counts - Increasing various op and byte limits (such as
> journal_max_write_entries and journal_max_write_bytes). - EXT4 or BTR=
=46S under
> the OSDs.=20

	And I'll give some of these a try.

	Regarding the iozone benchmarks:
mark.nelson@inktank.com said:
> Do you happen to have the settings you used when you ran these tests?=
  I
> probably don't have time to try to repeat them now, but I can at leas=
t  take a
> quick look at them.=20
> I'm slightly confused by the labels on the graph.  They can't possibl=
y  mean
> that 2^16384 KB record sizes were tested.  Was that just up to 16MB  =
records
> and 16GB files?  That would make a lot more sense.=20

I just did something like:

	cd /mnt/tmp (where the cephfs was mounted)
	iozone -a > /tmp/iozone.log

By default, iozone does its tests in the current working directory.
The graphs were just produced with the Generate_Graphs script
that comes with iozone.  There are certainly some problems with
the axis labeling, but I think your interpretation is correct.

mark.nelson@inktank.com said:
> This might be a dumb question, but was the ceph version of this test =
on  a
> single client on gigabit Ethernet?  If so, wouldn't that be the reaso=
n  you
> are maxing out at like 114MB/s?=20

	Duh.  You're exactly right.  I should have noticed this.

	And finally:
tv@inktank.com said:
> If you want to benchmark just the metadata part, rsync with 0-size fi=
les might
> actually be an interesting workload.=20

	I'll see if I can work out a way to do this.

			Thanks to everyone for the suggestions.
			Bryan
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bryan Wright              |"If you take cranberries and stew them like=20
Physics Department        | applesauce, they taste much more like prune=
s
University of Virginia    | than rhubarb does."  --  Groucho=20
Charlottesville, VA  22901|		=09
(434) 924-7218            |         bryan@virginia.edu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
