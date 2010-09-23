From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph, make (22nd-sept unstable) fails, and slow write issues.
Date: Wed, 22 Sep 2010 20:56:27 -0700
Message-ID: <AANLkTi=QA5n0pXNzFGtHYY7n0tb0TgwskDZVM-1H=RM0@mail.gmail.com>
References: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42281 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab0IWD43 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 23:56:29 -0400
Received: by qwh6 with SMTP id 6so880361qwh.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 20:56:28 -0700 (PDT)
In-Reply-To: <AANLkTim6p641hc8OWudCtSiagwi1rC6n9ymjbUBJxDLQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

On Wed, Sep 22, 2010 at 8:14 PM, DongJin Lee <dongjin.lee@auckland.ac.n=
z> wrote:
> Question 1.
> After the latest git update, i.e., 22nd-Sept (unstable)
> The 'make' breaks down. Here's the last line.
>
>> /bin/bash ../libtool --tag=3DCXX =A0 --mode=3Dlink g++ -Wall -D__CEP=
H__ -D_FILE_OFFSET_BITS=3D64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -=
O2 -latomic_ops =A0-o cmon cmon.o SimpleMessenger.o libmon.a libcrush.a=
 libcommon.a -lpthread -lm -lcrypto
>> libtool: link: g++ -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D64 -D_REEN=
TRANT -D_THREAD_SAFE -rdynamic -g -O2 -o cmon cmon.o SimpleMessenger.o =
=A0-latomic_ops libmon.a libcrush.a libcommon.a -lpthread -lm -lcrypto
>> g++ -DHAVE_CONFIG_H -I. =A0 =A0-Wall -D__CEPH__ -D_FILE_OFFSET_BITS=3D=
64 -D_REENTRANT -D_THREAD_SAFE -rdynamic "-fno-builtin-malloc -fno-buil=
tin-calloc -fno-builtin-realloc -fno-builtin-free" -g -O2 -MT cosd-cosd=
=2Eo -MD -MP -MF .deps/cosd-cosd.Tpo -c -o cosd-cosd.o `test -f 'cosd.c=
c' || echo './'`cosd.cc
>> cosd.cc: In function =91int main(int, const char**)=92:
>> cosd.cc:65: error: =91IsHeapProfilerRunning=92 was not declared in t=
his scope
>> cosd.cc:310: warning: ignoring return value of =91int chdir(const ch=
ar*)=92, declared with attribute warn_unused_result
>> make[2]: *** [cosd-cosd.o] Error 1
>> make[2]: Leaving directory `/home/aaa/ceph/ceph/src'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/home/aaa/ceph/ceph/src'
>> make: *** [all-recursive] Error 1
>> aaa@s3:~/ceph/ceph$
Hmmm -- it looks like the scripts are split on whether you have
tcmalloc installed in your system, and I don't see any obvious issues
when I go over them. Do you have tcmalloc installed? Did you try a
"make clean; make" cycle?


> Question 2.
> Performance issue: I'm mainly interested in the speed, all
> authentications have been disabled.
>
> Very simple /etc/ceph/ceph.conf
>
>>> [global]
>>> pid file =3D /var/run/ceph/$name.pid
>>> =A0 debug ms =3D 3
>>> sudo =3D true
>>> [osd]
>>> [osd0]
>>> host =3D s1
>>> btrfs devs =3D /dev/sdb
>>> osd data =3D /data/osd0
>>> osd journal =3D /data/osd0/journal
>>> osd journal size =3D 1000
>>> [osd1]
>>> host =3D s2
>>> btrfs devs =3D /dev/sdb
>>> osd data =3D /data/osd1
>>> osd journal =3D /data/osd1/journal
>>> osd journal size =3D 1000
>>> [mds]
>>> [mds0]
>>> host =3D s3
>>> [mon]
>>> debug ms =3D 3
>>> [mon0]
>>> host =3D s4
>>> mon data =3D /data/mon0
>>> mon addr =3D 192.168.50.5:6789
>
> Ceph seems to work okay (mounted at /ceph=A0 5th PC)
> I ran fio benchmark (4 tests, random read/write sequential read/write=
). (4k)
>
> I find that 'read' seems just okay,, random read =3D 55 iops, sequent=
ial
> read =3D 3000 iops (but I don't think it is that fast?)
> But I find that 'write' is very slow, I get both random/sequential
> write about 7 to 10 iops. I really suspect something is wrong. :(
> Are there any tweaks that I must do to increase the iops? I'm not
> really interested in the large block size.
>
> Also, when I was just copying a large file to it, the speed quickly
> deteriorated, it first reported about 40MB/s but later, goes to less
> than 8MB/s or worse, sometimes freeze..
> Were there further setups that I need to configure? such as
> crush/replication levels? (I haven't touched any of these)
Wow, these levels seem oddly slow. What filesystem are those disks runn=
ing?
What tool are you using to test IOPS, and what's your network setup?
If you can move the journal onto a separate device it will help.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
