From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Thu, 7 Oct 2010 23:48:42 +1300
Message-ID: <AANLkTi=7DqSVaBp=dQgcH_B384QGP3vgdXUtGD=t5r6J@mail.gmail.com>
References: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
	<AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
	<AANLkTinPPeOwQ=DM4U+3OOF9iNUHLsPkeMtP8wGYj+2y@mail.gmail.com>
	<Pine.LNX.4.64.1009232208240.2831@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:24734 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab0JGKsr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Oct 2010 06:48:47 -0400
Received: by qyk10 with SMTP id 10so622173qyk.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Oct 2010 03:48:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1009232208240.2831@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

Hi Sage:

> The dbench workload is metadata intensive, and most metadata (update)
> operations require a round trip to the MDS.  The client/mds protocol =
is
> pretty aggressive about issueing leases to the client, but that only =
goes
> so far.  Metadata performance will never be as fast as a local fs for=
 a
> single process.

I see, what about the metadata workload (intensive?) for a typical
block-based benchmarks?
e.g., using iometer, iozone. for random read/write, sequential read/wri=
te..?
When I test the whole system's performance, I'd need to mount ceph,
create a file size of (2x1TB disks spread on two OSDs) -- 2TB!. Even
creating this blank file takes more than several hours.. I think this
is very hard to scale to a higher TB benchmarks, e.g., 10TB.
Is there any better/simpler approach to test the performance? possibly
just directly accessing /dev/sdX over the network?
I could simply create a small chunk of file (say 1GB) for testing, but
depending on where the chunk was created in the disk (esp. for hdd),
it could change the result.

Also, for mounting/creating, how do I check/enable -o big_writes and
-o direct_io ?


> Hmmm -- it looks like the scripts are split on whether you have
> tcmalloc installed in your system, and I don't see any obvious issues
> when I go over them. Do you have tcmalloc installed? Did you try a
> "make clean; make" cycle?

Sadly, I still get the error in some of other PCs.
cosd.cc: In function =91int main(int, const char**)=92:
cosd.cc:65: error: =91IsHeapProfilerRunning=92 was not declared in this=
 scope
cosd.cc:310: warning: ignoring return value of =91int chdir(const
char*)=92, declared with attribute warn_unused_result
make[2]: *** [cosd-cosd.o] Error 1

I've tried make-clean, and re-git everything again. only reverting
back to 'stable' version compiles. Just 'unstable' doesn't work.
Anyway to fix this, without re-installing the OS ? ;-)
Another silly question, since I'm using dpkg to build to .deb and
install, is there a faster way to make and compile? It seems that
everytime change occur, I'd need to dpkg (which takes several minutes)
and re-install again.?
I've tried to just use configure,make but it won't include nifty
stuffs for deb, like automatic daemon /etc/init.d/ceph

Thanks a lot.


On Fri, Sep 24, 2010 at 5:20 PM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 24 Sep 2010, DongJin Lee wrote:
>> > Wow, these levels seem oddly slow. What filesystem are those disks=
 running?
>> > What tool are you using to test IOPS, and what's your network setu=
p?
>> > If you can move the journal onto a separate device it will help.
>> > -Greg
>> >
>>
>> I have changed the OSD to SSD (OCZ Vertex2)
>> To simplify the problem, only one OSD is used,
>> so now, =A03 PCs =A0- 1OSD, 1MDS, 1MON (all similar spec, except the=
 OSD's
>> 1TB disk replaced with 60GB SSD), using btrfs
>> all connected to 1G/s managed switch. Iperf gives about 980Mb/s
>>
>> I ran dbench, on the OSD PC.
>> Local vs /ceph
>>
>> using dbench -t 10 100 -D /data/osd0/
>> - =A0gives 150MB/s, good and as expected.
>>
>> using dbench -t 10 100 -D /ceph
>> - =A0gives 15MB/s
>
> The dbench workload is metadata intensive, and most metadata (update)
> operations require a round trip to the MDS. =A0The client/mds protoco=
l is
> pretty aggressive about issueing leases to the client, but that only =
goes
> so far. =A0Metadata performance will never be as fast as a local fs f=
or a
> single process.
>
>> Also, I often get errors from dbench while benchmarking (only when
>> /ceph mounts, not elsewhere)
>>
>> [323] unlink '/media/cephlocal/clients/client25/~dmtmp/WORD/CHAP10.D=
OC'
>> failed - No such file or directory
>> =A0 52 =A0cleanup =A014 sec
>> =A0 39 =A0cleanup =A015 sec
>> [323] unlink '/media/cephlocal/clients/client24/~dmtmp/WORDPRO/NEWS1=
_1.LWP'
>> failed - No such file or directory
>> [323] unlink '/media/cephlocal/clients/client91/~dmtmp/WORD/CHAP10.D=
OC'
>> failed - No such file or directory
>> [323] unlink '/media/cephlocal/clients/client27/~dmtmp/WORDPRO/RESUL=
TS.XLS'
>> failed - No such file or directory
>>
>> and
>>
>> [31] open /media/cephlocal/clients/client258/filler.001 failed for
>> handle 9939 (No such file or directory)
>> [31] open /media/cephlocal/clients/client220/filler.001 failed for
>> handle 9939 (No such file or directory)
>> [111] open /media/cephlocal/clients/client218/~dmtmp/WORD failed for
>> handle 9943 (No such file or directory)
>> [91] open /media/cephlocal/clients/client986/filler.004 failed for
>> handle 9942 (No such file or directory)
>
> What version of the client are you running? =A0I was hitting this (or=
 a
> similar) problem with the dbench workload a couple weeks ago and it t=
urned
> out to be a long standing bug in fs/namei.c that has finally (finally=
!)
> been fixed in 2.6.36-rc2 (2e2e88ea). =A0I hadn't seen it actually com=
e up
> for over a year, so something must have changed with the kclient or M=
DS
> recently that made the bug happen, but in any case it's fixed now.
>
> sage
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
