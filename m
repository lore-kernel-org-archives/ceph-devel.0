From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Thu, 23 Sep 2010 15:14:06 +1200
Message-ID: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:35066 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0IWDOK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 23:14:10 -0400
Received: by qwh6 with SMTP id 6so862383qwh.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 20:14:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Hi all. (sorry Sage, previous msg got rejected due to the html contain)

I have several questions on Ceph configuration and setups.

Using Ubuntu 10.04 LTS i386, mainly following the guide on the Wiki.
Configuration 4 similar PCs (Duo core, 2gb+ ram) 1Gbps , MTU=3D9000:
1xMDS
1xMonitor
2xOSD (total 2 HDDs, each OSD has 1TB SATA HDD for osd0, and osd1)
7200rpm Seagate. (you know this model :p)

The mounting point was also isolated using the 5th PC (so this just
had the client)

I'm a beginning user, I'd really appreciate any helps

Question 1.
After the latest git update, i.e., 22nd-Sept (unstable)
The 'make' breaks down. Here's the last line.

> /bin/bash ../libtool --tag=3DCXX =A0 --mode=3Dlink g++ -Wall -D__CEPH=
__ -D_FILE_OFFSET_BITS=3D64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O=
2 -latomic_ops =A0-o cmon cmon.o SimpleMessenger.o libmon.a libcrush.a =
libcommon.a -lpthread -lm -lcrypto
> libtool: link: g++ -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D_REENT=
RANT -D_THREAD_SAFE -rdynamic -g -O2 -o cmon cmon.o SimpleMessenger.o =A0=
-latomic_ops libmon.a libcrush.a libcommon.a -lpthread -lm -lcrypto
> g++ -DHAVE_CONFIG_H -I. =A0 =A0-Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D=
64 -D_REENTRANT -D_THREAD_SAFE -rdynamic "-fno-builtin-malloc -fno-buil=
tin-calloc -fno-builtin-realloc -fno-builtin-free" -g -O2 -MT cosd-cosd=
=2Eo -MD -MP -MF .deps/cosd-cosd.Tpo -c -o cosd-cosd.o `test -f 'cosd.c=
c' || echo './'`cosd.cc
> cosd.cc: In function =91int main(int, const char**)=92:
> cosd.cc:65: error: =91IsHeapProfilerRunning=92 was not declared in th=
is scope
> cosd.cc:310: warning: ignoring return value of =91int chdir(const cha=
r*)=92, declared with attribute warn_unused_result
> make[2]: *** [cosd-cosd.o] Error 1
> make[2]: Leaving directory `/home/aaa/ceph/ceph/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/aaa/ceph/ceph/src'
> make: *** [all-recursive] Error 1
> aaa@s3:~/ceph/ceph$


Question 2.
Performance issue: I'm mainly interested in the speed, all
authentications have been disabled.

Very simple /etc/ceph/ceph.conf

>> [global]
>> pid file =3D /var/run/ceph/$name.pid
>> =A0 debug ms =3D 3
>> sudo =3D true
>> [osd]
>> [osd0]
>> host =3D s1
>> btrfs devs =3D /dev/sdb
>> osd data =3D /data/osd0
>> osd journal =3D /data/osd0/journal
>> osd journal size =3D 1000
>> [osd1]
>> host =3D s2
>> btrfs devs =3D /dev/sdb
>> osd data =3D /data/osd1
>> osd journal =3D /data/osd1/journal
>> osd journal size =3D 1000
>> [mds]
>> [mds0]
>> host =3D s3
>> [mon]
>> debug ms =3D 3
>> [mon0]
>> host =3D s4
>> mon data =3D /data/mon0
>> mon addr =3D 192.168.50.5:6789

Ceph seems to work okay (mounted at /ceph=A0 5th PC)
I ran fio benchmark (4 tests, random read/write sequential read/write).=
 (4k)

I find that 'read' seems just okay,, random read =3D 55 iops, sequentia=
l
read =3D 3000 iops (but I don't think it is that fast?)
But I find that 'write' is very slow, I get both random/sequential
write about 7 to 10 iops. I really suspect something is wrong. :(
Are there any tweaks that I must do to increase the iops? I'm not
really interested in the large block size.

Also, when I was just copying a large file to it, the speed quickly
deteriorated, it first reported about 40MB/s but later, goes to less
than 8MB/s or worse, sometimes freeze..
Were there further setups that I need to configure? such as
crush/replication levels? (I haven't touched any of these)

Question 3. (miscellaneous)
When I initialize Ceph, I have a script (similar the fetch script) to
make sure all configurations are the same, including ceph.conf,
basically re-initializing everything to across all PCs.
Do you guys also do this for deploying (updating to latest git) and
re-make re-install, and finally re-initialize re-mount so as to run
the tests? Is there a faster ways? e.g., quickly testing for the
performance?

Ultimately, I'm trying to do a benchmark/comparison with different
disk configurations, and possibly with different file systems.


Thanks a lot in advance
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
