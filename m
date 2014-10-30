From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Ceph Giant not fixed RepllicatedPG:NotStrimming?
Date: Thu, 30 Oct 2014 15:55:34 +0700
Message-ID: <5451FD06.5030000@vccloud.vn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684754985=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1684754985==
Content-Type: multipart/alternative;
 boundary="------------030901090107000903090702"

This is a multi-part message in MIME format.
--------------030901090107000903090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hi Everyone,

I upgraded Ceph to Giant by installing *tar.gz package, but appeared 
some errors related Object Trimming or Snap Trimming:
I think having some missing objects and be not recovered.

* ceph version 0.86*-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
  1: /usr/bin/ceph-osd() [0x9b6655]
  2: (()+0xfcb0) [0x7fa52c471cb0]
  3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
  4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim 
const&)+0x43e) [0x82baae]
  5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects, 
ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, 
mpl_::na, mpl
_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na
, mpl_::na, mpl_::na>, 
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base 
const&, void const*)+0xc0) [0x870c30]
  6: (boost::statechart::state_machine<ReplicatedPG::*SnapTrimmer, 
ReplicatedPG::NotTrimming, *std::allocator<void>, 
boost::statechart::null_excepti
on_translator>::process_queued_events()+0xfb) [0x8560db]
  7: (boost::statechart::state_machine*<ReplicatedPG::SnapTrimmer, 
ReplicatedPG::NotTrimming, *std::allocator<void>, 
boost::statechart::null_excepti
on_translator>::process_event(boost::statechart::event_base 
const&)+0x1e) [0x8562ae]
  8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
  9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
  10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
  11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
  12: (()+0x7e9a) [0x7fa52c469e9a]
  13: (clone()+0x6d) [0x7fa52ae3431d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.


   -128> 2014-10-29 13:51:23.049357 7fa50ed9d700  5 osd.21 pg_epoch: 
104445 pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] 
local-les=104444 n=4345 ec=164 les/c 104444/104272 104443/104443/104443) 
[21,93,49] r=0 lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 
104445'7857888 *active 
snaptrimq*=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] exit 
*Started/Primary/Active/Recovered 0**.0*00084 0 0.000000
   -127> 2014-10-29 13:51:23.049392 7fa50ed9d700  5 osd.21 pg_epoch: 
104445 pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] 
local-les=104444 n=4345 ec=164 les/c 104444/104272 104443/104443/104443) 
[21,93,49] r=0 lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 
104445'7857888 *active 
snaptrimq*=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] enter 
Started/Primary/Active/Clean
   -126> 2014-10-29 13:51:23.049582 7fa50ed9d700  1 -- 
172.30.5.2:6838/22980 --> 172.30.5.4:6859/8884 -- pg_info(1 pgs 
e104445:6.9d8) v4 -- ?+0 0x30d41c00 con 0x26c6ac60


Thank you!
--
Tuan
HaNoi-VietNam


--------------030901090107000903090702
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    Hi Everyone,<br>
    <br>
    I upgraded Ceph to Giant by installing *tar.gz package, but appeared
    some errors related Object Trimming or Snap Trimming:<br>
    I think having some missing objects and be not recovered.<br>
    <br>
    <b>&nbsp;ceph version 0.86</b>-106-g6f8524e
    (6f8524ef7673ab4448de2e0ff76638deaf03cae8)<br>
    &nbsp;1: /usr/bin/ceph-osd() [0x9b6655]<br>
    &nbsp;2: (()+0xfcb0) [0x7fa52c471cb0]<br>
    &nbsp;3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395)
    [0x811c25]<br>
    &nbsp;4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
    const&amp;)+0x43e) [0x82baae]<br>
    &nbsp;5:
    (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
    ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na, mpl_::na,
    mpl_::na, mpl<br>
    _::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
    mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
    mpl_::na, mpl_::na<br>
    , mpl_::na, mpl_::na&gt;,
    (boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_base
    const&amp;, void const*)+0xc0) [0x870c30]<br>
    &nbsp;6: (boost::statechart::state_machine&lt;ReplicatedPG::<b>SnapTrimmer,
      ReplicatedPG::NotTrimming, </b>std::allocator&lt;void&gt;,
    boost::statechart::null_excepti<br>
    on_translator&gt;::process_queued_events()+0xfb) [0x8560db]<br>
    &nbsp;7: (boost::statechart::state_machine<b>&lt;ReplicatedPG::SnapTrimmer,
      ReplicatedPG::NotTrimming, </b>std::allocator&lt;void&gt;,
    boost::statechart::null_excepti<br>
    on_translator&gt;::process_event(boost::statechart::event_base
    const&amp;)+0x1e) [0x8562ae]<br>
    &nbsp;8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]<br>
    &nbsp;9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]<br>
    &nbsp;10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]<br>
    &nbsp;11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]<br>
    &nbsp;12: (()+0x7e9a) [0x7fa52c469e9a]<br>
    &nbsp;13: (clone()+0x6d) [0x7fa52ae3431d]<br>
    &nbsp;NOTE: a copy of the executable, or `objdump -rdS
    &lt;executable&gt;` is needed to interpret this.<br>
    <br>
    <br>
    &nbsp; -128&gt; 2014-10-29 13:51:23.049357 7fa50ed9d700&nbsp; 5 osd.21
    pg_epoch: 104445 pg[6.9d8( v 104445'7857889
    (103730'7852406,104445'7857889] local-les=104444 n=4345 ec=164 les/c
    104444/104272 104443/104443/104443) [21,93,49] r=0 lpr=104443
    pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888 <b>active
      snaptrimq</b>=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]]
    exit <b>Started/Primary/Active/Recovered 0</b><b>.0</b>00084 0
    0.000000<br>
    &nbsp; -127&gt; 2014-10-29 13:51:23.049392 7fa50ed9d700&nbsp; 5 osd.21
    pg_epoch: 104445 pg[6.9d8( v 104445'7857889
    (103730'7852406,104445'7857889] local-les=104444 n=4345 ec=164 les/c
    104444/104272 104443/104443/104443) [21,93,49] r=0 lpr=104443
    pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888 <b>active
      snaptrimq</b>=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]]
    enter Started/Primary/Active/Clean<br>
    &nbsp; -126&gt; 2014-10-29 13:51:23.049582 7fa50ed9d700&nbsp; 1 --
    172.30.5.2:6838/22980 --&gt; 172.30.5.4:6859/8884 -- pg_info(1 pgs
    e104445:6.9d8) v4 -- ?+0 0x30d41c00 con 0x26c6ac60<br>
    <br>
    <br>
    Thank you!<br>
    --<br>
    Tuan<br>
    HaNoi-VietNam<br>
    <br>
  </body>
</html>

--------------030901090107000903090702--

--===============1684754985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1684754985==--
