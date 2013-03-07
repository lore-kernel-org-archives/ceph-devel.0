From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: MDS running at 100% CPU, no clients
Date: Wed, 6 Mar 2013 18:23:19 -0800
Message-ID: <81B89ED8-BAEA-4224-BF58-2E1B5063FEF2@cs.ucsc.edu>
References: <42F276A0-444F-4300-866D-4CDEE569D398@cs.ucsc.edu> <BD61F791-E392-4006-B363-BA15458015BB@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:51405 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404Ab3CGCXQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 21:23:16 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so6813754pbc.21
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 18:23:15 -0800 (PST)
In-Reply-To: <BD61F791-E392-4006-B363-BA15458015BB@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Which, looks to be in a tight loop in the memory model _sample=85

(gdb) bt
#0  0x00007f0270d84d2d in read () from /lib/x86_64-linux-gnu/libpthread=
=2Eso.0
#1  0x00007f027046dd88 in std::__basic_file<char>::xsgetn(char*, long) =
() from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#2  0x00007f027046f4c5 in std::basic_filebuf<char, std::char_traits<cha=
r> >::underflow() () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
#3  0x00007f0270467ceb in std::basic_istream<char, std::char_traits<cha=
r> >& std::getline<char, std::char_traits<char>, std::allocator<char> >=
(std::basic_istream<char, std::char_traits<char> >&, std::basic_string<=
char, std::char_traits<char>, std::allocator<char> >&, char) () from /u=
sr/lib/x86_64-linux-gnu/libstdc++.so.6
#4  0x000000000072bdd4 in MemoryModel::_sample(MemoryModel::snap*) ()
#5  0x00000000005658db in MDCache::check_memory_usage() ()
#6  0x00000000004ba929 in MDS::tick() ()
#7  0x0000000000794c65 in SafeTimer::timer_thread() ()
#8  0x00000000007958ad in SafeTimerThread::entry() ()
#9  0x00007f0270d7de9a in start_thread () from /lib/x86_64-linux-gnu/li=
bpthread.so.0

On Mar 6, 2013, at 6:18 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:

>=20
> On Mar 6, 2013, at 5:57 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>=20
>> The MDS process in my cluster is running at 100% CPU. In fact I thou=
ght the cluster came down, but rather an ls was taking a minute. There =
aren't any clients active. I've left the process running in case there =
is any probing you'd like to do on it:
>>=20
>> virt   res          cpu
>> 4629m  88m 5260 S   92  1.1 113:32.79 ceph-mds
>>=20
>> Thanks,
>> Noah
>>=20
>=20
>=20
> This is a ceph-mds child thread under strace. The only thread
> that appears to be doing anything.
>=20
> root@issdm-44:/home/hadoop/hadoop-common# strace -p 3372
> Process 3372 attached - interrupt to quit
> read(1649, "7f0203235000-7f0203236000 ---p 0"..., 8191) =3D 4050
> read(1649, "7f0205053000-7f0205054000 ---p 0"..., 8191) =3D 4050
> read(1649, "7f0206e71000-7f0206e72000 ---p 0"..., 8191) =3D 4050
> read(1649, "7f0214144000-7f0214244000 rw-p 0"..., 8191) =3D 4020
> read(1649, "7f0215f62000-7f0216062000 rw-p 0"..., 8191) =3D 4020
> read(1649, "7f0217d80000-7f0217e80000 rw-p 0"..., 8191) =3D 4020
> read(1649, "7f0219b9e000-7f0219c9e000 rw-p 0"..., 8191) =3D 4020
> ...
>=20
> That file looks to be:
>=20
> ceph-mds 3337 root 1649r   REG    0,3    0   266903 /proc/3337/maps
>=20
> (3337 is the parent process).

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
