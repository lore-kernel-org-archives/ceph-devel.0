From: "Yan, Zheng " <yanzheng@21cn.com>
Subject: Re: Crash and strange things on MDS
Date: Wed, 27 Feb 2013 08:03:25 +0800
Message-ID: <CAAM7YAnn-Z38AKfuW9_3U84wmiJEpzpXqpxihdfB-snPiB8v7A@mail.gmail.com>
References: <20130216010217.GA26823@kdecherf.com>
	<CAKMAVE8wv0gx6RYkFxVd3NCSiYDrOc0L42VeL4uq6z3fZMk52A@mail.gmail.com>
	<20130216182403.GB5313@kdecherf.com>
	<CAPYLRzibP6m3iEBMLs-B2u8t-cjv5-BE8_58dh55h7V2kzXSfQ@mail.gmail.com>
	<20130220010052.GO7121@kdecherf.com>
	<CAPYLRzgkR61eFuGU_NdL88bJvOD2em+TMO7g1g+X3RTFAZvY5Q@mail.gmail.com>
	<20130226175742.GE16091@kdecherf.com>
	<CAPYLRziS4rTVWU8C1fDJ6W6jgk7s9SOVnRGOcdiH9YshqGNaww@mail.gmail.com>
	<20130226195837.GH16091@kdecherf.com>
	<CAPYLRziEUnD7SAipnUwF8gz=2ZvF3vKWyiv8xEcy1PP_Lhbw0w@mail.gmail.com>
	<20130226215702.GI16091@kdecherf.com>
	<CAPYLRzgbSOt+wwPh9KSQqxN_rnU808m2Fw5FBz7iVU-QzS8XGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:32934 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab3B0AD1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Feb 2013 19:03:27 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so4552767lab.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Feb 2013 16:03:26 -0800 (PST)
In-Reply-To: <CAPYLRzgbSOt+wwPh9KSQqxN_rnU808m2Fw5FBz7iVU-QzS8XGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Kevin Decherf <kevin@kdecherf.com>, Sage Weil <sage@inktank.com>, Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, support@clever-cloud.com

On Wed, Feb 27, 2013 at 5:58 AM, Gregory Farnum <greg@inktank.com> wrot=
e:
> On Tue, Feb 26, 2013 at 1:57 PM, Kevin Decherf <kevin@kdecherf.com> w=
rote:
>> On Tue, Feb 26, 2013 at 12:26:17PM -0800, Gregory Farnum wrote:
>>> On Tue, Feb 26, 2013 at 11:58 AM, Kevin Decherf <kevin@kdecherf.com=
> wrote:
>>> > We have one folder per application (php, java, ruby). Every appli=
cation has
>>> > small (<1M) files. The folder is mounted by only one client by de=
fault.
>>> >
>>> > In case of overload, another clients spawn to mount the same fold=
er and
>>> > access the same files.
>>> >
>>> > In the following test, only one client was used to serve the
>>> > application (a website using wordpress).
>>> >
>>> > I made the test with strace to see the time of each IO request (s=
trace -T
>>> > -e trace=3Dfile) and I noticed the same pattern:
>>> >
>>> > ...
>>> > [pid  4378] stat("/data/wp-includes/user.php", {st_mode=3DS_IFREG=
|0750, st_size=3D28622, ...}) =3D 0 <0.033409>
>>> > [pid  4378] lstat("/data/wp-includes/user.php", {st_mode=3DS_IFRE=
G|0750, st_size=3D28622, ...}) =3D 0 <0.081642>
>>> > [pid  4378] open("/data/wp-includes/user.php", O_RDONLY) =3D 5 <0=
=2E041138>
>>> > [pid  4378] stat("/data/wp-includes/meta.php", {st_mode=3DS_IFREG=
|0750, st_size=3D10896, ...}) =3D 0 <0.082303>
>>> > [pid  4378] lstat("/data/wp-includes/meta.php", {st_mode=3DS_IFRE=
G|0750, st_size=3D10896, ...}) =3D 0 <0.004090>
>>> > [pid  4378] open("/data/wp-includes/meta.php", O_RDONLY) =3D 5 <0=
=2E081929>
>>> > ...
>>> >
>>> > ~250 files were accessed for only one request (thanks Wordpress.)=
=2E
>>>
>>> Okay, that is slower than I'd expect, even for an across-the-wire r=
equest...
>>>
>>> > The fs is mounted with these options: rw,noatime,name=3D<hidden>,=
secret=3D<hidden>,nodcache.
>>>
>>> What kernel and why are you using nodcache?
>>
>> We use kernel 3.7.0. nodcache is enabled by default (we only specify=
 user and
>> secretfile as mount options) and I didn't find it in the documentati=
on of
>> mount.ceph.
>>
>>> Did you have problems
>>> without that mount option? That's forcing an MDS access for most
>>> operations, rather than using local data.
>>
>> Good question, I will try it (-o dcache?).
>
> Oh right =97 I forgot Sage had enabled that by default; I don't recal=
l
> how necessary it is. (Sage?)
>

That code is buggy, see ceph_dir_test_complete(), it always return fals=
e.

Yan, Zheng


>>> > I have a debug (debug_mds=3D20) log of the active mds during this=
 test if you want.
>>>
>>> Yeah, can you post it somewhere?
>>
>> Upload in progress :-)
>
> Looking forward to it. ;)
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
