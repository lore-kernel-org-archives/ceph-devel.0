From: Sage Weil <sage@newdream.net>
Subject: Re: Assert in OSDMap::Incremental::decode with recent git
Date: Wed, 16 Nov 2011 11:14:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111161113550.22555@cobra.newdream.net>
References: <20111115113747.GA32287@rcn.com> <20111115115544.GA1557@infradead.org>
 <CAF3hT9C+K_mDmL_W3RzLhjxZHn2JsNQUzmTxsda3+pnbytFPRg@mail.gmail.com>
 <20111116111641.GD4618@rcn.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1450267597-1321470848=:22555"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44010 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab1KPTOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 14:14:09 -0500
In-Reply-To: <20111116111641.GD4618@rcn.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Pieper <jjp@pobox.com>
Cc: ceph-devel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Gregory Farnum <gregory.farnum@dreamhost.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1450267597-1321470848=:22555
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 16 Nov 2011, Josh Pieper wrote:
> Gregory Farnum wrote:
> > On Tue, Nov 15, 2011 at 3:55 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
> > > I hit the same when trying to bring up a test cluster on a single
> > > physical machine. =A0As soon as moved to vstart.sh I couldn't reprodu=
ce
> > > it anymore.
> >=20
> > Hmm, interesting that it doesn't happen on vstart, since that's
> > supposed to use the new mon bootstrapping pieces as well.
> >=20
> > Josh, can you turn up monitor debugging and send me the log/post it
> > somewhere? Presumably the big refactor Sage referred to broke
> > something here.
>=20
> http://joshp.no-ip.com:8080/20111116-ceph-mon.2.log
>=20
> I've inlined a snippet from the end.

Thanks!  I've pushed a fix to master.

sage


>=20
> -Josh
>=20
> 2011-11-16 06:07:13.828322 7fce87736700 -- 192.168.122.74:6789/0 <=3D=3D =
mon.0 192.168.122.95:6789/0 30 =3D=3D=3D=3D paxos(osdmap lease lc 144 fc 14=
2 pn 0 opn 0) v1 =3D=3D=3D=3D 84+0+0 (3125715891 0 0) 0x17f2900 con 0x17357=
80
> 2011-11-16 06:07:13.828329 7fce87736700 mon.2@2(peon) e1 have connection
> 2011-11-16 06:07:13.828336 7fce87736700 mon.2@2(peon) e1 ms_dispatch exis=
ting session MonSession: mon.0 192.168.122.95:6789/0 is openallow * for mon=
=2E0 192.168.122.95:6789/0
> 2011-11-16 06:07:13.828340 7fce87736700 mon.2@2(peon) e1  caps allow *
> 2011-11-16 06:07:13.828347 7fce87736700 mon.2@2(peon).paxos(osdmap active=
 c 141..144) handle_lease on 144 now 2011-11-16 06:07:17.183529
> 2011-11-16 06:07:13.828356 7fce87736700 -- 192.168.122.74:6789/0 --> mon.=
0 192.168.122.95:6789/0 -- paxos(osdmap lease_ack lc 144 fc 141 pn 0 opn 0)=
 v1 -- ?+0 0x17f2b40
> 2011-11-16 06:07:13.828471 7fce87736700 mon.2@2(peon).paxos(osdmap active=
 c 141..144) trim_to 142 (was 141), latest_stashed 141
> 2011-11-16 06:07:13.828485 7fce87736700 store(/data/mon2) set_int osdmap/=
first_committed =3D 141
> 2011-11-16 06:07:14.126377 7fce86431700 mon.2@2(peon) e1 ms_verify_author=
izer 192.168.122.1:0/1024415 client protocol 0
> 2011-11-16 06:07:18.370639 7fce87736700 mon.2@2(peon).paxosservice(osdmap=
) _active
> 2011-11-16 06:07:18.370657 7fce87736700 mon.2@2(peon).osd e130 update_fro=
m_paxos paxos e 144, my e 130
> 2011-11-16 06:07:18.370691 7fce87736700 store(/data/mon2) get_bl osdmap/1=
31 No such file or directory
> 2011-11-16 06:07:18.370698 7fce87736700 mon.2@2(peon).osd e130 update_fro=
m_paxos  applying incremental 131
> *** Caught signal (Aborted) **
>  in thread 7fce87736700
>  ceph version 0.38-181-g2e19550 (commit:2e195500b5d3a8ab8512bcf2a219a6b7f=
f922c97)
>  1: /usr/bin/ceph-mon() [0x5c2fa6]
>  2: (()+0x10060) [0x7fce8b209060]
>  3: (gsignal()+0x35) [0x7fce8998a3a5]
>  4: (abort()+0x17b) [0x7fce8998db0b]
>  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fce8a248d7d]
>  6: (()+0xb9f26) [0x7fce8a246f26]
>  7: (()+0xb9f53) [0x7fce8a246f53]
>  8: (()+0xba04e) [0x7fce8a24704e]
>  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x127) [0x59=
6237]
>  10: (OSDMap::Incremental::decode(ceph::buffer::list::iterator&)+0x3f) [0=
x573b6f]
>  11: (OSDMonitor::update_from_paxos()+0x7b0) [0x49a9c0]
>  12: (PaxosService::_active()+0x39) [0x4933f9]
>  13: (Context::complete(int)+0xa) [0x47c12a]
>  14: (finish_contexts(CephContext*, std::list<Context*, std::allocator<Co=
ntext*> >&, int)+0xca) [0x47da8a]
>  15: (Paxos::handle_lease(MMonPaxos*)+0x36d) [0x48aafd]
>  16: (Paxos::dispatch(PaxosServiceMessage*)+0x21b) [0x48f4db]
>  17: (Monitor::_ms_dispatch(Message*)+0xcbf) [0x47b66f]
>  18: (Monitor::ms_dispatch(Message*)+0x35) [0x486425]
>  19: (SimpleMessenger::dispatch_entry()+0x84b) [0x583e8b]
>  20: (SimpleMessenger::DispatchThread::entry()+0x1c) [0x46612c]
>  21: (()+0x7efc) [0x7fce8b200efc]
>  22: (clone()+0x6d) [0x7fce89a3589d]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1450267597-1321470848=:22555--
