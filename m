From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Wed, 3 Oct 2012 11:35:42 -0700
Message-ID: <CAPYLRzhBrOj0Woum9mv0k_wmDpCJ1qwqMtkgB7wp5f5Anm_tWw@mail.gmail.com>
References: <CAPYLRzh8UggCDRfiMv2fzQ4=h2cdm9P1FejMpAntfRrq6nY_GQ@mail.gmail.com>
	<201210031455.q93EtBki025151@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42337 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab2JCSfn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 14:35:43 -0400
Received: by ieak13 with SMTP id k13so17935876iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 11:35:42 -0700 (PDT)
In-Reply-To: <201210031455.q93EtBki025151@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@virginia.edu
Cc: ceph-devel@vger.kernel.org

I think I'm with Mark now =97 this does indeed look like too much rando=
m
IO for the disks to handle. In particular, Ceph requires that each
write be synced to disk before it's considered complete, which rsync
definitely doesn't. In the filesystem this is generally disguised
fairly well by all the caches and such in the way, but this use case
is unfriendly to that arrangement.

However, I am particularly struck by seeing one of your OSDs at 96%
disk utilization while the others remain <50%, and I've just realized
we never saw output from ceph -s. Can you provide that, please?
-Greg

On Wed, Oct 3, 2012 at 7:55 AM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> Hi again,
>
>         A few answers to questions from various people on the list
> after my last e-mail:
>
> greg@inktank.com said:
>> Yes. Bryan, you mentioned that you didn't see a lot of resource usag=
e =97 was it
>> perhaps flatlined at (100 * 1 / num_cpus)? The MDS is multi-threaded=
 in
>> theory, but in practice it has the equivalent of a Big Kernel Lock s=
o it's not
>> going to get much past one cpu core of time...
>
>         The CPU usage on the MDSs hovered around a few percent.
> They're quad-core machines, and I didn't see it ever get as high
> as 25% usage on any of the cores while watching with atop.
>
> greg@inktank.com said:
>> The rados bench results do indicate some pretty bad small-file write
>> performance as well though, so I guess it's possible your testing is=
 running
>> long enough that the page cache isn't absorbing that hit. Did perfor=
mance
>> start out higher or has it been flat?
>
>         Looking at the details of the rados benchmark output, it does
> look like performance starts out better for the first few iterations,
> and then goes bad.  Here's the begining of a typical small-file run:
>
>  Maintaining 256 concurrent writes of 4096 bytes for at least 900 sec=
onds.
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>      0       0         0         0         0         0         -     =
    0
>      1     255      3683      3428   13.3894   13.3906  0.002569 0.06=
96906
>      2     256      7561      7305   14.2661   15.1445  0.106437 0.06=
69534
>      3     256     10408     10152   13.2173   11.1211  0.002176 0.06=
89543
>      4     256     11256     11000    10.741    3.3125  0.002097 0.08=
46414
>      5     256     11256     11000    8.5928         0         - 0.08=
46414
>      6     256     11370     11114   7.23489  0.222656  0.002399 0.09=
62989
>      7     255     12480     12225   6.82126   4.33984  0.117658  0.1=
42335
>      8     256     13289     13033   6.36311   3.15625  0.002574  0.1=
51261
>      9     256     13737     13481   5.85051      1.75  0.120657  0.1=
58865
>     10     256     14341     14085   5.50138   2.35938  0.022544  0.1=
78298
>
> I see the same behavior every time I repeat the small-file
> rados benchmark.  Here's a graph showing the first 100 "cur MB/s" val=
ues
> for a short-file benchmark:
>
> http://ayesha.phys.virginia.edu/~bryan/rados-bench-t256-b4096-run1-09=
282012-curmbps.pdf
>
>         On the other hand, with 4MB files, I see results that start o=
ut like
> this:
>
>  Maintaining 256 concurrent writes of 4194304 bytes for at least 900 =
seconds.
>    sec Cur ops   started  finished  avg MB/s  cur MB/s  last lat   av=
g lat
>      0       0         0         0         0         0         -     =
    0
>      1      49        49         0         0         0         -     =
    0
>      2      76        76         0         0         0         -     =
    0
>      3     105       105         0         0         0         -     =
    0
>      4     133       133         0         0         0         -     =
    0
>      5     159       159         0         0         0         -     =
    0
>      6     188       188         0         0         0         -     =
    0
>      7     218       218         0         0         0         -     =
    0
>      8     246       246         0         0         0         -     =
    0
>      9     256       274        18   7.99904         8   8.97759   8.=
66218
>     10     255       301        46   18.3978       112    9.1456   8.=
94095
>     11     255       330        75   27.2695       116   9.06968     =
9.013
>     12     255       358       103   34.3292       112   9.12486   9.=
04374
>
> Here's a graph showing the first 100 "cur MB/s" values for a typical
> 4MB file benchmark:
>
> http://ayesha.phys.virginia.edu/~bryan/rados-bench-t256-b4MB-run1-092=
82012-curmbps.pdf
>
> mark.nelson@inktank.com said:
>> When you were doing this, what kind of results did collectl give you=
 for
>> average write sizes to the underlying OSD disks?
>
>         The average "rwsize" reported by collectl hovered around
> 6 +/- a few (in whatever units collectl reports) for the RAID
> array, and around 15 for the journal SSD, while doing the small-file
> rados benchmark.  Here's a screenshot showing atop running on
> each of the MDS hosts, and collectl running on each of the OSD
> hosts, while the benchmark was running:
>
> http://ayesha.phys.virginia.edu/~bryan/collectl-atop-t256-b4096.png
>
> Here's the same, but with collectl running on the MDSs instead of ato=
p:
>
> http://ayesha.phys.virginia.edu/~bryan/collectl-collectl-t256-b4096.p=
ng
>
> Looking at the last screenshot again, it does look like the disks on
> the MDSs are getting some exercise, with ~40% utilization (if I'm
> interpreting the collectl output correctly).
>
> Here's a similar snapshot for the 4MB test:
>
> http://ayesha.phys.virginia.edu/~bryan/collectl-collectl-t256-b4MB.pn=
g
>
> It looks like similar "pct util" on the MDS disks, but much higher
> average rwsize values on the OSDs.
>
> mark.nelson@inktank.com said:
>> There's multiple issues potentially here.  Part of it might be how  =
writes are
>> coalesced by XFS in each scenario.  Part of it might also be  overhe=
ad due to
>> XFS metadata reads/writes.  You could probably get a  better idea of=
 both of
>> these by running blktrace during the tests and  making seekwatcher m=
ovies of
>> the results.  You not only can look at the  numbers of seeks, but al=
so the
>> kind (read/writes) and where on the disk  they are going.  That, and=
 some of
>> the raw blktrace data can give you a  lot of information about what =
is going
>> on and whether or not seeks are
>
>         I'll take a look at blktrace and see what I can find out.
>
> mark.nelson@inktank.com said:
>> Beyond that, I do think you are correct in suspecting that there are=
  some
>> Ceph limitations as well.  Some things that may be interesting to tr=
y:
>
>> - 1 OSD per Disk - Multiple OSDs on the RAID array. - Increasing var=
ious
>> thread counts - Increasing various op and byte limits (such as
>> journal_max_write_entries and journal_max_write_bytes). - EXT4 or BT=
RFS under
>> the OSDs.
>
>         And I'll give some of these a try.
>
>         Regarding the iozone benchmarks:
> mark.nelson@inktank.com said:
>> Do you happen to have the settings you used when you ran these tests=
?  I
>> probably don't have time to try to repeat them now, but I can at lea=
st  take a
>> quick look at them.
>> I'm slightly confused by the labels on the graph.  They can't possib=
ly  mean
>> that 2^16384 KB record sizes were tested.  Was that just up to 16MB =
 records
>> and 16GB files?  That would make a lot more sense.
>
> I just did something like:
>
>         cd /mnt/tmp (where the cephfs was mounted)
>         iozone -a > /tmp/iozone.log
>
> By default, iozone does its tests in the current working directory.
> The graphs were just produced with the Generate_Graphs script
> that comes with iozone.  There are certainly some problems with
> the axis labeling, but I think your interpretation is correct.
>
> mark.nelson@inktank.com said:
>> This might be a dumb question, but was the ceph version of this test=
 on  a
>> single client on gigabit Ethernet?  If so, wouldn't that be the reas=
on  you
>> are maxing out at like 114MB/s?
>
>         Duh.  You're exactly right.  I should have noticed this.
>
>         And finally:
> tv@inktank.com said:
>> If you want to benchmark just the metadata part, rsync with 0-size f=
iles might
>> actually be an interesting workload.
>
>         I'll see if I can work out a way to do this.
>
>                         Thanks to everyone for the suggestions.
>                         Bryan
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Bryan Wright              |"If you take cranberries and stew them lik=
e
> Physics Department        | applesauce, they taste much more like pru=
nes
> University of Virginia    | than rhubarb does."  --  Groucho
> Charlottesville, VA  22901|
> (434) 924-7218            |         bryan@virginia.edu
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
