From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: MDS running at 100% CPU, no clients
Date: Thu, 7 Mar 2013 09:32:42 -0800
Message-ID: <C9CD640E-F5F2-42D8-A729-A97BFA24F34B@cs.ucsc.edu>
References: <42F276A0-444F-4300-866D-4CDEE569D398@cs.ucsc.edu> <BD61F791-E392-4006-B363-BA15458015BB@cs.ucsc.edu> <81B89ED8-BAEA-4224-BF58-2E1B5063FEF2@cs.ucsc.edu> <E6DD31A417B340AAAA5F5F0B274EDCC1@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:36988 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab3CGRcu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 12:32:50 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so525230pbc.29
        for <ceph-devel@vger.kernel.org>; Thu, 07 Mar 2013 09:32:50 -0800 (PST)
In-Reply-To: <E6DD31A417B340AAAA5F5F0B274EDCC1@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mar 7, 2013, at 9:24 AM, Greg Farnum <greg@inktank.com> wrote:

> This isn't bringing up anything in my brain, but I don't know what th=
at _sample() function is actually doing =97 did you get any farther int=
o it?

_sample reads /proc/self/maps in a loop until eof or some other conditi=
ons. i couldn't figure out if the thread was stuck in _sample or a leve=
l up. Anyhow, my gdb-foo isn't stellar and I managed to crash the mds. =
I'm gonna stick some log points in and try to reproduce it.


> -Greg
>=20
> On Wednesday, March 6, 2013 at 6:23 PM, Noah Watkins wrote:
>=20
>> Which, looks to be in a tight loop in the memory model _sample=85
>>=20
>> (gdb) bt
>> #0 0x00007f0270d84d2d in read () from /lib/x86_64-linux-gnu/libpthre=
ad.so.0
>> #1 0x00007f027046dd88 in std::__basic_file<char>::xsgetn(char*, long=
) () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>> #2 0x00007f027046f4c5 in std::basic_filebuf<char, std::char_traits<c=
har> >::underflow() () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>> #3 0x00007f0270467ceb in std::basic_istream<char, std::char_traits<c=
har> >& std::getline<char, std::char_traits<char>, std::allocator<char>=
 >(std::basic_istream<char, std::char_traits<char> >&, std::basic_strin=
g<char, std::char_traits<char>, std::allocator<char> >&, char) () from =
/usr/lib/x86_64-linux-gnu/libstdc++.so.6
>> #4 0x000000000072bdd4 in MemoryModel::_sample(MemoryModel::snap*) ()
>> #5 0x00000000005658db in MDCache::check_memory_usage() ()
>> #6 0x00000000004ba929 in MDS::tick() ()
>> #7 0x0000000000794c65 in SafeTimer::timer_thread() ()
>> #8 0x00000000007958ad in SafeTimerThread::entry() ()
>> #9 0x00007f0270d7de9a in start_thread () from /lib/x86_64-linux-gnu/=
libpthread.so.0
>>=20
>> On Mar 6, 2013, at 6:18 PM, Noah Watkins <jayhawk@cs.ucsc.edu (mailt=
o:jayhawk@cs.ucsc.edu)> wrote:
>>=20
>>>=20
>>> On Mar 6, 2013, at 5:57 PM, Noah Watkins <jayhawk@cs.ucsc.edu (mail=
to:jayhawk@cs.ucsc.edu)> wrote:
>>>=20
>>>> The MDS process in my cluster is running at 100% CPU. In fact I th=
ought the cluster came down, but rather an ls was taking a minute. Ther=
e aren't any clients active. I've left the process running in case ther=
e is any probing you'd like to do on it:
>>>>=20
>>>> virt res cpu
>>>> 4629m 88m 5260 S 92 1.1 113:32.79 ceph-mds
>>>>=20
>>>> Thanks,
>>>> Noah
>>>=20
>>>=20
>>>=20
>>>=20
>>> This is a ceph-mds child thread under strace. The only thread
>>> that appears to be doing anything.
>>>=20
>>> root@issdm-44:/home/hadoop/hadoop-common# strace -p 3372
>>> Process 3372 attached - interrupt to quit
>>> read(1649, "7f0203235000-7f0203236000 ---p 0"..., 8191) =3D 4050
>>> read(1649, "7f0205053000-7f0205054000 ---p 0"..., 8191) =3D 4050
>>> read(1649, "7f0206e71000-7f0206e72000 ---p 0"..., 8191) =3D 4050
>>> read(1649, "7f0214144000-7f0214244000 rw-p 0"..., 8191) =3D 4020
>>> read(1649, "7f0215f62000-7f0216062000 rw-p 0"..., 8191) =3D 4020
>>> read(1649, "7f0217d80000-7f0217e80000 rw-p 0"..., 8191) =3D 4020
>>> read(1649, "7f0219b9e000-7f0219c9e000 rw-p 0"..., 8191) =3D 4020
>>> ...
>>>=20
>>> That file looks to be:
>>>=20
>>> ceph-mds 3337 root 1649r REG 0,3 0 266903 /proc/3337/maps
>>>=20
>>> (3337 is the parent process).
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org (mailto:majordomo=
@vger.kernel.org)
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
