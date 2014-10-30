From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Ceph Giant not fixed RepllicatedPG:NotStrimming?
Date: Thu, 30 Oct 2014 08:02:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410300801090.27022@cobra.newdream.net>
References: <5451FD06.5030000@vccloud.vn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="557981400-1255310582-1414681333=:27022"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5451FD06.5030000-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1255310582-1414681333=:27022
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2014, Ta Ba Tuan wrote:
>=20
> Hi Everyone,
>=20
> I upgraded Ceph to Giant by installing *tar.gz package, but appeared so=
me
> errors related Object Trimming or Snap Trimming:
> I think having some missing objects and be not recovered.

Note that this isn't giant, which is 0.87, but something a few weeks=20
older.  There were a few bugs fixed in this code, but we can't tell if=20
this was one of them without the log leading up to this message, which=20
should include either a failed assertion message or segmentation fault or=
=20
similar.

Thanks!
sage


> =A0ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03=
cae8)
> =A01: /usr/bin/ceph-osd() [0x9b6655]
> =A02: (()+0xfcb0) [0x7fa52c471cb0]
> =A03: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
> =A04: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
> const&)+0x43e) [0x82baae]
> =A05: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::n=
a,
> mpl
> _::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_=
::na,
> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
> , mpl_::na, mpl_::na>,(boost::statechart::history_mode)0>::react_impl(b=
oost::statechart::event_ba
> se const&, void const*)+0xc0) [0x870c30]
> =A06: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
> ReplicatedPG::NotTrimming, std::allocator<void>,
> boost::statechart::null_excepti
> on_translator>::process_queued_events()+0xfb) [0x8560db]
> =A07: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
> ReplicatedPG::NotTrimming, std::allocator<void>,
> boost::statechart::null_excepti
> on_translator>::process_event(boost::statechart::event_base const&)+0x1=
e)
> [0x8562ae]
> =A08: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
> =A09: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
> =A010: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
> =A011: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
> =A012: (()+0x7e9a) [0x7fa52c469e9a]
> =A013: (clone()+0x6d) [0x7fa52ae3431d]
> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to
> interpret this.
>=20
>=20
> =A0 -128> 2014-10-29 13:51:23.049357 7fa50ed9d700=A0 5 osd.21 pg_epoch:=
 104445
> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=3D=
104444
> n=3D4345 ec=3D164 les/c 104444/104272 104443/104443/104443) [21,93,49] =
r=3D0
> lpr=3D104443 pi=3D103787-104442/16 crt=3D104442'7857887 mlcod 104445'78=
57888
> active snaptrimq=3D[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] =
exit
> Started/Primary/Active/Recovered 0.000084 0 0.000000
> =A0 -127> 2014-10-29 13:51:23.049392 7fa50ed9d700=A0 5 osd.21 pg_epoch:=
 104445
> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=3D=
104444
> n=3D4345 ec=3D164 les/c 104444/104272 104443/104443/104443) [21,93,49] =
r=3D0
> lpr=3D104443 pi=3D103787-104442/16 crt=3D104442'7857887 mlcod 104445'78=
57888
> active snaptrimq=3D[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] =
enter
> Started/Primary/Active/Clean
> =A0 -126> 2014-10-29 13:51:23.049582 7fa50ed9d700=A0 1 -- 172.30.5.2:68=
38/22980
> --> 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
> 0x30d41c00 con 0x26c6ac60
>=20
>=20
> Thank you!
> --
> Tuan
> HaNoi-VietNam
>=20
>=20
>=20
--557981400-1255310582-1414681333=:27022
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-1255310582-1414681333=:27022--
