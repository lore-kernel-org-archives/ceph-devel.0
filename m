From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: reproducable osd crash
Date: Sat, 23 Jun 2012 08:32:56 +0200
Message-ID: <7855C271-3A73-4090-9F5F-2F4FB12C4E73@profihost.ag>
References: <4FE319DF.3020106@profihost.ag> <B37E1F82-25E3-4ED4-B3E9-59BC2EC44CB6@profihost.ag> <4FE4F806.1080501@inktank.com> <CA+4uBUb9WVk7-htq_qBNF-T_8i4-3KEsJePhTYoAHXuXfyOuKA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:36149 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2FWGc7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 23 Jun 2012 02:32:59 -0400
In-Reply-To: <CA+4uBUb9WVk7-htq_qBNF-T_8i4-3KEsJePhTYoAHXuXfyOuKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Just <sam.just@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks did you find anything?

Am 23.06.2012 um 01:59 schrieb Sam Just <sam.just@inktank.com>:

> I am still looking into the logs.
> -Sam
>=20
> On Fri, Jun 22, 2012 at 3:56 PM, Dan Mick <dan.mick@inktank.com> wrot=
e:
>> Stefan, I'm looking at your logs and coredump now.
>>=20
>>=20
>> On 06/21/2012 11:43 PM, Stefan Priebe wrote:
>>>=20
>>> Does anybody have an idea? This is right now a showstopper to me.
>>>=20
>>> Am 21.06.2012 um 14:55 schrieb Stefan Priebe - Profihost
>>> AG<s.priebe@profihost.ag>:
>>>=20
>>>> Hello list,
>>>>=20
>>>> i'm able to reproducably crash osd daemons.
>>>>=20
>>>> How i can reproduce:
>>>>=20
>>>> Kernel: 3.5.0-rc3
>>>> Ceph: 0.47.3
>>>> FS: btrfs
>>>> Journal: 2GB tmpfs per OSD
>>>> OSD: 3x servers with 4x Intel SSD OSDs each
>>>> 10GBE Network
>>>> rbd_cache_max_age: 2.0
>>>> rbd_cache_size: 33554432
>>>>=20
>>>> Disk is set to writeback.
>>>>=20
>>>> Start a KVM VM via PXE with the disk attached in writeback mode.
>>>>=20
>>>> Then run randwrite stress more than 2 time. Mostly OSD 22 in my ca=
se
>>>> crashes.
>>>>=20
>>>> # fio --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D=
4k --size=3D200G
>>>> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fi=
o
>>>> --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --s=
ize=3D200G
>>>> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; fi=
o
>>>> --filename=3D/dev/vda1 --direct=3D1 --rw=3Drandwrite --bs=3D4k --s=
ize=3D200G
>>>> --numjobs=3D50 --runtime=3D90 --group_reporting --name=3Dfile1; ha=
lt
>>>>=20
>>>> Strangely exactly THIS OSD also has the most log entries:
>>>> 64K     ceph-osd.20.log
>>>> 64K     ceph-osd.21.log
>>>> 1,3M    ceph-osd.22.log
>>>> 64K     ceph-osd.23.log
>>>>=20
>>>> But all OSDs are set to debug osd =3D 20.
>>>>=20
>>>> dmesg shows:
>>>> ceph-osd[5381]: segfault at 3f592c000 ip 00007fa281d8eb23 sp
>>>> 00007fa27702d260 error 4 in libtcmalloc.so.0.0.0[7fa281d6a000+3d00=
0]
>>>>=20
>>>> I uploaded the following files:
>>>> priebe_fio_randwrite_ceph-osd.21.log.bz2 =3D>  OSD which was OK an=
d didn't
>>>> crash
>>>> priebe_fio_randwrite_ceph-osd.22.log.bz2 =3D>  Log from the crashe=
d OSD
>>>> =C3=BCu
>>>> priebe_fio_randwrite_core.ssdstor001.27204.bz2 =3D>  Core dump
>>>> priebe_fio_randwrite_ceph-osd.bz2 =3D>  osd binary
>>>>=20
>>>> Stefan
>>>=20
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
