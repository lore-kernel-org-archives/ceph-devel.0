From: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Subject: Re: Ceph Giant not fixed RepllicatedPG:NotStrimming?
Date: Fri, 31 Oct 2014 22:54:25 +0700
Message-ID: <5453B0B1.1020404@vccloud.vn>
References: <5451FD06.5030000@vccloud.vn>
	<alpine.DEB.2.00.1410300801090.27022@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0447449395=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410300801090.27022-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is a multi-part message in MIME format.
--===============0447449395==
Content-Type: multipart/alternative;
 boundary="------------000003030502040701080501"

This is a multi-part message in MIME format.
--------------000003030502040701080501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sage Weil

Thank for your repling. Yes, I'm using Ceph v.0.86,
I report some related bugs, Hope you help me,

2014-10-31 15:34:52.927965 7f85efb6b700  0 osd.21 104744 do_command r=0
2014-10-31 15:34:53.105533 7f85f036c700 -1 *** Caught signal 
(Segmentation fault) **
  in thread 7f85f036c700
*ceph version 0.86-106-g6f8524e (*6f8524ef7673ab4448de2e0ff76638deaf03cae8)
  1: /usr/bin/ceph-osd() [0x9b6655]
  2: (()+0xfcb0) [0x7f8615726cb0]
  3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
  4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim 
const&)+0x43e) [0x82baae]
  5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects, 
ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, 
mpl_::na, mpl_::na, mpl_::na, mpl_::na>, 
(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_base 
const&, void const*)+0xc0) [0x870c30]
  6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer, 
ReplicatedPG::NotTrimming, std::allocator<void>, 
boost::statechart::null_exception_translator>::process_queued_events()+0xfb) 
[0x8560db]
  7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer, 
ReplicatedPG::NotTrimming, std::allocator<void>, 
boost::statechart::null_exception_translator>::process_event(boost::statechart::event_base 
const&)+0x1e) [0x8562ae]
  8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
  9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
  10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
  11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
  12: (()+0x7e9a) [0x7f861571ee9a]
  13: (clone()+0x6d) [0x7f86140e931d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

  -9523> 2014-10-31 15:34:45.571962 7f85e3ee0700  5 -- op tracker -- 
seq: 6937, time: 2014-10-31 15:34:45.531887, event: header_read, op: 
MOSDPGPus
h(*6.749 *104744 
[*PushOp(d2106749/rbd_data.a2e6185b9a8ef8.0000000000000803/head//6, 
version: 104736'7736506, data_included: [*0~4194304], data_size:
4194304, omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, 
recovery_info: 
ObjectRecoveryInfo(d2106749/rbd_data.a2e6185b9a8ef8.0000000000
000803/head//6@104736'7736506, copy_subset: [0~4194304], clone_subset: 
{}), after_progress: ObjectRecoveryProgress(!first, data_recovered_to:41943
04, data_complete:true, omap_recovered_to:, omap_complete:true), 
before_progress: ObjectRecoveryProgress(first, data_recovered_to:0, 
data_complete
:false, omap_recovered_to:, 
omap_complete:false)),PushOp(60940749/rbd_data.3435875ff78f67.0000000000001408/head//6, 
version: 104736'7736579, data_
included: [0~335360], data_size: 335360, omap_header_size: 0, 
omap_entries_size: 0, attrset_size: 2, recovery_info: 
ObjectRecoveryInfo(60940749/rb
d_data.3435875ff78f67.0000000000001408/head//6@104736'7736579, 
copy_subset: [0~335360], clone_subset: {}), after_progress: 
ObjectRecoveryProgress(
!first, data_recovered_to:335360, data_complete:true, 
omap_recovered_to:, omap_complete:true), before_progress: 
ObjectRecoveryProgress(first, data
_recovered_to:0, data_complete:false, omap_recovered_to:, 
omap_complete:false)),PushOp(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6, 
v
ersion: 104736'7736866, data_included: [0~4194304], data_size: 4194304, 
omap_header_size: 0, omap_entries_size: 0, attrset_size: 2, recovery_info:
  ObjectRecoveryInfo(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6@104736'7736866, copy_subset: [0~4194304], clone_subset: {}), after_pr
ogress: ObjectRecoveryProgress(!first, data_recovered_to:4194304, 
data_complete:true, omap_recovered_to:, omap_complete:true), 
before_progress: Ob
jectRecoveryProgress(first, data_recovered_to:0, data_complete:false, 
omap_recovered_to:, omap_complete:false))])

  -6933> 2014-10-31 15:34tha7.611229 7f85f737a700  5 osd.21 pg_epoch: 
104744 pg[*6.749*( v 104744'7741801 (104665'7732106,104744'7741801] lb 
14886749/rbd_data.3955b9640616f2.000000000000f5e2/head//6 
local-les=104661 n=1780 ec=164 les/c 104742/104735 104740/104741/103210) 
[74,112,21]/[74,112] r=-1 lpr=104741 pi=64005-104740/278 luod=0'0 
crt=104744'7741798 active+remapped] enter 
*Started/ReplicaActive/RepNotRecovering*

I think having some missing objects, I can't start one osd  that above 
objects be pushed to that osd. Ceph'versions are slower 0.86 then appear 
this bug?
Should I upgrade to Giant o resolve this bug?,


Thank you,
--
Tuan
HaNoi-VietNam

On 10/30/2014 10:02 PM, Sage Weil wrote:
> On Thu, 30 Oct 2014, Ta Ba Tuan wrote:
>> Hi Everyone,
>>
>> I upgraded Ceph to Giant by installing *tar.gz package, but appeared some
>> errors related Object Trimming or Snap Trimming:
>> I think having some missing objects and be not recovered.
> Note that this isn't giant, which is 0.87, but something a few weeks
> older.  There were a few bugs fixed in this code, but we can't tell if
> this was one of them without the log leading up to this message, which
> should include either a failed assertion message or segmentation fault or
> similar.
>
> Thanks!
> sage
>
>
>>   ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
>>   1: /usr/bin/ceph-osd() [0x9b6655]
>>   2: (()+0xfcb0) [0x7fa52c471cb0]
>>   3: (ReplicatedPG::trim_object(hobject_t const&)+0x395) [0x811c25]
>>   4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
>> const&)+0x43e) [0x82baae]
>>   5: (boost::statechart::simple_state<ReplicatedPG::TrimmingObjects,
>> ReplicatedPG::SnapTrimmer, boost::mpl::list<mpl_::na, mpl_::na, mpl_::na,
>> mpl
>> _::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
>> mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
>> , mpl_::na, mpl_::na>,(boost::statechart::history_mode)0>::react_impl(boost::statechart::event_ba
>> se const&, void const*)+0xc0) [0x870c30]
>>   6: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>> ReplicatedPG::NotTrimming, std::allocator<void>,
>> boost::statechart::null_excepti
>> on_translator>::process_queued_events()+0xfb) [0x8560db]
>>   7: (boost::statechart::state_machine<ReplicatedPG::SnapTrimmer,
>> ReplicatedPG::NotTrimming, std::allocator<void>,
>> boost::statechart::null_excepti
>> on_translator>::process_event(boost::statechart::event_base const&)+0x1e)
>> [0x8562ae]
>>   8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
>>   9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
>>   10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
>>   11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
>>   12: (()+0x7e9a) [0x7fa52c469e9a]
>>   13: (clone()+0x6d) [0x7fa52ae3431d]
>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to
>> interpret this.
>>
>>
>>    -128> 2014-10-29 13:51:23.049357 7fa50ed9d700  5 osd.21 pg_epoch: 104445
>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
>> n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
>> lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
>> active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] exit
>> Started/Primary/Active/Recovered 0.000084 0 0.000000
>>    -127> 2014-10-29 13:51:23.049392 7fa50ed9d700  5 osd.21 pg_epoch: 104445
>> pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
>> n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
>> lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
>> active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] enter
>> Started/Primary/Active/Clean
>>    -126> 2014-10-29 13:51:23.049582 7fa50ed9d700  1 -- 172.30.5.2:6838/22980
>> --> 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
>> 0x30d41c00 con 0x26c6ac60
>>
>>
>> Thank you!
>> --
>> Tuan
>> HaNoi-VietNam
>>
>>


--------------000003030502040701080501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Sage Weil<br>
      <br>
      Thank for your repling. Yes, I'm using Ceph v.0.86, <br>
      I report some related bugs, Hope you help me,<br>
      <br>
      <small>2014-10-31 15:34:52.927965 7f85efb6b700&nbsp; 0 osd.21 104744
        do_command r=0 <br>
        2014-10-31 15:34:53.105533 7f85f036c700 -1 *** Caught signal
        (Segmentation fault) **<br>
        &nbsp;in thread 7f85f036c700<br>
      </small><small>&nbsp;<b>ceph version 0.86-106-g6f8524e (</b>6f8524ef7673ab4448de2e0ff76638deaf03cae8)<br>
        &nbsp;1: /usr/bin/ceph-osd() [0x9b6655]<br>
        &nbsp;2: (()+0xfcb0) [0x7f8615726cb0]<br>
        &nbsp;3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395)
        [0x811c25]<br>
        &nbsp;4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
        const&amp;)+0x43e) [0x82baae]<br>
        &nbsp;5:
        (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
        ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na,
        mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
        mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
        mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
        mpl_::na&gt;,
        (boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_base
        const&amp;, void const*)+0xc0) [0x870c30]<br>
        &nbsp;6:
        (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
        ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
        boost::statechart::null_exception_translator&gt;::process_queued_events()+0xfb)
        [0x8560db]<br>
        &nbsp;7:
        (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
        ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
        boost::statechart::null_exception_translator&gt;::process_event(boost::statechart::event_base
        const&amp;)+0x1e) [0x8562ae]<br>
        &nbsp;8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]<br>
        &nbsp;9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]<br>
        &nbsp;10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e)
        [0xa8fa0e]<br>
        &nbsp;11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]<br>
        &nbsp;12: (()+0x7e9a) [0x7f861571ee9a]<br>
        &nbsp;13: (clone()+0x6d) [0x7f86140e931d]<br>
        &nbsp;NOTE: a copy of the executable, or `objdump -rdS
        &lt;executable&gt;` is needed to interpret this.<br>
      </small><small><br>
        &nbsp;-9523&gt; 2014-10-31 15:34:45.571962 7f85e3ee0700&nbsp; 5 -- op
        tracker -- seq: 6937, time: 2014-10-31 15:34:45.531887, event:
        header_read, op: MOSDPGPus<br>
        h(<b>6.749 </b>104744 [<b>PushOp(d2106749/rbd_data.a2e6185b9a8ef8.0000000000000803/head//6,
          version: 104736'7736506, data_included: [</b>0~4194304],
        data_size: <br>
        4194304, omap_header_size: 0, omap_entries_size: 0,
        attrset_size: 2, recovery_info:
        ObjectRecoveryInfo(d2106749/rbd_data.a2e6185b9a8ef8.0000000000<br>
        000803/head//6@104736'7736506, copy_subset: [0~4194304],
        clone_subset: {}), after_progress:
        ObjectRecoveryProgress(!first, data_recovered_to:41943<br>
        04, data_complete:true, omap_recovered_to:, omap_complete:true),
        before_progress: ObjectRecoveryProgress(first,
        data_recovered_to:0, data_complete<br>
        :false, omap_recovered_to:,
        omap_complete:false)),PushOp(60940749/rbd_data.3435875ff78f67.0000000000001408/head//6,
        version: 104736'7736579, data_<br>
        included: [0~335360], data_size: 335360, omap_header_size: 0,
        omap_entries_size: 0, attrset_size: 2, recovery_info:
        ObjectRecoveryInfo(60940749/rb<br>
        d_data.3435875ff78f67.0000000000001408/head//6@104736'7736579,
        copy_subset: [0~335360], clone_subset: {}), after_progress:
        ObjectRecoveryProgress(<br>
        !first, data_recovered_to:335360, data_complete:true,
        omap_recovered_to:, omap_complete:true), before_progress:
        ObjectRecoveryProgress(first, data<br>
        _recovered_to:0, data_complete:false, omap_recovered_to:,
        omap_complete:false)),PushOp(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6,
        v<br>
        ersion: 104736'7736866, data_included: [0~4194304], data_size:
        4194304, omap_header_size: 0, omap_entries_size: 0,
        attrset_size: 2, recovery_info:<br>
        &nbsp;ObjectRecoveryInfo(922b1749/rbd_data.1c3dade6cdc10.00000000000014c5/head//6@104736'7736866,
        copy_subset: [0~4194304], clone_subset: {}), after_pr<br>
        ogress: ObjectRecoveryProgress(!first,
        data_recovered_to:4194304, data_complete:true,
        omap_recovered_to:, omap_complete:true), before_progress: Ob<br>
        jectRecoveryProgress(first, data_recovered_to:0,
        data_complete:false, omap_recovered_to:, omap_complete:false))])<br>
        <br>
        &nbsp;-6933&gt; 2014-10-31 15:34tha7.611229 7f85f737a700&nbsp; 5 osd.21
        pg_epoch: 104744 pg[<b>6.749</b>( v 104744'7741801
        (104665'7732106,104744'7741801] lb
        14886749/rbd_data.3955b9640616f2.000000000000f5e2/head//6
        local-les=104661 n=1780 ec=164 les/c 104742/104735
        104740/104741/103210) [74,112,21]/[74,112] r=-1 lpr=104741
        pi=64005-104740/278 luod=0'0 crt=104744'7741798 active+remapped]
        enter <b>Started/ReplicaActive/RepNotRecovering</b></small><br>
      <br>
      I think having some missing objects, I can't start one osd&nbsp; that
      above objects be pushed to that osd. Ceph'versions are slower 0.86
      then appear this bug?<br>
      Should I upgrade to Giant o resolve this bug?, <br>
      <br>
      <br>
      Thank you,<br>
      --<br>
      Tuan<br>
      HaNoi-VietNam<br>
      <br>
      On 10/30/2014 10:02 PM, Sage Weil wrote:<br>
    </div>
    <blockquote
      cite="mid:alpine.DEB.2.00.1410300801090.27022-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org"
      type="cite">
      <pre wrap="">On Thu, 30 Oct 2014, Ta Ba Tuan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">
Hi Everyone,

I upgraded Ceph to Giant by installing *tar.gz package, but appeared some
errors related Object Trimming or Snap Trimming:
I think having some missing objects and be not recovered.
</pre>
      </blockquote>
      <pre wrap="">
Note that this isn't giant, which is 0.87, but something a few weeks 
older.  There were a few bugs fixed in this code, but we can't tell if 
this was one of them without the log leading up to this message, which 
should include either a failed assertion message or segmentation fault or 
similar.

Thanks!
sage


</pre>
      <blockquote type="cite">
        <pre wrap="">&nbsp;ceph version 0.86-106-g6f8524e (6f8524ef7673ab4448de2e0ff76638deaf03cae8)
&nbsp;1: /usr/bin/ceph-osd() [0x9b6655]
&nbsp;2: (()+0xfcb0) [0x7fa52c471cb0]
&nbsp;3: (ReplicatedPG::trim_object(hobject_t const&amp;)+0x395) [0x811c25]
&nbsp;4: (ReplicatedPG::TrimmingObjects::react(ReplicatedPG::SnapTrim
const&amp;)+0x43e) [0x82baae]
&nbsp;5: (boost::statechart::simple_state&lt;ReplicatedPG::TrimmingObjects,
ReplicatedPG::SnapTrimmer, boost::mpl::list&lt;mpl_::na, mpl_::na, mpl_::na,
mpl
_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na,
mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na, mpl_::na
, mpl_::na, mpl_::na&gt;,(boost::statechart::history_mode)0&gt;::react_impl(boost::statechart::event_ba
se const&amp;, void const*)+0xc0) [0x870c30]
&nbsp;6: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_excepti
on_translator&gt;::process_queued_events()+0xfb) [0x8560db]
&nbsp;7: (boost::statechart::state_machine&lt;ReplicatedPG::SnapTrimmer,
ReplicatedPG::NotTrimming, std::allocator&lt;void&gt;,
boost::statechart::null_excepti
on_translator&gt;::process_event(boost::statechart::event_base const&amp;)+0x1e)
[0x8562ae]
&nbsp;8: (ReplicatedPG::snap_trimmer()+0x4f8) [0x7d5f48]
&nbsp;9: (OSD::SnapTrimWQ::_process(PG*)+0x14) [0x6739b4]
&nbsp;10: (ThreadPool::worker(ThreadPool::WorkThread*)+0x48e) [0xa8fa0e]
&nbsp;11: (ThreadPool::WorkThread::entry()+0x10) [0xa927a0]
&nbsp;12: (()+0x7e9a) [0x7fa52c469e9a]
&nbsp;13: (clone()+0x6d) [0x7fa52ae3431d]
&nbsp;NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed to
interpret this.


&nbsp; -128&gt; 2014-10-29 13:51:23.049357 7fa50ed9d700&nbsp; 5 osd.21 pg_epoch: 104445
pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] exit
Started/Primary/Active/Recovered 0.000084 0 0.000000
&nbsp; -127&gt; 2014-10-29 13:51:23.049392 7fa50ed9d700&nbsp; 5 osd.21 pg_epoch: 104445
pg[6.9d8( v 104445'7857889 (103730'7852406,104445'7857889] local-les=104444
n=4345 ec=164 les/c 104444/104272 104443/104443/104443) [21,93,49] r=0
lpr=104443 pi=103787-104442/16 crt=104442'7857887 mlcod 104445'7857888
active snaptrimq=[1907~1,1941~4,1946~1,19ef~2,19f2~1,19f4~3,19fa~5]] enter
Started/Primary/Active/Clean
&nbsp; -126&gt; 2014-10-29 13:51:23.049582 7fa50ed9d700&nbsp; 1 -- 172.30.5.2:6838/22980
--&gt; 172.30.5.4:6859/8884 -- pg_info(1 pgs e104445:6.9d8) v4 -- ?+0
0x30d41c00 con 0x26c6ac60


Thank you!
--
Tuan
HaNoi-VietNam


</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------000003030502040701080501--

--===============0447449395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0447449395==--
