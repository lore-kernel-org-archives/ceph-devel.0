From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [Regression,bisected] 2.6.39-rc3 ceph client write hangs
Date: Mon, 18 Apr 2011 10:09:57 -0600
Message-ID: <4DAC6255.6010509@sandia.gov>
References: <4DA879CA.8060305@sandia.gov>
 <201104172017.15090.maciej.rutecki@gmail.com>
 <Pine.LNX.4.64.1104172249540.18433@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:53331 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab1DRQK2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 12:10:28 -0400
In-Reply-To: <Pine.LNX.4.64.1104172249540.18433@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, dchinner@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sage Weil wrote:
> This was a simple s/igrab/ihold/ fix.  See
>=20
> 283a85dc6e670083adb1e5437bd93d163f4f801a
>=20
> in the for-linus branch of ceph-client.git.=20

This works for me.

Thanks - Jim

  I'll push to Linus in the
> next few days.
>=20
> Thanks!
> sage
>=20
>=20
>=20
>=20
> On Sun, 17 Apr 2011, Maciej Rutecki wrote:
>=20
>> I created a Bugzilla entry at=20
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D33452
>> for your bug report, please add your address to the CC list in there=
, thanks!
>>
>> On pi=C3=BF=C3=BFtek, 15 kwietnia 2011 o 19:00:58 Jim Schutt wrote:
>>> Hi,
>>>
>>> This command is hanging on 2.6.39-rc3, where /mnt/ceph is
>>> a ceph file system:
>>>    dd conv=3Dfdatasync if=3D/dev/zero of=3D/mnt/ceph/zero.`hostname=
 -s` bs=3D4k
>>> count=3D4k
>>>
>>> It works on 2.6.38.  As of commit e38f5b745075 in Linus'
>>> tree it still doesn't work.
>>>
>>> I bisected this to:
>>>
>>> 250df6ed274d767da844a5d9f05720b804240197 is the first bad commit
>>> commit 250df6ed274d767da844a5d9f05720b804240197
>>> Author: Dave Chinner <dchinner@redhat.com>
>>> Date:   Tue Mar 22 22:23:36 2011 +1100
>>>
>>>      fs: protect inode->i_state with inode->i_lock
>>>
>>> In the early stages of the bisection, bad commits would show this
>>> in dmesg:
>>>
>>> [  137.004963] libceph: loaded (mon/osd proto 15/24, osdmap 5/6 5/6=
)
>>> [  137.056431] ceph: loaded (mds proto 32)
>>> [  137.063213] libceph: client4283 fsid
>>> 950217ad-499e-eab1-03f7-f6d245f42751 [  137.063826] libceph: mon0
>>> 172.17.40.34:6789 session established [  219.658002] INFO: rcu_sche=
d_state
>>> detected stall on CPU 0 (t=3D60000 jiffies)
>>>
>>> For the last couple of bad commits during the bisection, the
>>> client box would just hang and I'd have to power-cycle it.
>>>
>>> When I reboot/remount after a hang, the file I was trying
>>> to write is there, with size and date both zero:
>>>
>>> # ls -l --time-style=3D+%s /mnt/ceph/zero.an1024
>>> -rw-r--r-- 1 jaschut jaschut 0 0 /mnt/ceph/zero.an1024
>>>
>>> strace suggests it's the write that hangs:
>>>
>>> close(3)                                =3D 0
>>> close(0)                                =3D 0
>>> open("/dev/zero", O_RDONLY)             =3D 0
>>> lseek(0, 0, SEEK_CUR)                   =3D 0
>>> close(1)                                =3D 0
>>> open("/mnt/ceph/zero.an1024", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D 1
>>> rt_sigaction(SIGUSR1, NULL, {SIG_DFL, [], 0}, 8) =3D 0
>>> rt_sigaction(SIGINT, NULL, {SIG_DFL, [], 0}, 8) =3D 0
>>> rt_sigaction(SIGUSR1, {0x401a20, [INT USR1], SA_RESTORER, 0x7f3a97f=
292d0},
>>> NULL, 8) =3D 0 rt_sigaction(SIGINT, {0x401a10, [INT USR1],
>>> SA_RESTORER|SA_NODEFER|SA_RESETHAND, 0x7f3a97f292d0}, NULL, 8) =3D =
0
>>> clock_gettime(CLOCK_MONOTONIC, {216, 671807533}) =3D 0
>>> read(0,
>>> "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
=2E.,
>>> 4096) =3D 4096 write(1,
>>> "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0".=
=2E.,
>>> 4096
>>>
>>> Let me know if I can do anything else to help sort this out.
>>>
>>> -- Jim
>>>
>>> (Please Cc: me as I am not subscribed to lkml.)
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>> --=20
>> Maciej Rutecki
>> http://www.maciek.unixy.pl
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
