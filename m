From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: osd crash in ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*,
 pg_stat_t*)
Date: Mon, 22 Oct 2012 19:40:25 +0200
Message-ID: <50858509.7010709@univ-nantes.fr>
References: <5077458A.7030108@univ-nantes.fr> <CA+4uBUYnu-fNPb4Dbod72yamynOGdzDMHT8ZXjn4-RcRPJ1D3Q@mail.gmail.com> <50856854.6050505@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls1-cha.cpub.univ-nantes.fr ([193.52.103.113]:58993 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755633Ab2JVRk3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 13:40:29 -0400
In-Reply-To: <50856854.6050505@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

Le 22/10/2012 17:37, Yann Dupont a =E9crit :
> Le 15/10/2012 21:57, Samuel Just a =E9crit :
>> debug filestore =3D 20
>> debug osd =3D 20
> ok, just had a core
>
> you can grab it here :
> http://filex.univ-nantes.fr/get?k=3DxojcpgmGoN4pR1rpqf5
>
> now, I'll run with debug options
>
> cheers
>
Ok, I've collected a big log. I'll try to put it online later (I'm at=20
home right now)
Anyway, a quick gdb on the core show this with bt show this :

#0  0x00007f9aaace6efb in raise () from=20
/lib/x86_64-linux-gnu/libpthread.so.0
#1  0x0000000000737ca7 in reraise_fatal (signum=3D11) at=20
global/signal_handler.cc:58
#2  handle_fatal_signal (signum=3D11) at global/signal_handler.cc:104
#3  <signal handler called>
#4  std::_Rb_tree<snapid_t, std::pair<snapid_t const,=20
interval_set<unsigned long> >, std::_Select1st<std::pair<snapid_t const=
,=20
interval_set<unsigned long> > >, std::less<snapid_t>,=20
std::allocator<std::pair<snapid_t const, interval_set<unsigned long> > =
>=20
 >::_M_begin (this=3D0x8654000, obc=3D0xe342000, pgstat=3D0x7f9a8bf97c1=
0) at=20
/usr/include/c++/4.4/bits/stl_tree.h:488
#5  std::_Rb_tree<snapid_t, std::pair<snapid_t const,=20
interval_set<unsigned long> >, std::_Select1st<std::pair<snapid_t const=
,=20
interval_set<unsigned long> > >, std::less<snapid_t>,=20
std::allocator<std::pair<snapid_t const, interval_set<unsigned long> > =
>=20
 >::find (this=3D0x8654000, obc=3D0xe342000, pgstat=3D0x7f9a8bf97c10) a=
t=20
/usr/include/c++/4.4/bits/stl_tree.h:1434
#6  std::map<snapid_t, interval_set<unsigned long>, std::less<snapid_t>=
,=20
std::allocator<std::pair<snapid_t const, interval_set<unsigned long> > =
>=20
 >::count (this=3D0x8654000, obc=3D0xe342000,
     pgstat=3D0x7f9a8bf97c10) at /usr/include/c++/4.4/bits/stl_map.h:68=
6
#7  ReplicatedPG::add_object_context_to_pg_stat (this=3D0x8654000,=20
obc=3D0xe342000, pgstat=3D0x7f9a8bf97c10) at osd/ReplicatedPG.cc:4145
#8  0x000000000055c93a in ReplicatedPG::recover_backfill=20
(this=3D0x8654000, max=3D<value optimized out>) at osd/ReplicatedPG.cc:=
6381
#9  0x0000000000563c1a in ReplicatedPG::start_recovery_ops=20
(this=3D0x8654000, max=3D1, prctx=3D<value optimized out>) at=20
osd/ReplicatedPG.cc:5959
#10 0x00000000005d3c9d in OSD::do_recovery (this=3D0x30c9000,=20
pg=3D0x8654000) at osd/OSD.cc:5121
#11 0x00000000006119fd in OSD::RecoveryWQ::_process(PG*) ()
#12 0x00000000007c176b in ThreadPool::worker (this=3D0x30c9568) at=20
common/WorkQueue.cc:54
#13 0x00000000005f609d in ThreadPool::WorkThread::entry() ()
#14 0x00007f9aaacdeb50 in start_thread () from=20
/lib/x86_64-linux-gnu/libpthread.so.0
#15 0x00007f9aa9a1278d in clone () from /lib/x86_64-linux-gnu/libc.so.6
#16 0x0000000000000000 in ?? ()

does it helps you ?

Cheers,
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
