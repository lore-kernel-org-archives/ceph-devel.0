From: David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Ceph Giant not fixed RepllicatedPG:NotStrimming?
Date: Tue, 4 Nov 2014 20:36:29 -0800
Message-ID: <927B4C33-2889-4D70-9309-BDD1495C2FF1@redhat.com>
References: <5451FD06.5030000@vccloud.vn>
	<alpine.DEB.2.00.1410300801090.27022@cobra.newdream.net>
	<5453B0B1.1020404@vccloud.vn>
	<CA+4uBUbYPZzHhkkQaB5wS8E2-idnrsnJB21zfjA6akz7NHPrnA@mail.gmail.com>
	<54544395.4030504@vccloud.vn> <54570E5D.9050009@vccloud.vn>
	<CA+4uBUaEuB3OW-Q3Lup+bx7WRYZqvL9P594XR8UHYO-H5A+82g@mail.gmail.com>
	<5458964C.5070901@vccloud.vn>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: multipart/mixed; boundary="===============1311961738=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5458964C.5070901-QlevPasa8l681eZEIcUDRw@public.gmane.org>
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
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1311961738==
Content-Type: multipart/alternative; boundary="Apple-Mail=_9FFE3050-2B63-40B0-BC33-D3E0EAF230C3"


--Apple-Mail=_9FFE3050-2B63-40B0-BC33-D3E0EAF230C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Can you upload the entire log file?

David

> On Nov 4, 2014, at 1:03 AM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> wrote:
>=20
> Hi Sam,
> I resend logs with debug options  http://123.30.41.138/ceph-osd.21.log =
<http://123.30.41.138/ceph-osd.21.log> =20
> (Sorry about my spam :D)
>=20
> I saw many missing objects :|
>=20
> 2014-11-04 15:26:02.205607 7f3ab11a8700 10 osd.21 pg_epoch: 106407 =
pg[24.7d7( v 106407'491583 lc 106401'491579 =
(105805'487042,106407'491583] loca
> l-les=3D106403 n=3D179 ec=3D25000 les/c 106403/106390 =
106402/106402/106402) [21,28,4] r=3D0 lpr=3D106402 pi=3D106377-106401/4 =
rops=3D1 crt=3D106401'491581 mlcod=20
> 106393'491097 active+recovering+degraded m=3D2 =
snaptrimq=3D[306~1,312~1]] recover_primary =
675ea7d7/rbd_data.4930222ae8944a.0000000000000001/head//24 106401'491580 =
(missing) (missing head) (recovering) (recovering head)
> 2014-11-04 15:26:02.205642 7f3ab11a8700 10 osd.21 pg_epoch: 106407 =
pg[24.7d7( v 106407'491583 lc 106401'491579 =
(105805'487042,106407'491583] local-les=3D106403 n=3D179 ec=3D25000 =
les/c 106403/106390 106402/106402/106402) [21,28,4] r=3D0 lpr=3D106402 =
pi=3D106377-106401/4 rops=3D1 crt=3D106401'491581 mlcod 106393'491097 =
active+recovering+degraded m=3D2 snaptrimq=3D[306~1,312~1]] =
recover_primary         =
d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24 106401'491581 =
(missing) (missing head)
> 2014-11-04 15:26:02.237994 7f3ab29ab700 10 osd.21 pg_epoch: 106407 =
pg[24.7d7( v 106407'491583 lc 106401'491579 =
(105805'487042,106407'491583] local-les=3D106403 n=3D179 ec=3D25000 =
les/c 106403/106390 106402/106402/106402) [21,28,4] r=3D0 lpr=3D106402 =
pi=3D106377-106401/4 rops=3D2 crt=3D106401'491581 mlcod 106393'491097 =
active+recovering+degraded m=3D2 snaptrimq=3D[306~1,312~1]] got missing =
d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24 v =
106401'491581
>=20
> Thanks Sam and All,
> --
> Tuan
> HaNoi-Vietnam
>=20
> On 11/04/2014 04:54 AM, Samuel Just wrote:
>> Can you reproduce with
>>=20
>> debug osd =3D 20
>> debug filestore =3D 20
>> debug ms =3D 1
>>=20
>> In the [osd] section of that osd's ceph.conf?
>> -Sam
>>=20
>> On Sun, Nov 2, 2014 at 9:10 PM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> =
<mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> wrote:
>>> Hi Sage, Samuel & All,
>>>=20
>>> I upgraded to GAINT, but still appearing that errors |:
>>> I'm trying on deleting  related objects/volumes, but very hard to =
verify
>>> missing objects :(.
>>>=20
>>> Guide me to resolve it, please! (I send attached detail log).
>>>=20
>>> 2014-11-03 11:37:57.730820 7f28fb812700  0 osd.21 105950 do_command =
r=3D0
>>> 2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal =
(Segmentation
>>> fault) **
>>>  in thread 7f28fc013700
>>>=20
>>>  ceph version 0.87-6-gdba7def =
(dba7defc623474ad17263c9fccfec60fe7a439f0)
>>>  1: /usr/bin/ceph-osd() [0x9b6725]
>>>  2: (()+0xfcb0) [0x7f291fc2acb0]
>>>  3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811b55]
>>>  4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>> const&)+0x43e) [0x82b9be]
>>>  5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na>,
>>> =
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_b=
ase
>>> const&, void const*)+0xc0) [0x870ce0]
>>>  6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> =
boost::statechart::null_exception_translator>::process_queued_events()+0xf=
b)
>>> [0x85618b]
>>>  7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> =
boost::statechart::null_exception_translator>::process_event(boost::statec=
hart::event_base
>>> const&)+0x1e) [0x85633e]
>>>  8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5ef8]
>>>  9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x673ab4]
>>>  10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fade]
>>>  11: (ThreadPool::WorkThread::entry()+0x10) [0xa92870]
>>>  12: (()+0x7e9a) [0x7f291fc22e9a]
>>>  13: (clone()+0x6d) [0x7f291e5ed31d]
>>>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed to
>>> interpret this.
>>>=20
>>>  -9993> 2014-11-03 11:37:47.689335 7f28fc814700  1 -- =
172.30.5.2:6803/7606
>>> --> 172.30.5.1:6886/3511 -- MOSDPGPull(6.58e 105950
>>> [PullOp(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head//6,
>>> recovery_info:
>>> =
ObjectRecoveryInfo(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head/=
/6@105938'11622009,
>>> copy_subset: [0~18446744073709551615], clone_subset: {}), =
recovery_progress:
>>> ObjectRecoveryProgress(first, data_recovered_to:0, =
data_complete:false,
>>> omap_recovered_to:, omap_complete:false))]) v2 -- ?+0 0x26c59000 con
>>> 0x22fbc420
>>> ....
>>>     -2> 2014-11-03 11:37:57.853585 7f2902820700  5 osd.21 pg_epoch: =
105950
>>> pg[24.9e4( v 105946'113392 lc 105946'113391 =
(103622'109598,105946'113392]
>>> local-les=3D1
>>> 05948 n=3D88 ec=3D25000 les/c 105948/105943 105947/105947/105947) =
[21,112,33]
>>> r=3D0 lpr=3D105947 pi=3D105933-105946/4 crt=3D105946'113392 lcod 0'0 =
mlcod 0'0
>>> active+recovery
>>> _wait+degraded m=3D1 snaptrimq=3D[303~3,307~1]] enter
>>> Started/Primary/Active/Recovering
>>>     -1> 2014-11-03 11:37:57.853735 7f28fc814700  1 -- =
172.30.5.2:6803/7606
>>> --> 172.30.5.9:6806/24552 -- MOSDPGPull(24.9e4 105950
>>> [PullOp(5abb99e4/rbd_data.5dd32
>>> f2ae8944a.0000000000000165/head//24, recovery_info:
>>> =
ObjectRecoveryInfo(5abb99e4/rbd_data.5dd32f2ae8944a.0000000000000165/head/=
/24@105946'113392,
>>> copy_subset: [0
>>> ~18446744073709551615], clone_subset: {}), recovery_progress:
>>> ObjectRecoveryProgress(first, data_recovered_to:0, =
data_complete:false,
>>> omap_recovered_to:, omap_c
>>> omplete:false))]) v2 -- ?+0 0x229e7e00 con 0x22fb7000
>>>      0> 2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal
>>> (Segmentation fault) **
>>>=20
>>> Thanks!
>>> --
>>> Tuan
>>> HaNoi-VietNam
>>>=20
>>>=20
>>>=20
>>>=20
>>> On 11/01/2014 09:21 AM, Ta Ba Tuan wrote:
>>>=20
>>> Hi Samuel and Sage,
>>>=20
>>> I will upgrde to Giant soon, Thank you so much.
>>>=20
>>> --
>>> Tuan
>>> HaNoi-VietNam
>>>=20
>>> On 11/01/2014 01:10 AM, Samuel Just wrote:
>>>=20
>>> You should start by upgrading to giant, many many bug fixes went in
>>> between .86 and giant.
>>> -Sam
>>>=20
>>> On Fri, Oct 31, 2014 at 8:54 AM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> =
<mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> wrote:
>>>=20
>>> Hi Sage Weil
>>>=20
>>> Thank for your repling. Yes, I'm using Ceph v.0.86,
>>> I report some related bugs, Hope you help me,
>>>=20
>>> 2014-10-31 15:34:52.927965 7f85efb6b700  0 osd.21 104744 do_command =
r=3D0
>>> 2014-10-31 15:34:53.105533 7f85f036c700 -1 *** Caught signal =
(Segmentation
>>> fault) **
>>>   in thread 7f85f036c700
>>>   ceph version 0.86-106-g6f8524e =
(6f8524ef7673ab4448de2e0ff76638deaf03cae8)
>>>   1: /usr/bin/ceph-osd() [0x9b6655]
>>>   2: (()+0xfcb0) [0x7f8615726cb0]
>>>   3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
>>>   4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>> const&)+0x43e) [0x82baae]
>>>   5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na>,
>>> =
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_b=
ase
>>> const&, void const*)+0xc0) [0x870c30]
>>>   6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> =
boost::statechart::null_exception_translator>::process_queued_events()+0xf=
b)
>>> [0x8560db]
>>>   7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> =
boost::statechart::null_exception_translator>::process_event(boost::statec=
hart::event_base
>>> const&)+0x1e) [0x8562ae]
>>>   8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
>>>   9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
>>>   10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
>>>   11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
>>>   12: (()+0x7e9a) [0x7f861571ee9a]
>>>   13: (clone()+0x6d) [0x7f86140e931d]
>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed
>>> to
>>> interpret this.
>>>=20
>>>   -9523> 2014-10-31 15:34:45.571962 7f85e3ee0700  5 -- op tracker -- =
seq:
>>> 6937, time: 2014-10-31 15:34:45.531887, event: header_read, op: =
MOSDPGPus
>>> h(6.749 104744
>>> [PushOp(d2106749/rbd_data.a2e6185b9a8ef8.0000000000000803/head//6, =
version:
>>> 104736'7736506, data_included: [0~4194304], data_size:
>>> 4194304, omap_header_size: 0, omap_entries_size: 0, attrset_size: 2,
>>> recovery_info:
>>> ObjectRecoveryInfo(d2106749/rbd_data.a2e6185b9a8ef8.0000000000
>>> 000803/head//6@104736'7736506, copy_subset: [0~4194304], =
clone_subset: {}),
>>> after_progress: ObjectRecoveryProgress(!first, =
data_recovered_to:41943
>>> 04, data_complete:true, omap_recovered_to:, omap_complete:true),
>>> before_progress: ObjectRecoveryProgress(first, data_recovered_to:0,
>>> data_complete
>>> :false, omap_recovered_to:,
>>> =
omap_complete:false)),PushOp(60940749/rbd_data.3435875ff78f67.000000000000=
1408/head//6,
>>> version: 104736'7736579, data_
>>> included: [0~335360], data_size: 335360, omap_header_size: 0,
>>> omap_entries_size: 0, attrset_size: 2, recovery_info:
>>> ObjectRecoveryInfo(60940749/rb
>>> d_data.3435875ff78f67.0000000000001408/head//6@104736'7736579, =
copy_subset:
>>> [0~335360], clone_subset: {}), after_progress: =
ObjectRecoveryProgress(
>>> !first, data_recovered_to:335360, data_complete:true, =
omap_recovered_to:,
>>> omap_complete:true), before_progress: ObjectRecoveryProgress(first, =
data
>>> _recovered_to:0, data_complete:false, omap_recovered_to:,
>>> =
omap_complete:false)),PushOp(922b1749/rbd_data.1c3dade6cdc10.0000000000001=
4c5/head//6,
>>> v
>>> ersion: 104736'7736866, data_included: [0~4194304], data_size: =
4194304,
>>> omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, =
recovery_info:
>>>=20
>>> =
ObjectRecoveryInfo(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//=
6@104736'7736866,
>>> copy_subset: [0~4194304], clone_subset: {}), after_pr
>>> ogress: ObjectRecoveryProgress(!first, data_recovered_to:4194304,
>>> data_complete:true, omap_recovered_to:, omap_complete:true),
>>> before_progress: Ob
>>> jectRecoveryProgress(first, data_recovered_to:0, =
data_complete:false,
>>> omap_recovered_to:, omap_complete:false))])
>>>=20
>>>   -6933> 2014-10-31 15:34tha7.611229 7f85f737a700  5 osd.21 =
pg_epoch: 104744
>>> pg[6.749( v 104744'7741801 (104665'7732106,104744'7741801] lb
>>> 14886749/rbd_data.3955b9640616f2.000000000000f5e2/head//6 =
local-les=3D104661
>>> n=3D1780 ec=3D164 les/c 104742/104735 104740/104741/103210) =
[74,112,21]/[74,112]
>>> r=3D-1 lpr=3D104741 pi=3D64005-104740/278 luod=3D0'0 =
crt=3D104744'7741798
>>> active+remapped] enter Started/ReplicaActive/RepNotRecovering
>>>=20
>>> I think having some missing objects, I can't start one osd  that =
above
>>> objects be pushed to that osd. Ceph'versions are slower 0.86 then =
appear
>>> this bug?
>>> Should I upgrade to Giant o resolve this bug?,
>>>=20
>>>=20
>>> Thank you,
>>> --
>>> Tuan
>>> HaNoi-VietNam
>>>=20
>>>=20
>>> On 10/30/2014 10:02 PM, Sage Weil wrote:
>>>=20
>>> On Thu, 30 Oct 2014, Ta Ba Tuan wrote:
>>>=20
>>> Hi Everyone,
>>>=20
>>> I upgraded Ceph to Giant by installing *tar.gz package, but appeared =
some
>>> errors related Object Trimming or Snap Trimming:
>>> I think having some missing objects and be not recovered.
>>>=20
>>> Note that this isn't giant, which is 0.87, but something a few weeks
>>> older.  There were a few bugs fixed in this code, but we can't tell =
if
>>> this was one of them without the log leading up to this message, =
which
>>> should include either a failed assertion message or segmentation =
fault or
>>> similar.
>>>=20
>>> Thanks!
>>> sage
>>>=20
>>>=20
>>>   ceph version 0.86-106-g6f8524e =
(6f8524ef7673ab4448de2e0ff76638deaf03cae8)
>>>   1: /usr/bin/ceph-osd() [0x9b6655]
>>>   2: (()+0xfcb0) [0x7fa52c471cb0]
>>>   3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
>>>   4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>> const&)+0x43e) [0x82baae]
>>>   5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl
>>> _::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, =
mpl_::na,
>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
>>> , mpl_::na,
>>> =
mpl_::na>,(boost::statechart::history_mode)0>::react_impl(boost::statechar=
t::event_ba
>>> se const&, void const*)+0xc0) [0x870c30]
>>>   6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> boost::statechart::null_excepti
>>> on_translator>::process_queued_events()+0xfb) [0x8560db]
>>>   7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>> boost::statechart::null_excepti
>>> on_translator>::process_event(boost::statechart::event_base =
const&)+0x1e)
>>> [0x8562ae]
>>>   8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
>>>   9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
>>>   10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
>>>   11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
>>>   12: (()+0x7e9a) [0x7fa52c469e9a]
>>>   13: (clone()+0x6d) [0x7fa52ae3431d]
>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is =
needed
>>> to
>>> interpret this.
>>>=20
>>>=20
>>>    -128> 2014-10-29 13:51:23.049357 7fa50ed9d700  5 osd.21 pg_epoch: =
104445
>>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] =
local-les=3D104444
>>> n=3D4345 ec=3D164 les/c 104444/104272 104443/104443/104443) =
[21,93,49] r=3D0
>>> lpr=3D104443 pi=3D103787-104442/16 crt=3D104442'7857887 mlcod =
104445'7857888
>>> active snaptrimq=3D[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]]=
 exit
>>> Started/Primary/Active/Recovered 0.000084 0 0.000000
>>>    -127> 2014-10-29 13:51:23.049392 7fa50ed9d700  5 osd.21 pg_epoch: =
104445
>>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] =
local-les=3D104444
>>> n=3D4345 ec=3D164 les/c 104444/104272 104443/104443/104443) =
[21,93,49] r=3D0
>>> lpr=3D104443 pi=3D103787-104442/16 crt=3D104442'7857887 mlcod =
104445'7857888
>>> active snaptrimq=3D[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]]=
 enter
>>> Started/Primary/Active/Clean
>>>    -126> 2014-10-29 13:51:23.049582 7fa50ed9d700  1 -- =
172.30.5.2:6838/22980
>>> --> 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
>>> 0x30d41c00 con 0x26c6ac60
>>>=20
>>>=20
>>> Thank you!
>>> --
>>> Tuan
>>> HaNoi-VietNam
>>>=20
>>>=20
>>>=20
>>>=20
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com =
<http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>
>>>=20
>>>=20
>>>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_9FFE3050-2B63-40B0-BC33-D3E0EAF230C3
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv="Content-Type" content="text/html charset=us-ascii"></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" class=""><div class=""><br class=""></div><div class="">Can you upload the entire log file?</div><div class=""><br class=""></div><div class="">David</div><br class=""><div><blockquote type="cite" class=""><div class="">On Nov 4, 2014, at 1:03 AM, Ta Ba Tuan &lt;<a href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org" class="">tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org</a>&gt; wrote:</div><br class="Apple-interchange-newline"><div class="">
  
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" class="">
  
  <div bgcolor="#FFFFFF" text="#000000" class="">
    <div class="moz-cite-prefix">Hi Sam,<br class="">
      I resend logs with debug options&nbsp;
      <a class="moz-txt-link-freetext" href="http://123.30.41.138/ceph-osd.21.log">http://123.30.41.138/ceph-osd.21.log</a>&nbsp; <br class="">
      (Sorry about my spam :D)<br class="">
      <br class="">
      I saw many missing objects :|<br class="">
      <br class="">
      <small class="">2014-11-04 15:26:02.205607 7f3ab11a8700 10 osd.21 pg_epoch:
        106407 pg[24.7d7( v 106407'491583 lc 106401'491579
        (105805'487042,106407'491583] loca<br class="">
        l-les=106403 n=179 ec=25000 les/c 106403/106390
        106402/106402/106402) [21,28,4] r=0 lpr=106402
        pi=106377-106401/4 rops=1 crt=106401'491581 mlcod <br class="">
        106393'491097 active+recovering+degraded m=2
        snaptrimq=[306~1,312~1]] recover_primary 675ea7d7/<b class="">rbd_data.4930222ae8944a.0000000000000001/head//24
          106401'491580 (missing) (missing head) (recovering)
          (recovering head)</b><br class="">
        2014-11-04 15:26:02.205642 7f3ab11a8700 10 osd.21 pg_epoch:
        106407 pg[24.7d7( v 106407'491583 lc 106401'491579
        (105805'487042,106407'491583] local-les=106403 n=179 ec=25000
        les/c 106403/106390 106402/106402/106402) [21,28,4] r=0
        lpr=106402 pi=106377-106401/4 rops=1 crt=106401'491581 mlcod
        106393'491097 active+recovering+degraded m=2
        snaptrimq=[306~1,312~1]] recover_primary
        d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24
        106401'491581 (missing) (missing head)<br class="">
        2014-11-04 15:26:02.237994 7f3ab29ab700 10 osd.21 pg_epoch:
        106407 pg[24.7d7( v 106407'491583 lc 106401'491579
        (105805'487042,106407'491583] local-les=106403 n=179 ec=25000
        les/c 106403/106390 106402/106402/106402) [21,28,4] r=0
        lpr=106402 pi=106377-106401/4 rops=2 crt=106401'491581 mlcod
        106393'491097 active+recovering+degraded m=2
        snaptrimq=[306~1,312~1]] <b class="">got missing
          d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24 v
          106401'491581</b><br class="">
      </small><br class="">
      Thanks Sam and All,<br class="">
      --<br class="">
      Tuan<br class="">
      HaNoi-Vietnam<br class="">
      <br class="">
      On 11/04/2014 04:54 AM, Samuel Just wrote:<br class="">
    </div>
    <blockquote cite="mid:CA+4uBUaEuB3OW-Q3Lup+bx7WRYZqvL9P594XR8UHYO-H5A+82g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org" type="cite" class="">
      <pre wrap="" class="">Can you reproduce with

debug osd = 20
debug filestore = 20
debug ms = 1

In the [osd] section of that osd's ceph.conf?
-Sam

On Sun, Nov 2, 2014 at 9:10 PM, Ta Ba Tuan <a class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:
</pre>
      <blockquote type="cite" class="">
        <pre wrap="" class="">Hi Sage, Samuel &amp; All,

I upgraded to GAINT, but still appearing that errors |:
I'm trying on deleting  related objects/volumes, but very hard to verify
missing objects :(.

Guide me to resolve it, please! (I send attached detail log).

2014-11-03 11:37:57.730820 7f28fb812700  0 osd.21 105950 do_command r=0
2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal (Segmentation
fault) **
 in thread 7f28fc013700

 ceph version 0.87-6-gdba7def (dba7defc623474ad17263c9fccfec60fe7a439f0)
 1: /usr/bin/ceph-osd() [0x9b6725]
 2: (()+0xfcb0) [0x7f291fc2acb0]
 3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395) [0x811b55]
 4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
const&amp;)+0x43e) [0x82b9be]
 5: (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na&gt;,
(boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_base
const&amp;, void const*)+0xc0) [0x870ce0]
 6: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_exception_translator&gt;::process_queued_events()+0xfb)
[0x85618b]
 7: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_exception_translator&gt;::process_event(boost::statechart::event_base
const&amp;)+0x1e) [0x85633e]
 8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5ef8]
 9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x673ab4]
 10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fade]
 11: (ThreadPool::WorkThread::entry()+0x10) [0xa92870]
 12: (()+0x7e9a) [0x7f291fc22e9a]
 13: (clone()+0x6d) [0x7f291e5ed31d]
 NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed to
interpret this.

 -9993&gt; 2014-11-03 11:37:47.689335 7f28fc814700  1 -- 172.30.5.2:6803/7606
--&gt; 172.30.5.1:6886/3511 -- MOSDPGPull(6.58e 105950
[PullOp(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head//6,
recovery_info:
ObjectRecoveryInfo(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head//6@105938'11622009,
copy_subset: [0~18446744073709551615], clone_subset: {}), recovery_progress:
ObjectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
omap_recovered_to:, omap_complete:false))]) v2 -- ?+0 0x26c59000 con
0x22fbc420
....
    -2&gt; 2014-11-03 11:37:57.853585 7f2902820700  5 osd.21 pg_epoch: 105950
pg[24.9e4( v 105946'113392 lc 105946'113391 (103622'109598,105946'113392]
local-les=1
05948 n=88 ec=25000 les/c 105948/105943 105947/105947/105947) [21,112,33]
r=0 lpr=105947 pi=105933-105946/4 crt=105946'113392 lcod 0'0 mlcod 0'0
active+recovery
_wait+degraded m=1 snaptrimq=[303~3,307~1]] enter
Started/Primary/Active/Recovering
    -1&gt; 2014-11-03 11:37:57.853735 7f28fc814700  1 -- 172.30.5.2:6803/7606
--&gt; 172.30.5.9:6806/24552 -- MOSDPGPull(24.9e4 105950
[PullOp(5abb99e4/rbd_data.5dd32
f2ae8944a.0000000000000165/head//24, recovery_info:
ObjectRecoveryInfo(5abb99e4/rbd_data.5dd32f2ae8944a.0000000000000165/head//24@105946'113392,
copy_subset: [0
~18446744073709551615], clone_subset: {}), recovery_progress:
ObjectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
omap_recovered_to:, omap_c
omplete:false))]) v2 -- ?+0 0x229e7e00 con 0x22fb7000
     0&gt; 2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal
(Segmentation fault) **

Thanks!
--
Tuan
HaNoi-VietNam




On 11/01/2014 09:21 AM, Ta Ba Tuan wrote:

Hi Samuel and Sage,

I will upgrde to Giant soon, Thank you so much.

--
Tuan
HaNoi-VietNam

On 11/01/2014 01:10 AM, Samuel Just wrote:

You should start by upgrading to giant, many many bug fixes went in
between .86 and giant.
-Sam

On Fri, Oct 31, 2014 at 8:54 AM, Ta Ba Tuan <a class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:

Hi Sage Weil

Thank for your repling. Yes, I'm using Ceph v.0.86,
I report some related bugs, Hope you help me,

2014-10-31 15:34:52.927965 7f85efb6b700  0 osd.21 104744 do_command r=0
2014-10-31 15:34:53.105533 7f85f036c700 -1 *** Caught signal (Segmentation
fault) **
  in thread 7f85f036c700
  ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
  1: /usr/bin/ceph-osd() [0x9b6655]
  2: (()+0xfcb0) [0x7f8615726cb0]
  3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395) [0x811c25]
  4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
const&amp;)+0x43e) [0x82baae]
  5: (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na&gt;,
(boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_base
const&amp;, void const*)+0xc0) [0x870c30]
  6: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_exception_translator&gt;::process_queued_events()+0xfb)
[0x8560db]
  7: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_exception_translator&gt;::process_event(boost::statechart::event_base
const&amp;)+0x1e) [0x8562ae]
  8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
  9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
  10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
  11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
  12: (()+0x7e9a) [0x7f861571ee9a]
  13: (clone()+0x6d) [0x7f86140e931d]
  NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed
to
interpret this.

  -9523&gt; 2014-10-31 15:34:45.571962 7f85e3ee0700  5 -- op tracker -- seq:
6937, time: 2014-10-31 15:34:45.531887, event: header_read, op: MOSDPGPus
h(6.749 104744
[PushOp(d2106749/rbd_data.a2e6185b9a8ef8.0000000000000803/head//6, version:
104736'7736506, data_included: [0~4194304], data_size:
4194304, omap_header_size: 0, omap_entries_size: 0, attrset_size: 2,
recovery_info:
ObjectRecoveryInfo(d2106749/rbd_data.a2e6185b9a8ef8.0000000000
000803/head//6@104736'7736506, copy_subset: [0~4194304], clone_subset: {}),
after_progress: ObjectRecoveryProgress(!first, data_recovered_to:41943
04, data_complete:true, omap_recovered_to:, omap_complete:true),
before_progress: ObjectRecoveryProgress(first, data_recovered_to:0,
data_complete
:false, omap_recovered_to:,
omap_complete:false)),PushOp(60940749/rbd_data.3435875ff78f67.0000000000001408/head//6,
version: 104736'7736579, data_
included: [0~335360], data_size: 335360, omap_header_size: 0,
omap_entries_size: 0, attrset_size: 2, recovery_info:
ObjectRecoveryInfo(60940749/rb
d_data.3435875ff78f67.0000000000001408/head//6@104736'7736579, copy_subset:
[0~335360], clone_subset: {}), after_progress: ObjectRecoveryProgress(
!first, data_recovered_to:335360, data_complete:true, omap_recovered_to:,
omap_complete:true), before_progress: ObjectRecoveryProgress(first, data
_recovered_to:0, data_complete:false, omap_recovered_to:,
omap_complete:false)),PushOp(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6,
v
ersion: 104736'7736866, data_included: [0~4194304], data_size: 4194304,
omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info:

ObjectRecoveryInfo(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6@104736'7736866,
copy_subset: [0~4194304], clone_subset: {}), after_pr
ogress: ObjectRecoveryProgress(!first, data_recovered_to:4194304,
data_complete:true, omap_recovered_to:, omap_complete:true),
before_progress: Ob
jectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
omap_recovered_to:, omap_complete:false))])

  -6933&gt; 2014-10-31 15:34tha7.611229 7f85f737a700  5 osd.21 pg_epoch: 104744
pg[6.749( v 104744'7741801 (104665'7732106,104744'7741801] lb
14886749/rbd_data.3955b9640616f2.000000000000f5e2/head//6 local-les=104661
n=1780 ec=164 les/c 104742/104735 104740/104741/103210) [74,112,21]/[74,112]
r=-1 lpr=104741 pi=64005-104740/278 luod=0'0 crt=104744'7741798
active+remapped] enter Started/ReplicaActive/RepNotRecovering

I think having some missing objects, I can't start one osd  that above
objects be pushed to that osd. Ceph'versions are slower 0.86 then appear
this bug?
Should I upgrade to Giant o resolve this bug?,


Thank you,
--
Tuan
HaNoi-VietNam


On 10/30/2014 10:02 PM, Sage Weil wrote:

On Thu, 30 Oct 2014, Ta Ba Tuan wrote:

Hi Everyone,

I upgraded Ceph to Giant by installing *tar.gz package, but appeared some
errors related Object Trimming or Snap Trimming:
I think having some missing objects and be not recovered.

Note that this isn't giant, which is 0.87, but something a few weeks
older.  There were a few bugs fixed in this code, but we can't tell if
this was one of them without the log leading up to this message, which
should include either a failed assertion message or segmentation fault or
similar.

Thanks!
sage


  ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
  1: /usr/bin/ceph-osd() [0x9b6655]
  2: (()+0xfcb0) [0x7fa52c471cb0]
  3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395) [0x811c25]
  4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
const&amp;)+0x43e) [0x82baae]
  5: (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na, mpl_::na, mpl_::na,
mpl
_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
, mpl_::na,
mpl_::na&gt;,(boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_ba
se const&amp;, void const*)+0xc0) [0x870c30]
  6: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_excepti
on_translator&gt;::process_queued_events()+0xfb) [0x8560db]
  7: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_excepti
on_translator&gt;::process_event(boost::statechart::event_base const&amp;)+0x1e)
[0x8562ae]
  8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
  9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
  10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
  11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
  12: (()+0x7e9a) [0x7fa52c469e9a]
  13: (clone()+0x6d) [0x7fa52ae3431d]
  NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed
to
interpret this.


   -128&gt; 2014-10-29 13:51:23.049357 7fa50ed9d700  5 osd.21 pg_epoch: 104445
pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] exit
Started/Primary/Active/Recovered 0.000084 0 0.000000
   -127&gt; 2014-10-29 13:51:23.049392 7fa50ed9d700  5 osd.21 pg_epoch: 104445
pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] enter
Started/Primary/Active/Clean
   -126&gt; 2014-10-29 13:51:23.049582 7fa50ed9d700  1 -- 172.30.5.2:6838/22980
--&gt; 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
0x30d41c00 con 0x26c6ac60


Thank you!
--
Tuan
HaNoi-VietNam




_______________________________________________
ceph-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>



</pre>
      </blockquote>
    </blockquote>
    <br class="">
  </div>

_______________________________________________<br class="">ceph-users mailing list<br class=""><a href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" class="">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br class="">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br class=""></div></blockquote></div><br class=""></body></html>
--Apple-Mail=_9FFE3050-2B63-40B0-BC33-D3E0EAF230C3--

--===============1311961738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1311961738==--
