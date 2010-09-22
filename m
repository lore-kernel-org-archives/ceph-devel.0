From: cang lin <fwdflywl@gmail.com>
Subject: =?windows-1252?Q?Re=3A_The_clients_can=92t_work_and_unmount_after_the_c?=
	=?windows-1252?Q?rash_of_mds?=
Date: Thu, 23 Sep 2010 02:11:51 +0800
Message-ID: <AANLkTimoi4tiJpecxGUh5SJt6GcL4YW68qy4KLDJityh@mail.gmail.com>
References: <AANLkTi=obwcoGOxJpbPJbk_bAy_Ms8BD5uSrifLpr0uX@mail.gmail.com>
	<AANLkTinT=H-ppoi8TMNA2urzHn7MrBC-kkVES1coBTP7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56527 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab0IVSLw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 14:11:52 -0400
Received: by wyb28 with SMTP id 28so113796wyb.19
        for <ceph-devel@vger.kernel.org>; Wed, 22 Sep 2010 11:11:51 -0700 (PDT)
In-Reply-To: <AANLkTinT=H-ppoi8TMNA2urzHn7MrBC-kkVES1coBTP7@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi,Greg,the mds log  has been sent to you.

2010/9/23 Gregory Farnum <gregf@hq.newdream.net>:
> On Wed, Sep 22, 2010 at 7:47 AM, cang lin <fwdflywl@gmail.com> wrote:
>> I found the clients(1 local,2 remote) can=92t access ceph today.
> The clients require an active MDS to connect, since that handles all
> the filesystem components of connection.
>
>> 10.09.21_23:37:20.331651 b4d43b70 -- ???.???.248.176:6800/3780 -->
>> mon0 ???.???.248.177:6789/0 -- mdsbeacon(4298/lz05 up:active seq
>> 497179 v27) v1 -- ?+0 0x8be0de0
>> 10.09.21_23:37:20.332446 b6347b70 -- ???.???.248.176:6800/3780 <=3D=3D
>> mon0 ???.???.248.177:6789/0 511955 =3D=3D=3D=3D mdsbeacon(4298/ceph0=
2
>> up:active seq 497179 v27) v1 =3D=3D=3D=3D 70+0+0 (116627713 0 0) 0xb=
2c967a8
>> 10.09.21_23:37:22.602613 af9ffb70 -- ???.???.248.176:6800/3780 >>
>> ???.??.229.124:0/2562359250 pipe(0x8c26b80 sd=3D23 pgs=3D0 cs=3D0
>> l=3D0).accept peer addr is really ???.???.229.124:0/2562359250 (sock=
et
>> is =A0???.???.229.124:52272/0)
>> 10.09.21_23:37:22.602813 af9ffb70 -- ???.???.248.176:6800/3780 >>
>> ???.???.229.124:0/2562359250 pipe(0x8c26b80 sd=3D23 pgs=3D0 cs=3D0
>> l=3D0).accept connect_seq 1 vs existing 1 state 2
>> msg/SimpleMessenger.cc: In function 'int SimpleMessenger::Pipe::acce=
pt()':
>> msg/SimpleMessenger.cc:740: FAILED assert(existing->state =3D=3D
>> STATE_CONNECTING || existing->state =3D=3D STATE_STANDBY ||
>> existing->state =3D=3D STATE_WAIT)
>> =A01: (SimpleMessenger::Pipe::reader()+0x830) [0x80c4ba0]
>> =A02: (SimpleMessenger::Pipe::Reader::entry()+0x14) [0x80b7d14]
>> =A03: (Thread::_entry_func(void*)+0x11) [0x80ca7c1]
>> =A04: (()+0x596e) [0x4a896e]
>> =A05: (clone()+0x5e) [0x86ca4e]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
> Well, this is interesting. Could you gzip up your mds log and send it
> to me or Sage? This shouldn't be able to happen!
> -Greg
>

Lin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
