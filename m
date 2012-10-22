From: Samuel Just <sam.just@inktank.com>
Subject: Re: osd crash in ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*,
 pg_stat_t*)
Date: Mon, 22 Oct 2012 16:33:45 -0700
Message-ID: <CA+4uBUapFKOV58givOkfNF5OPGuvvnx-bo=ZkZRcQcygcvChsA@mail.gmail.com>
References: <5077458A.7030108@univ-nantes.fr>
	<CA+4uBUYnu-fNPb4Dbod72yamynOGdzDMHT8ZXjn4-RcRPJ1D3Q@mail.gmail.com>
	<50856854.6050505@univ-nantes.fr>
	<50858509.7010709@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:58970 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827Ab2JVXdq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 19:33:46 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so3025550wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 16:33:45 -0700 (PDT)
In-Reply-To: <50858509.7010709@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

Yeah, I think I've seen that before, but not yet with logs.  filestore
and osd logging would help greatly if it's reproducible.

I've put it in as #3386.
-Sam

On Mon, Oct 22, 2012 at 10:40 AM, Yann Dupont
<Yann.Dupont@univ-nantes.fr> wrote:
> Le 22/10/2012 17:37, Yann Dupont a =E9crit :
>
>> Le 15/10/2012 21:57, Samuel Just a =E9crit :
>>>
>>> debug filestore =3D 20
>>> debug osd =3D 20
>>
>> ok, just had a core
>>
>> you can grab it here :
>> http://filex.univ-nantes.fr/get?k=3DxojcpgmGoN4pR1rpqf5
>>
>> now, I'll run with debug options
>>
>> cheers
>>
> Ok, I've collected a big log. I'll try to put it online later (I'm at=
 home
> right now)
> Anyway, a quick gdb on the core show this with bt show this :
>
> #0  0x00007f9aaace6efb in raise () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #1  0x0000000000737ca7 in reraise_fatal (signum=3D11) at
> global/signal_handler.cc:58
> #2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:104
> #3  <signal handler called>
> #4  std::_Rb_tree<snapid_t, std::pair<snapid_t const, interval_set<un=
signed
> long> >, std::_Select1st<std::pair<snapid_t const, interval_set<unsig=
ned
> long> > >, std::less<snapid_t>, std::allocator<std::pair<snapid_t con=
st,
> interval_set<unsigned long> > > >::_M_begin (this=3D0x8654000, obc=3D=
0xe342000,
> pgstat=3D0x7f9a8bf97c10) at /usr/include/c++/4.4/bits/stl_tree.h:488
> #5  std::_Rb_tree<snapid_t, std::pair<snapid_t const, interval_set<un=
signed
> long> >, std::_Select1st<std::pair<snapid_t const, interval_set<unsig=
ned
> long> > >, std::less<snapid_t>, std::allocator<std::pair<snapid_t con=
st,
> interval_set<unsigned long> > > >::find (this=3D0x8654000, obc=3D0xe3=
42000,
> pgstat=3D0x7f9a8bf97c10) at /usr/include/c++/4.4/bits/stl_tree.h:1434
> #6  std::map<snapid_t, interval_set<unsigned long>, std::less<snapid_=
t>,
> std::allocator<std::pair<snapid_t const, interval_set<unsigned long> =
> >
>>::count (this=3D0x8654000, obc=3D0xe342000,
>     pgstat=3D0x7f9a8bf97c10) at /usr/include/c++/4.4/bits/stl_map.h:6=
86
> #7  ReplicatedPG::add_object_context_to_pg_stat (this=3D0x8654000,
> obc=3D0xe342000, pgstat=3D0x7f9a8bf97c10) at osd/ReplicatedPG.cc:4145
> #8  0x000000000055c93a in ReplicatedPG::recover_backfill (this=3D0x86=
54000,
> max=3D<value optimized out>) at osd/ReplicatedPG.cc:6381
> #9  0x0000000000563c1a in ReplicatedPG::start_recovery_ops (this=3D0x=
8654000,
> max=3D1, prctx=3D<value optimized out>) at osd/ReplicatedPG.cc:5959
> #10 0x00000000005d3c9d in OSD::do_recovery (this=3D0x30c9000, pg=3D0x=
8654000) at
> osd/OSD.cc:5121
> #11 0x00000000006119fd in OSD::RecoveryWQ::_process(PG*) ()
> #12 0x00000000007c176b in ThreadPool::worker (this=3D0x30c9568) at
> common/WorkQueue.cc:54
> #13 0x00000000005f609d in ThreadPool::WorkThread::entry() ()
> #14 0x00007f9aaacdeb50 in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> #15 0x00007f9aa9a1278d in clone () from /lib/x86_64-linux-gnu/libc.so=
=2E6
> #16 0x0000000000000000 in ?? ()
>
> does it helps you ?
>
> Cheers,
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
