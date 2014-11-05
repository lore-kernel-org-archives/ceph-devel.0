From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Re: Ceph Giant not fixed RepllicatedPG:NotStrimming?
Date: Wed, 05 Nov 2014 14:59:15 +0700
Message-ID: <5459D8D3.3020004@vccloud.vn>
References: <5451FD06.5030000@vccloud.vn>
	<alpine.DEB.2.00.1410300801090.27022@cobra.newdream.net>
	<5453B0B1.1020404@vccloud.vn>
	<CA+4uBUbYPZzHhkkQaB5wS8E2-idnrsnJB21zfjA6akz7NHPrnA@mail.gmail.com>
	<54544395.4030504@vccloud.vn> <54570E5D.9050009@vccloud.vn>
	<CA+4uBUaEuB3OW-Q3Lup+bx7WRYZqvL9P594XR8UHYO-H5A+82g@mail.gmail.com>
	<5458964C.5070901@vccloud.vn>
	<927B4C33-2889-4D70-9309-BDD1495C2FF1@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1239757692=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <927B4C33-2889-4D70-9309-BDD1495C2FF1-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: David Zafman <dzafman-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============1239757692==
Content-Type: multipart/alternative;
 boundary="------------000301090707090802070000"

This is a multi-part message in MIME format.
--------------000301090707090802070000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

I re-uploaded entire log at http://123.30.41.138/ceph-osd.21.log

appear many many logs :|
2014-11-04 18:24:38.641529 7f0fda7ac780 15 read_log missing 
106395'4837671 (106395'4837670) modify 
5479e128/rbd_data.74ae9c3be03aff.0000000000000b01/head//6 by 
client.7912580.0:19413835 2014-11-04 15:06:55.874814 (have 106384'4836070)
2014-11-04 18:24:38.641581 7f0fda7ac780 15 
filestore(/var/lib/ceph/osd/cloud-21) getattr 
6.128_head/573c4128/rbd_data.75551c509c613c.0000000000000780/head//6 '_'
...

Thank you
--
Tuan
HaNoi-VietNam

On 11/05/2014 11:36 AM, David Zafman wrote:
>
> Can you upload the entire log file?
>
> David
>
>> On Nov 4, 2014, at 1:03 AM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org 
>> <mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>> wrote:
>>
>> Hi Sam,
>> I resend logs with debug options http://123.30.41.138/ceph-osd.21.log
>> (Sorry about my spam :D)
>>
>> I saw many missing objects :|
>>
>> 2014-11-04 15:26:02.205607 7f3ab11a8700 10 osd.21 pg_epoch: 106407 
>> pg[24.7d7( v 106407'491583 lc 106401'491579 
>> (105805'487042,106407'491583] loca
>> l-les=106403 n=179 ec=25000 les/c 106403/106390 106402/106402/106402) 
>> [21,28,4] r=0 lpr=106402 pi=106377-106401/4 rops=1 crt=106401'491581 
>> mlcod
>> 106393'491097 active+recovering+degraded m=2 snaptrimq=[306~1,312~1]] 
>> recover_primary 
>> 675ea7d7/*rbd_data.4930222ae8944a.0000000000000001/head//24 
>> 106401'491580 (missing) (missing head) (recovering) (recovering head)*
>> 2014-11-04 15:26:02.205642 7f3ab11a8700 10 osd.21 pg_epoch: 106407 
>> pg[24.7d7( v 106407'491583 lc 106401'491579 
>> (105805'487042,106407'491583] local-les=106403 n=179 ec=25000 les/c 
>> 106403/106390 106402/106402/106402) [21,28,4] r=0 lpr=106402 
>> pi=106377-106401/4 rops=1 crt=106401'491581 mlcod 106393'491097 
>> active+recovering+degraded m=2 snaptrimq=[306~1,312~1]] 
>> recover_primary 
>> d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24 
>> 106401'491581 (missing) (missing head)
>> 2014-11-04 15:26:02.237994 7f3ab29ab700 10 osd.21 pg_epoch: 106407 
>> pg[24.7d7( v 106407'491583 lc 106401'491579 
>> (105805'487042,106407'491583] local-les=106403 n=179 ec=25000 les/c 
>> 106403/106390 106402/106402/106402) [21,28,4] r=0 lpr=106402 
>> pi=106377-106401/4 rops=2 crt=106401'491581 mlcod 106393'491097 
>> active+recovering+degraded m=2 snaptrimq=[306~1,312~1]] *got missing 
>> d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24 v 
>> 106401'491581*
>>
>> Thanks Sam and All,
>> --
>> Tuan
>> HaNoi-Vietnam
>>
>> On 11/04/2014 04:54 AM, Samuel Just wrote:
>>> Can you reproduce with
>>>
>>> debug osd = 20
>>> debug filestore = 20
>>> debug ms = 1
>>>
>>> In the [osd] section of that osd's ceph.conf?
>>> -Sam
>>>
>>> On Sun, Nov 2, 2014 at 9:10 PM, Ta Ba Tuan<tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>  wrote:
>>>> Hi Sage, Samuel & All,
>>>>
>>>> I upgraded to GAINT, but still appearing that errors |:
>>>> I'm trying on deleting  related objects/volumes, but very hard to verify
>>>> missing objects :(.
>>>>
>>>> Guide me to resolve it, please! (I send attached detail log).
>>>>
>>>> 2014-11-03 11:37:57.730820 7f28fb812700  0 osd.21 105950 do_command r=0
>>>> 2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal (Segmentation
>>>> fault) **
>>>>   in thread 7f28fc013700
>>>>
>>>>   ceph version 0.87-6-gdba7def (dba7defc623474ad17263c9fccfec60fe7a439f0)
>>>>   1: /usr/bin/ceph-osd() [0x9b6725]
>>>>   2: (()+0xfcb0) [0x7f291fc2acb0]
>>>>   3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811b55]
>>>>   4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>>> const&)+0x43e) [0x82b9be]
>>>>   5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na>,
>>>> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
>>>> const&, void const*)+0xc0) [0x870ce0]
>>>>   6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_exception_translator>::process_queued_events()+0xfb)
>>>> [0x85618b]
>>>>   7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
>>>> const&)+0x1e) [0x85633e]
>>>>   8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5ef8]
>>>>   9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x673ab4]
>>>>   10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fade]
>>>>   11: (ThreadPool::WorkThread::entry()+0x10) [0xa92870]
>>>>   12: (()+0x7e9a) [0x7f291fc22e9a]
>>>>   13: (clone()+0x6d) [0x7f291e5ed31d]
>>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>>>> interpret this.
>>>>
>>>>   -9993> 2014-11-03 11:37:47.689335 7f28fc814700  1 -- 172.30.5.2:6803/7606
>>>> --> 172.30.5.1:6886/3511 -- MOSDPGPull(6.58e 105950
>>>> [PullOp(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head//6,
>>>> recovery_info:
>>>> ObjectRecoveryInfo(87f82d8e/rbd_data.45e62779c99cf1.00000000000022b5/head//6@105938'11622009,
>>>> copy_subset: [0~18446744073709551615], clone_subset: {}), recovery_progress:
>>>> ObjectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
>>>> omap_recovered_to:, omap_complete:false))]) v2 -- ?+0 0x26c59000 con
>>>> 0x22fbc420
>>>> ....
>>>>      -2> 2014-11-03 11:37:57.853585 7f2902820700  5 osd.21 pg_epoch: 105950
>>>> pg[24.9e4( v 105946'113392 lc 105946'113391 (103622'109598,105946'113392]
>>>> local-les=1
>>>> 05948 n=88 ec=25000 les/c 105948/105943 105947/105947/105947) [21,112,33]
>>>> r=0 lpr=105947 pi=105933-105946/4 crt=105946'113392 lcod 0'0 mlcod 0'0
>>>> active+recovery
>>>> _wait+degraded m=1 snaptrimq=[303~3,307~1]] enter
>>>> Started/Primary/Active/Recovering
>>>>      -1> 2014-11-03 11:37:57.853735 7f28fc814700  1 -- 172.30.5.2:6803/7606
>>>> --> 172.30.5.9:6806/24552 -- MOSDPGPull(24.9e4 105950
>>>> [PullOp(5abb99e4/rbd_data.5dd32
>>>> f2ae8944a.0000000000000165/head//24, recovery_info:
>>>> ObjectRecoveryInfo(5abb99e4/rbd_data.5dd32f2ae8944a.0000000000000165/head//24@105946'113392,
>>>> copy_subset: [0
>>>> ~18446744073709551615], clone_subset: {}), recovery_progress:
>>>> ObjectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
>>>> omap_recovered_to:, omap_c
>>>> omplete:false))]) v2 -- ?+0 0x229e7e00 con 0x22fb7000
>>>>       0> 2014-11-03 11:37:57.856578 7f28fc013700 -1 *** Caught signal
>>>> (Segmentation fault) **
>>>>
>>>> Thanks!
>>>> --
>>>> Tuan
>>>> HaNoi-VietNam
>>>>
>>>>
>>>>
>>>>
>>>> On 11/01/2014 09:21 AM, Ta Ba Tuan wrote:
>>>>
>>>> Hi Samuel and Sage,
>>>>
>>>> I will upgrde to Giant soon, Thank you so much.
>>>>
>>>> --
>>>> Tuan
>>>> HaNoi-VietNam
>>>>
>>>> On 11/01/2014 01:10 AM, Samuel Just wrote:
>>>>
>>>> You should start by upgrading to giant, many many bug fixes went in
>>>> between .86 and giant.
>>>> -Sam
>>>>
>>>> On Fri, Oct 31, 2014 at 8:54 AM, Ta Ba Tuan<tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>  wrote:
>>>>
>>>> Hi Sage Weil
>>>>
>>>> Thank for your repling. Yes, I'm using Ceph v.0.86,
>>>> I report some related bugs, Hope you help me,
>>>>
>>>> 2014-10-31 15:34:52.927965 7f85efb6b700  0 osd.21 104744 do_command r=0
>>>> 2014-10-31 15:34:53.105533 7f85f036c700 -1 *** Caught signal (Segmentation
>>>> fault) **
>>>>    in thread 7f85f036c700
>>>>    ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
>>>>    1: /usr/bin/ceph-osd() [0x9b6655]
>>>>    2: (()+0xfcb0) [0x7f8615726cb0]
>>>>    3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
>>>>    4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>>> const&)+0x43e) [0x82baae]
>>>>    5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na>,
>>>> (boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base
>>>> const&, void const*)+0xc0) [0x870c30]
>>>>    6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_exception_translator>::process_queued_events()+0xfb)
>>>> [0x8560db]
>>>>    7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base
>>>> const&)+0x1e) [0x8562ae]
>>>>    8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
>>>>    9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
>>>>    10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
>>>>    11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
>>>>    12: (()+0x7e9a) [0x7f861571ee9a]
>>>>    13: (clone()+0x6d) [0x7f86140e931d]
>>>>    NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
>>>> to
>>>> interpret this.
>>>>
>>>>    -9523> 2014-10-31 15:34:45.571962 7f85e3ee0700  5 -- op tracker -- seq:
>>>> 6937, time: 2014-10-31 15:34:45.531887, event: header_read, op: MOSDPGPus
>>>> h(6.749 104744
>>>> [PushOp(d2106749/rbd_data.a2e6185b9a8ef8.0000000000000803/head//6, version:
>>>> 104736'7736506, data_included: [0~4194304], data_size:
>>>> 4194304, omap_header_size: 0, omap_entries_size: 0, attrset_size: 2,
>>>> recovery_info:
>>>> ObjectRecoveryInfo(d2106749/rbd_data.a2e6185b9a8ef8.0000000000
>>>> 000803/head//6@104736'7736506, copy_subset: [0~4194304], clone_subset: {}),
>>>> after_progress: ObjectRecoveryProgress(!first, data_recovered_to:41943
>>>> 04, data_complete:true, omap_recovered_to:, omap_complete:true),
>>>> before_progress: ObjectRecoveryProgress(first, data_recovered_to:0,
>>>> data_complete
>>>> :false, omap_recovered_to:,
>>>> omap_complete:false)),PushOp(60940749/rbd_data.3435875ff78f67.0000000000001408/head//6,
>>>> version: 104736'7736579, data_
>>>> included: [0~335360], data_size: 335360, omap_header_size: 0,
>>>> omap_entries_size: 0, attrset_size: 2, recovery_info:
>>>> ObjectRecoveryInfo(60940749/rb
>>>> d_data.3435875ff78f67.0000000000001408/head//6@104736'7736579, copy_subset:
>>>> [0~335360], clone_subset: {}), after_progress: ObjectRecoveryProgress(
>>>> !first, data_recovered_to:335360, data_complete:true, omap_recovered_to:,
>>>> omap_complete:true), before_progress: ObjectRecoveryProgress(first, data
>>>> _recovered_to:0, data_complete:false, omap_recovered_to:,
>>>> omap_complete:false)),PushOp(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6,
>>>> v
>>>> ersion: 104736'7736866, data_included: [0~4194304], data_size: 4194304,
>>>> omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info:
>>>>
>>>> ObjectRecoveryInfo(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6@104736'7736866,
>>>> copy_subset: [0~4194304], clone_subset: {}), after_pr
>>>> ogress: ObjectRecoveryProgress(!first, data_recovered_to:4194304,
>>>> data_complete:true, omap_recovered_to:, omap_complete:true),
>>>> before_progress: Ob
>>>> jectRecoveryProgress(first, data_recovered_to:0, data_complete:false,
>>>> omap_recovered_to:, omap_complete:false))])
>>>>
>>>>    -6933> 2014-10-31 15:34tha7.611229 7f85f737a700  5 osd.21 pg_epoch: 104744
>>>> pg[6.749( v 104744'7741801 (104665'7732106,104744'7741801] lb
>>>> 14886749/rbd_data.3955b9640616f2.000000000000f5e2/head//6 local-les=104661
>>>> n=1780 ec=164 les/c 104742/104735 104740/104741/103210) [74,112,21]/[74,112]
>>>> r=-1 lpr=104741 pi=64005-104740/278 luod=0'0 crt=104744'7741798
>>>> active+remapped] enter Started/ReplicaActive/RepNotRecovering
>>>>
>>>> I think having some missing objects, I can't start one osd  that above
>>>> objects be pushed to that osd. Ceph'versions are slower 0.86 then appear
>>>> this bug?
>>>> Should I upgrade to Giant o resolve this bug?,
>>>>
>>>>
>>>> Thank you,
>>>> --
>>>> Tuan
>>>> HaNoi-VietNam
>>>>
>>>>
>>>> On 10/30/2014 10:02 PM, Sage Weil wrote:
>>>>
>>>> On Thu, 30 Oct 2014, Ta Ba Tuan wrote:
>>>>
>>>> Hi Everyone,
>>>>
>>>> I upgraded Ceph to Giant by installing *tar.gz package, but appeared some
>>>> errors related Object Trimming or Snap Trimming:
>>>> I think having some missing objects and be not recovered.
>>>>
>>>> Note that this isn't giant, which is 0.87, but something a few weeks
>>>> older.  There were a few bugs fixed in this code, but we can't tell if
>>>> this was one of them without the log leading up to this message, which
>>>> should include either a failed assertion message or segmentation fault or
>>>> similar.
>>>>
>>>> Thanks!
>>>> sage
>>>>
>>>>
>>>>    ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
>>>>    1: /usr/bin/ceph-osd() [0x9b6655]
>>>>    2: (()+0xfcb0) [0x7fa52c471cb0]
>>>>    3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
>>>>    4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>>>> const&)+0x43e) [0x82baae]
>>>>    5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>>>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
>>>> mpl
>>>> _::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>>>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
>>>> , mpl_::na,
>>>> mpl_::na>,(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_ba
>>>> se const&, void const*)+0xc0) [0x870c30]
>>>>    6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_excepti
>>>> on_translator>::process_queued_events()+0xfb) [0x8560db]
>>>>    7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>>>> ReplicatedPG::NotTrimming, std::allocator<void>,
>>>> boost::statechart::null_excepti
>>>> on_translator>::process_event(boost::statechart::event_base const&)+0x1e)
>>>> [0x8562ae]
>>>>    8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
>>>>    9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
>>>>    10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
>>>>    11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
>>>>    12: (()+0x7e9a) [0x7fa52c469e9a]
>>>>    13: (clone()+0x6d) [0x7fa52ae3431d]
>>>>    NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed
>>>> to
>>>> interpret this.
>>>>
>>>>
>>>>     -128> 2014-10-29 13:51:23.049357 7fa50ed9d700  5 osd.21 pg_epoch: 104445
>>>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
>>>> n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
>>>> lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
>>>> active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] exit
>>>> Started/Primary/Active/Recovered 0.000084 0 0.000000
>>>>     -127> 2014-10-29 13:51:23.049392 7fa50ed9d700  5 osd.21 pg_epoch: 104445
>>>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
>>>> n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
>>>> lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
>>>> active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] enter
>>>> Started/Primary/Active/Clean
>>>>     -126> 2014-10-29 13:51:23.049582 7fa50ed9d700  1 -- 172.30.5.2:6838/22980
>>>> --> 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
>>>> 0x30d41c00 con 0x26c6ac60
>>>>
>>>>
>>>> Thank you!
>>>> --
>>>> Tuan
>>>> HaNoi-VietNam
>>>>
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>>
>>>>
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>


--------------000301090707090802070000
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi David,<br>
      <br>
      I re-uploaded entire log at&nbsp; <a moz-do-not-send="true"
        class="moz-txt-link-freetext"
        href="http://123.30.41.138/ceph-osd.21.log">http://123.30.41.138/ceph-osd.21.log</a>&nbsp;&nbsp;
      <br>
      <br>
      appear many many logs :|<br>
      <small>2014-11-04 18:24:38.641529 7f0fda7ac780 15 read_log&nbsp;
        missing 106395'4837671 (106395'4837670) modify&nbsp;&nbsp;
        5479e128/rbd_data.74ae9c3be03aff.0000000000000b01/head//6 by
        client.7912580.0:19413835 2014-11-04 15:06:55.874814 (have
        106384'4836070)<br>
        2014-11-04 18:24:38.641581 7f0fda7ac780 15
        filestore(/var/lib/ceph/osd/cloud-21) getattr
        6.128_head/573c4128/rbd_data.75551c509c613c.0000000000000780/head//6
        '_'</small><br>
      ...<br>
      <br>
      Thank you<br>
      --<br>
      Tuan<br>
      HaNoi-VietNam<br>
      <br>
      On 11/05/2014 11:36 AM, David Zafman wrote:<br>
    </div>
    <blockquote
      cite="mid:927B4C33-2889-4D70-9309-BDD1495C2FF1-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div class=""><br class="">
      </div>
      <div class="">Can you upload the entire log file?</div>
      <div class=""><br class="">
      </div>
      <div class="">David</div>
      <br class="">
      <div>
        <blockquote type="cite" class="">
          <div class="">On Nov 4, 2014, at 1:03 AM, Ta Ba Tuan &lt;<a
              moz-do-not-send="true" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org"
              class="">tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org</a>&gt; wrote:</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <meta content="text/html; charset=ISO-8859-1"
              http-equiv="Content-Type" class="">
            <div bgcolor="#FFFFFF" text="#000000" class="">
              <div class="moz-cite-prefix">Hi Sam,<br class="">
                I resend logs with debug options&nbsp; <a
                  moz-do-not-send="true" class="moz-txt-link-freetext"
                  href="http://123.30.41.138/ceph-osd.21.log">http://123.30.41.138/ceph-osd.21.log</a>&nbsp;
                <br class="">
                (Sorry about my spam :D)<br class="">
                <br class="">
                I saw many missing objects :|<br class="">
                <br class="">
                <small class="">2014-11-04 15:26:02.205607 7f3ab11a8700
                  10 osd.21 pg_epoch: 106407 pg[24.7d7( v 106407'491583
                  lc 106401'491579 (105805'487042,106407'491583] loca<br
                    class="">
                  l-les=106403 n=179 ec=25000 les/c 106403/106390
                  106402/106402/106402) [21,28,4] r=0 lpr=106402
                  pi=106377-106401/4 rops=1 crt=106401'491581 mlcod <br
                    class="">
                  106393'491097 active+recovering+degraded m=2
                  snaptrimq=[306~1,312~1]] recover_primary 675ea7d7/<b
                    class="">rbd_data.4930222ae8944a.0000000000000001/head//24

                    106401'491580 (missing) (missing head) (recovering)
                    (recovering head)</b><br class="">
                  2014-11-04 15:26:02.205642 7f3ab11a8700 10 osd.21
                  pg_epoch: 106407 pg[24.7d7( v 106407'491583 lc
                  106401'491579 (105805'487042,106407'491583]
                  local-les=106403 n=179 ec=25000 les/c 106403/106390
                  106402/106402/106402) [21,28,4] r=0 lpr=106402
                  pi=106377-106401/4 rops=1 crt=106401'491581 mlcod
                  106393'491097 active+recovering+degraded m=2
                  snaptrimq=[306~1,312~1]] recover_primary
                  d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24
                  106401'491581 (missing) (missing head)<br class="">
                  2014-11-04 15:26:02.237994 7f3ab29ab700 10 osd.21
                  pg_epoch: 106407 pg[24.7d7( v 106407'491583 lc
                  106401'491579 (105805'487042,106407'491583]
                  local-les=106403 n=179 ec=25000 les/c 106403/106390
                  106402/106402/106402) [21,28,4] r=0 lpr=106402
                  pi=106377-106401/4 rops=2 crt=106401'491581 mlcod
                  106393'491097 active+recovering+degraded m=2
                  snaptrimq=[306~1,312~1]] <b class="">got missing
                    d4d4bfd7/rbd_data.c6964d30a28220.000000000000035f/head//24
                    v 106401'491581</b><br class="">
                </small><br class="">
                Thanks Sam and All,<br class="">
                --<br class="">
                Tuan<br class="">
                HaNoi-Vietnam<br class="">
                <br class="">
                On 11/04/2014 04:54 AM, Samuel Just wrote:<br class="">
              </div>
              <blockquote
cite="mid:CA+4uBUaEuB3OW-Q3Lup+bx7WRYZqvL9P594XR8UHYO-H5A+82g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
                type="cite" class="">
                <pre class="" wrap="">Can you reproduce with

debug osd = 20
debug filestore = 20
debug ms = 1

In the [osd] section of that osd's ceph.conf?
-Sam

On Sun, Nov 2, 2014 at 9:10 PM, Ta Ba Tuan <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:
</pre>
                <blockquote type="cite" class="">
                  <pre class="" wrap="">Hi Sage, Samuel &amp; All,

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

On Fri, Oct 31, 2014 at 8:54 AM, Ta Ba Tuan <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org">&lt;tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org&gt;</a> wrote:

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
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a>



</pre>
                </blockquote>
              </blockquote>
              <br class="">
            </div>
            _______________________________________________<br class="">
            ceph-users mailing list<br class="">
            <a moz-do-not-send="true"
              href="mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" class="">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br
              class="">
            <a class="moz-txt-link-freetext" href="http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br
              class="">
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
    <br>
  </body>
</html>

--------------000301090707090802070000--

--===============1239757692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1239757692==--
