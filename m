From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: OOM's on the Ceph client machine
Date: Wed, 13 Oct 2010 16:43:58 +1300
Message-ID: <AANLkTik0L2ZJn_eaXw30E_g9u5Tfa8sxH2SovU0wZCpZ@mail.gmail.com>
References: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:42955 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321Ab0JMDoF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Oct 2010 23:44:05 -0400
Received: by vws2 with SMTP id 2so1870296vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 12 Oct 2010 20:43:58 -0700 (PDT)
In-Reply-To: <E1P5pFk-0001oE-Mv@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org, mrubin@google.com

Hi Ted:

I'd like to follow your similar setup, too.
At this stage, I'm with the very recent version, I've tried btrfs but
ceph mount freezes as soon as I run any high benchmark or heavy iops.
I think it is to do with syncing, so I'm now trying ext4 without the
journal, hoping for some good news.

1. have you tried btrfs, with all configs the same?
2. did you use mkfs.ext4 -O ^has_journal to disable? (sorry, you know
the most since you are the ext4 man!)
3. did the change of journal size in ceph.conf changed any results?
e.g., 20MB to 1000MB?

Have you had any success in other benchmarks? I'd really like to know
if you could try 'fio' benchmark, if your time allows.
run ./fio example_file

and the example_file content is below, e.g.,

[global]
bs=3D4k
ioengine=3Dlibaio
iodepth=3D1
size=3D1g
direct=3D1
runtime=3D30
filename=3D/media/cephmount/afile

[seq-read]
  rw=3Dread
  stonewall
[rand-read]
  rw=3Drandread
  stonewall
[seq-write]
  rw=3Dwrite
  stonewall
[rand-write]
  rw=3Drandwrite
  stonewall

thanks a lot.

On Wed, Oct 13, 2010 at 1:31 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> Hi there,
>
> I've recently been playing with Ceph on an evaluation basis, and foun=
d
> that I was able to fairly reliably induce an OOM kill on my the ceph
> client machine by using FFSB with the following configuration file (s=
ee
> attached, below).
>
> I am using Ceph v0.21.3 plus a few commits that were on the testing
> branch as of late September (commit ID 569d96b). =A0The Ceph cluster
> contains 10 commodity servers with 5 disks configured for Ceph object
> storage on each server (plus a separate spindle for the journal files=
),
> so there are 5 instances of cosd on each OSD server. =A0The disks are
> formatted using ext4 in no-journal mode. =A0I am using 3 servers for =
the
> MDS and montioring daemons, with the MDS and monitoring daemons
> colocated these 3 servers. =A0The machines all have gigabit ethernet
> cards.
>
> I've been running the client on a separate machine, and this is the
> machine which has been dying with an OOM.
>
> Any help, suggestions, or "hey stupid! =A0You screwed up XXXX in your
> ceph.conf file" would be gratefully accepted.
>
> Thanks,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 - Ted
>
> P.S. =A0In case people are curious, here are the results of the "boxa=
cle"
> (http://btrfs.boxacle.net) FFSB workloads that I ran. =A0The results =
are
> fairly stable, except very often the 8 thread random_write workload i=
s a
> little hard to reproduce because it very often OOM's. =A0I've never g=
otten
> a 32 thread random_write workload measurement, since it very reliably
> OOM's on my client machine.
>
> Do these results look reasonable to you? =A0I confess I'm a little
> disappointed with the sequential and random read numbers in particula=
r.
> And given 10 servers and fifty spindles, even the large_file_create
> numbers seems surprising slow.
>
> (Also, given the we are using gigabit ethernet in this evaluation
> cluster, the 1GB/sec seems ridiculously high, which suggests to me th=
at
> the fsync request wasn't honored -- FFSB includes the fsync time when
> calculating write bandwidth -- and it may explain why we are OOM'ing =
in
> the random_write workload.)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 thread =A0 =A0 =A0 =A0 =A0 8=
 threads =A0 =A0 =A0 =A0 =A0 =A032 threads
> large_file_create =A0 101 MB/sec =A0 =A0 =A0 =A0 102 MB/sec =A0 =A0 =A0=
 =A0 =A0 101 MB/sec
> sequential_reads =A0 =A0 35 MB/sec =A0 =A0 =A0 =A0 113 MB/sec =A0 =A0=
 =A0 =A0 =A0 114 MB/sec
> random_reads =A0 =A0 =A0 =A0 =A01.48 MB/sec =A0 =A0 =A0 =A05.44 MB/se=
c =A0 =A0 =A0 =A011.7 MB/sec
> random_writes =A0 =A0 =A0923 MB/sec =A0 =A0 =A0 =A0 =A0 1.09 GB/sec =A0=
 =A0 =A0 =A0 =A0 =A0 (*)
>
> For comparison, here are the FFSB numbers on a single local ext4 disk
> with no journal:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 thread =A0 =A0 =A0 =A0 =A0 8=
 threads =A0 =A0 =A0 =A0 =A0 =A032 threads
> large_file_create =A0 75.5 MB/sec =A0 =A0 =A0 =A072.2 MB/sec =A0 =A0 =
=A0 =A0 =A074.2 MB/sec
> sequential_reads =A0 =A077.2 MB/sec =A0 =A0 =A0 =A069.2 MB/sec =A0 =A0=
 =A0 =A0 =A070.3 MB/sec
> random_reads =A0 =A0 =A0 =A0734 K/sec =A0 =A0 =A0 =A0 =A0537 K/sec =A0=
 =A0 =A0 =A0 =A0 =A0537 K/sec
> random_writes =A0 =A0 =A0 44.5 MB/sec =A0 =A0 =A0 =A041.5 MB/sec =A0 =
=A0 =A0 =A0 =A041.6 MB/sec
>
> It's very possible that I may have done something wrong, so I've
> enclosed the ceph.conf file I used for doing this test run.... =A0ple=
ase
> let me know if there's something I've screwed up.
>
> ---------------------------- random_write.32.ffsb
> # Large file random writes.
> # 1024 files, 100MB per file.
>
> time=3D300 =A0# 5 min
> alignio=3D1
>
> [filesystem0]
> =A0 =A0 =A0 =A0location=3D/mnt/ffsb1
> =A0 =A0 =A0 =A0num_files=3D1024
> =A0 =A0 =A0 =A0min_filesize=3D104857600 =A0# 100 MB
> =A0 =A0 =A0 =A0max_filesize=3D104857600
> =A0 =A0 =A0 =A0reuse=3D1
> [end0]
>
> [threadgroup0]
> =A0 =A0 =A0 =A0num_threads=3D32
>
> =A0 =A0 =A0 =A0write_random=3D1
> =A0 =A0 =A0 =A0write_weight=3D1
>
> =A0 =A0 =A0 =A0write_size=3D5242880 =A0# 5 MB
> =A0 =A0 =A0 =A0write_blocksize=3D4096
>
> =A0 =A0 =A0 =A0[stats]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable_stats=3D1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable_range=3D1
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.00 =A0 =A0 =A00.01
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.01 =A0 =A0 =A00.02
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.02 =A0 =A0 =A00.05
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.05 =A0 =A0 =A00.10
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.10 =A0 =A0 =A00.20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.20 =A0 =A0 =A00.50
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A00.50 =A0 =A0 =A01.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A01.00 =A0 =A0 =A02.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A02.00 =A0 =A0 =A05.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 =A05.00 =A0 =A0 10.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 10.00 =A0 =A0 20.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 20.00 =A0 =A0 50.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0 50.00 =A0 =A0100.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0100.00 =A0 =A0200.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0200.00 =A0 =A0500.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range =A0500.00 =A0 1000.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range 1000.00 =A0 2000.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range 2000.00 =A0 5000.00
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msec_range 5000.00 =A010000.00
> =A0 =A0 =A0 =A0[end]
> [end0]
> ------------------------------------------------ My ceph.conf file
>
> ;
> ; This is the test ceph configuration file
> ;
> ; [tytso:20101007.0813EDT]
> ;
> ; This file defines cluster membership, the various locations
> ; that Ceph stores data, and any other runtime options.
> ;
> ; If a 'host' is defined for a daemon, the start/stop script will
> ; verify that it matches the hostname (or else ignore it). =A0If it i=
s
> ; not defined, it is assumed that the daemon is intended to start on
> ; the current host (e.g., in a setup with a startup.conf on each
> ; node).
>
> ; global
> [global]
> =A0 =A0 =A0 =A0user =3D root
> =A0 =A0 =A0 =A0pid file =3D /disk/sda3/tmp/ceph/$name.pid
> =A0 =A0 =A0 =A0logger dir =3D /disk/sda3/tmp/ceph
> =A0 =A0 =A0 =A0log dir =3D /disk/sda3/tmp/ceph
> =A0 =A0 =A0 =A0chdir =3D /disk/sda3
>
> ; monitors
> ; =A0You need at least one. =A0You need at least three if you want to
> ; =A0tolerate any node failures. =A0Always create an odd number.
> [mon]
> =A0 =A0 =A0 =A0mon data =3D /disk/sda3/cephmon/data/mon$id
>
> =A0 =A0 =A0 =A0; logging, for debugging monitor crashes, in order of
> =A0 =A0 =A0 =A0; their likelihood of being helpful :)
> =A0 =A0 =A0 =A0;debug ms =3D 1
> =A0 =A0 =A0 =A0;debug mon =3D 20
> =A0 =A0 =A0 =A0;debug paxos =3D 20
> =A0 =A0 =A0 =A0;debug auth =3D 20
>
> [mon0]
> =A0 =A0 =A0 =A0host =3D mach1
> =A0 =A0 =A0 =A0mon addr =3D 1.2.3.4:6789
>
> [mon1]
> =A0 =A0 =A0 =A0host =3D mach2
> =A0 =A0 =A0 =A0mon addr =3D 1.2.3.5:6789
>
> [mon1]
> =A0 =A0 =A0 =A0host =3D mach3
> =A0 =A0 =A0 =A0mon addr =3D 1.2.3.6:6789
>
> ; mds
> ; =A0You need at least one. =A0Define two to get a standby.
> [mds]
> =A0 =A0 =A0 =A0; where the mds keeps it's secret encryption keys
> =A0 =A0 =A0 =A0keyring =3D /data/keyring.$name
>
> =A0 =A0 =A0 =A0; mds logging to debug issues.
> =A0 =A0 =A0 =A0;debug ms =3D 1
> =A0 =A0 =A0 =A0;debug mds =3D 20
>
> [mds.alpha]
> =A0 =A0 =A0 =A0host =3D mach2
>
> [mds.beta]
> =A0 =A0 =A0 =A0host =3D mach3
>
> [mds.gamma]
> =A0 =A0 =A0 =A0host =3D mach1
>
> ; osd
> ; =A0You need at least one. =A0Two if you want data to be replicated.
> ; =A0Define as many as you like.
> [osd]
> =A0 =A0 =A0 =A0; osd logging to debug osd issues, in order of likelih=
ood of being
> =A0 =A0 =A0 =A0; helpful
> =A0 =A0 =A0 =A0;debug ms =3D 1
> =A0 =A0 =A0 =A0;debug osd =3D 20
> =A0 =A0 =A0 =A0;debug filestore =3D 20
> =A0 =A0 =A0 =A0;debug journal =3D 20
>
> [osd0]
> =A0 =A0 =A0 =A0host =3D mach10
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd1]
> =A0 =A0 =A0 =A0host =3D mach11
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd2]
> =A0 =A0 =A0 =A0host =3D mach12
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd3]
> =A0 =A0 =A0 =A0host =3D mach13
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd4]
> =A0 =A0 =A0 =A0host =3D mach14
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd5]
> =A0 =A0 =A0 =A0host =3D mach15
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd6]
> =A0 =A0 =A0 =A0host =3D mach16
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd7]
> =A0 =A0 =A0 =A0host =3D mach17
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd8]
> =A0 =A0 =A0 =A0host =3D mach18
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd9]
> =A0 =A0 =A0 =A0host =3D mach19
> =A0 =A0 =A0 =A0osd data =3D /disk/sdb3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdb3
>
> [osd10]
> =A0 =A0 =A0 =A0host =3D mach10
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd11]
> =A0 =A0 =A0 =A0host =3D mach11
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd12]
> =A0 =A0 =A0 =A0host =3D mach12
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd13]
> =A0 =A0 =A0 =A0host =3D mach13
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd14]
> =A0 =A0 =A0 =A0host =3D mach14
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd15]
> =A0 =A0 =A0 =A0host =3D mach15
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd16]
> =A0 =A0 =A0 =A0host =3D mach16
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd17]
> =A0 =A0 =A0 =A0host =3D mach17
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd18]
> =A0 =A0 =A0 =A0host =3D mach18
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd19]
> =A0 =A0 =A0 =A0host =3D mach19
> =A0 =A0 =A0 =A0osd data =3D /disk/sdd3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdd3
>
> [osd20]
> =A0 =A0 =A0 =A0host =3D mach10
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd21]
> =A0 =A0 =A0 =A0host =3D mach11
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd22]
> =A0 =A0 =A0 =A0host =3D mach12
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd23]
> =A0 =A0 =A0 =A0host =3D mach13
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd24]
> =A0 =A0 =A0 =A0host =3D mach14
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd25]
> =A0 =A0 =A0 =A0host =3D mach15
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd26]
> =A0 =A0 =A0 =A0host =3D mach16
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd27]
> =A0 =A0 =A0 =A0host =3D mach17
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd28]
> =A0 =A0 =A0 =A0host =3D mach18
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd29]
> =A0 =A0 =A0 =A0host =3D mach19
> =A0 =A0 =A0 =A0osd data =3D /disk/sde3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sde3
>
> [osd30]
> =A0 =A0 =A0 =A0host =3D mach10
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd31]
> =A0 =A0 =A0 =A0host =3D mach11
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd32]
> =A0 =A0 =A0 =A0host =3D mach12
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd33]
> =A0 =A0 =A0 =A0host =3D mach13
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd34]
> =A0 =A0 =A0 =A0host =3D mach14
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd35]
> =A0 =A0 =A0 =A0host =3D mach15
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd36]
> =A0 =A0 =A0 =A0host =3D mach16
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd37]
> =A0 =A0 =A0 =A0host =3D mach17
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd38]
> =A0 =A0 =A0 =A0host =3D mach18
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd39]
> =A0 =A0 =A0 =A0host =3D mach19
> =A0 =A0 =A0 =A0osd data =3D /disk/sdf3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdf3
>
> [osd40]
> =A0 =A0 =A0 =A0host =3D mach10
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd41]
> =A0 =A0 =A0 =A0host =3D mach11
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd42]
> =A0 =A0 =A0 =A0host =3D mach12
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd43]
> =A0 =A0 =A0 =A0host =3D mach13
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd44]
> =A0 =A0 =A0 =A0host =3D mach14
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd45]
> =A0 =A0 =A0 =A0host =3D mach15
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd46]
> =A0 =A0 =A0 =A0host =3D mach16
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd47]
> =A0 =A0 =A0 =A0host =3D mach17
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd48]
> =A0 =A0 =A0 =A0host =3D mach18
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
> [osd49]
> =A0 =A0 =A0 =A0host =3D mach19
> =A0 =A0 =A0 =A0osd data =3D /disk/sdg3/cephdata
> =A0 =A0 =A0 =A0osd journal =3D /disk/sdc3/cephjnl.sdg3
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
