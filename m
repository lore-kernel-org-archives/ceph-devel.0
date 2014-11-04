From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: The Async messenger benchmark with latest master
Date: Tue, 4 Nov 2014 11:08:14 +0100
Message-ID: <CACJqLybDMFHG3tCtzn8EP_4Ka+Raad0Pb3KeLJ1=RUc=5CaJ3w@mail.gmail.com>
References: <CACJqLybamCVBX33NgqtZ76_VH0orXE0-xJmZEhJo07=s2z-CQA@mail.gmail.com>
	<ce257978-4a80-40de-856d-2c1fc721f2b5@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46355 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbaKDKIQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 05:08:16 -0500
Received: by mail-wg0-f42.google.com with SMTP id k14so13151078wgh.15
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 02:08:15 -0800 (PST)
In-Reply-To: <ce257978-4a80-40de-856d-2c1fc721f2b5@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

OK, I will solve it if free. It's a problem when one connection want
to replace existing connection for the same endpoint.

Thank you!


On Tue, Nov 4, 2014 at 10:41 AM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>could you run "ceph -w --debug-ms=3D10/10" ?
>
> Here the output.  (monitor ips are 10.11.1.27,10.11.1.28,10.11.1.29)
>
> # ceph -w --debug-ms=3D10/10
> 2014-11-04 10:38:16.155461 7fdf4414b700 10 EpollDriver.add_event add =
event to fd=3D4 mask=3D1
> 2014-11-04 10:38:16.155474 7fdf4414b700 10 Event create_file_event cr=
eate event fd=3D4 mask=3D1 now mask is 1
> 2014-11-04 10:38:16.155626 7fdf4414b700 10 EpollDriver.add_event add =
event to fd=3D7 mask=3D1
> 2014-11-04 10:38:16.155630 7fdf4414b700 10 Event create_file_event cr=
eate event fd=3D7 mask=3D1 now mask is 1
> 2014-11-04 10:38:16.155774 7fdf4414b700 10 -- :/0 ready :/0
> 2014-11-04 10:38:16.155783 7fdf4414b700  1  Processor -- start start
> 2014-11-04 10:38:16.155785 7fdf4414b700  1 -- :/0 start start
> 2014-11-04 10:38:16.155841 7fdf419e2700 10 --entry starting
> 2014-11-04 10:38:16.155834 7fdf411e1700 10 --entry starting
> 2014-11-04 10:38:16.155883 7fdf419e2700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.155899 7fdf411e1700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.156711 7fdf4414b700 10 -- :/1009064 create_connec=
t 10.11.1.29:6789/0, creating connection and registering
> 2014-11-04 10:38:16.156747 7fdf4414b700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D-1 :0 s=3DSTATE_NONE pgs=3D0 cs=3D0 l=3D1).=
_connect 0
> 2014-11-04 10:38:16.156761 7fdf4414b700  1 Event wakeup
> 2014-11-04 10:38:16.156774 7fdf4414b700 10 -- :/1009064 get_connectio=
n mon.2 10.11.1.29:6789/0 new 0x1f56090
> 2014-11-04 10:38:16.156793 7fdf4414b700  1 Event wakeup
> 2014-11-04 10:38:16.156812 7fdf4414b700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D-1 :0 s=3DSTATE_CONNECTING pgs=3D0 cs=3D0 l=
=3D1).send_message
> 2014-11-04 10:38:16.157084 7fdf419e2700 10 EpollDriver.add_event add =
event to fd=3D9 mask=3D1
> 2014-11-04 10:38:16.157106 7fdf419e2700 10 Event create_file_event cr=
eate event fd=3D9 mask=3D1 now mask is 1
> 2014-11-04 10:38:16.157136 7fdf419e2700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_BANNER pgs=3D=
0 cs=3D0 l=3D1).handle_write started.
> 2014-11-04 10:38:16.157199 7fdf419e2700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.157206 7fdf4414b700  1 Event wakeup
> 2014-11-04 10:38:16.157259 7fdf419e2700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_BANNER pgs=3D=
0 cs=3D0 l=3D1).handle_write started.
> 2014-11-04 10:38:16.157284 7fdf419e2700 10 EpollDriver.add_event add =
event to fd=3D9 mask=3D3
> 2014-11-04 10:38:16.157286 7fdf419e2700 10 Event create_file_event cr=
eate event fd=3D9 mask=3D2 now mask is 3
> 2014-11-04 10:38:16.157290 7fdf419e2700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.157306 7fdf419e2700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_BANNER pgs=3D=
0 cs=3D0 l=3D1)._process_connection get banner, ready to send banner
> 2014-11-04 10:38:16.157348 7fdf419e2700 10 -- :/1009064 >> 10.11.1.29=
:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_IDENTIFY_PEE=
R pgs=3D0 cs=3D0 l=3D1)._process_connection connect write banner done: =
10.11.1.29:6789/0
> 2014-11-04 10:38:16.157376 7fdf419e2700  1 -- 10.11.1.27:0/1009064 le=
arned_addr learned my addr 10.11.1.27:0/1009064
> 2014-11-04 10:38:16.157394 7fdf419e2700 10 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_SEND_C=
ONNECT_MSG pgs=3D0 cs=3D0 l=3D1)._process_connection connect sent my ad=
dr 10.11.1.27:0/1009064
> 2014-11-04 10:38:16.157415 7fdf419e2700 10 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_SEND_C=
ONNECT_MSG pgs=3D0 cs=3D0 l=3D1)._process_connection connect sending gs=
eq=3D1 cseq=3D0 proto=3D15
> 2014-11-04 10:38:16.157434 7fdf419e2700 10 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_C=
ONNECT_REPLY pgs=3D0 cs=3D0 l=3D1).handle_write started.
> 2014-11-04 10:38:16.157442 7fdf419e2700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.157446 7fdf419e2700 10 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_C=
ONNECT_REPLY pgs=3D0 cs=3D0 l=3D1).handle_write started.
> 2014-11-04 10:38:16.157451 7fdf419e2700 10 Event process_events wait =
second 30 usec 0
> 2014-11-04 10:38:16.157560 7fdf419e2700 10 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_C=
ONNECT_REPLY_AUTH pgs=3D0 cs=3D0 l=3D1).handle_connect_replygot CEPH_MS=
GR_TAG_SEQ, reading acked_seq and writing in_seq
> 2014-11-04 10:38:16.157580 7fdf419e2700  2 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_A=
CK_SEQ pgs=3D0 cs=3D0 l=3D1)._process_connection got newly_acked_seq 18=
446744073709551615 vs out_seq 0
> 2014-11-04 10:38:16.157591 7fdf419e2700  2 -- 10.11.1.27:0/1009064 >>=
 10.11.1.29:6789/0 conn(0x1f56090 sd=3D9 :0 s=3DSTATE_CONNECTING_WAIT_A=
CK_SEQ pgs=3D0 cs=3D0 l=3D1)._process_connection discarding previously =
sent 0 auth(proto 0 34 bytes epoch 0) v1
> msg/async/AsyncConnection.cc: In function 'int AsyncConnection::_proc=
ess_connection()' thread 7fdf419e2700 time 2014-11-04 10:38:16.157609
> msg/async/AsyncConnection.cc: 1046: FAILED assert(m)
>  ceph version 0.87-600-g25ca92d (25ca92d7ff5cc326d77c1c3f687ece0718f0=
2db9)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x72) [0x7fdf459d0b52]
>  2: (AsyncConnection::_process_connection()+0x40e9) [0x7fdf45ae8ac9]
>  3: (AsyncConnection::process()+0xcb) [0x7fdf45ae92ab]
>  4: (EventCenter::process_events(int)+0x567) [0x7fdf45b02a27]
>  5: (Worker::entry()+0x7f) [0x7fdf45af01cf]
>  6: (()+0x6b50) [0x7fdf4a1f2b50]
>  7: (clone()+0x6d) [0x7fdf4969c7bd]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is ne=
eded to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion=
'
> Abandon
> ----- Mail original -----
>
> De: "Haomai Wang" <haomaiwang@gmail.com>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Somnath Roy" <Somnath.Roy@sandisk.com>, ceph-devel@vger.kernel.o=
rg, "Sage Weil" <sage@newdream.net>
> Envoy=C3=A9: Mardi 4 Novembre 2014 10:29:46
> Objet: Re: The Async messenger benchmark with latest master
>
> could you run "ceph -w --debug-ms=3D10/10" ?
>
> On Tue, Nov 4, 2014 at 5:29 AM, Alexandre DERUMIER <aderumier@odiso.c=
om> wrote:
>> Hi,
>>
>> I'm try to test the async messenger (ms_type =3D async) with last ma=
ster,
>> and I have an assert on line 1046 of AsyncConnection.cc.
>> (I don't have tried yet with previous builds)
>>
>> no tuning in ceph.conf, only the ms_type =3D async.
>>
>>
>>
>>
>> #ceph -w
>> msg/async/AsyncConnection.cc: In function 'int AsyncConnection::_pro=
cess_connection()' thread 7fd396201700 time 2014-11-04 05:22:10.878492
>> msg/async/AsyncConnection.cc: 1046: FAILED assert(m)
>> ceph version 0.87-600-g25ca92d (25ca92d7ff5cc326d77c1c3f687ece0718f0=
2db9)
>> 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x72) [0x7fd39a1efb52]
>> 2: (AsyncConnection::_process_connection()+0x40e9) [0x7fd39a307ac9]
>> 3: (AsyncConnection::process()+0xcb) [0x7fd39a3082ab]
>> 4: (EventCenter::process_events(int)+0x567) [0x7fd39a321a27]
>> 5: (Worker::entry()+0x7f) [0x7fd39a30f1cf]
>> 6: (()+0x6b50) [0x7fd39ea11b50]
>> 7: (clone()+0x6d) [0x7fd39debb7bd]
>>
>>
>> Any idea ?
>>
>> ----- Mail original -----
>>
>> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
>> =C3=80: "Sage Weil" <sage@newdream.net>, "Haomai Wang" <haomaiwang@g=
mail.com>
>> Cc: ceph-devel@vger.kernel.org
>> Envoy=C3=A9: Mercredi 22 Octobre 2014 22:34:34
>> Objet: RE: The Async messenger benchmark with latest master
>>
>> Sage,
>> So, with krbd as client, should I use 'ms_type =3D random' in the cl=
uster side to test Async messenger in the cluster side?
>> BTW, what this option does ? It will pick Async first and fall back =
to old messenger in case any problem ?
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Wednesday, October 22, 2014 10:53 AM
>> To: Haomai Wang
>> Cc: Somnath Roy; ceph-devel@vger.kernel.org
>> Subject: Re: The Async messenger benchmark with latest master
>>
>> On Thu, 23 Oct 2014, Haomai Wang wrote:
>>> It should be but I'm not convinced of the current impl of
>>> AsyncMessenger. It's possible that exists some corner situations wh=
ich
>>> may break
>>
>> The 'ms_type =3D random' option we added should give us some confidn=
ece that this is true (by doing QA on mixes old both messenger implemen=
tations).
>>
>> sage
>>
>>
>>>
>>> On Thu, Oct 23, 2014 at 1:18 AM, Somnath Roy <Somnath.Roy@sandisk.c=
om> wrote:
>>> > Thanks Haomai, I will try this branch out.
>>> > BTW, will it be compatible with the client which is not using thi=
s async messenger for example krbd ?
>>> >
>>> > Regards
>>> > Somnath
>>> >
>>> > -----Original Message-----
>>> > From: Haomai Wang [mailto:haomaiwang@gmail.com]
>>> > Sent: Wednesday, October 22, 2014 10:02 AM
>>> > To: Somnath Roy
>>> > Cc: ceph-devel@vger.kernel.org
>>> > Subject: Re: The Async messenger benchmark with latest master
>>> >
>>> > ms_type =3D async is needed to add [global] section in ceph.conf
>>> >
>>> > No other options are needed
>>> >
>>> > On Thu, Oct 23, 2014 at 12:02 AM, Somnath Roy <Somnath.Roy@sandis=
k.com> wrote:
>>> >> Hi Haomai/Sage,
>>> >>
>>> >> I just figured it out that Async messenger is not yet in master.
>>> >> So, I didn't really test the async messenger :-(
>>> >>
>>> >> I saw here is the pull request.
>>> >>
>>> >> https://github.com/ceph/ceph/pull/2768
>>> >>
>>> >> I want to test this out and I have some questions regarding this=
=2E
>>> >>
>>> >> 1. The branch I should test out is the following, right ?
>>> >>
>>> >> https://github.com/ceph/ceph/tree/wip-msgr
>>> >>
>>> >> 2. Will Async messenger by default enabled ? OR I need to add so=
me config option for that ?
>>> >>
>>> >> 3. Other than ms_event_op_threads , is there any tunable paramet=
er I should be playing with ?
>>> >>
>>> >> Thanks & Regards
>>> >> Somnath
>>> >>
>>> >> -----Original Message-----
>>> >> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>>> >> Sent: Saturday, October 18, 2014 10:15 PM
>>> >> To: Somnath Roy
>>> >> Cc: ceph-devel@vger.kernel.org
>>> >> Subject: Re: The Async messenger benchmark with latest master
>>> >>
>>> >> Thanks Somnath!
>>> >>
>>> >> I have another simple performance test for async messenger:
>>> >>
>>> >> For 4k object read, master branch used 4.46s to complete tests, =
async Messenger used 3.14s For 4k object write, master branch used 10.6=
s to complete, async Messenger used 6.6s!!
>>> >>
>>> >> Detailf results see below, 4k object read is a simple ceph clien=
t
>>> >> program which will read 5000 objects and 4k object write will wr=
ite
>>> >> 5000 objects.
>>> >> I increased "ms_event_op_threads" to 10 compared to the default =
value is 2.
>>> >> Maybe Somnath can do it and tests again, I think we can get more=
 improvements for your tests.
>>> >>
>>> >> Master Branch(6fa686c8c42937dd069591f16de92e954d8ed34d):
>>> >>
>>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>>> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 =
&&
>>> >> sleep 3; done
>>> >>
>>> >> Fri Oct 17 17:10:39 UTC 2014
>>> >>
>>> >> Used Time:4.461581
>>> >>
>>> >> Fri Oct 17 17:10:44 UTC 2014
>>> >>
>>> >> Used Time:4.388572
>>> >>
>>> >> Fri Oct 17 17:10:48 UTC 2014
>>> >>
>>> >> Used Time:4.448157
>>> >>
>>> >> [root@ceph-test src]#
>>> >>
>>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>>> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000=
 &&
>>> >> sleep 3; doneFri Oct 17 17:11:23 UTC 2014
>>> >>
>>> >> Used Time:10.638783
>>> >>
>>> >> Fri Oct 17 17:11:33 UTC 2014
>>> >>
>>> >> Used Time:10.793231
>>> >>
>>> >> Fri Oct 17 17:11:44 UTC 2014
>>> >>
>>> >> Used Time:10.908003
>>> >>
>>> >>
>>> >> Master Branch with AsyncMessenger:
>>> >>
>>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>>> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 =
&&
>>> >> sleep 3; done
>>> >>
>>> >> Sun Oct 19 06:01:50 UTC 2014
>>> >>
>>> >> Used Time:3.155506
>>> >>
>>> >> Sun Oct 19 06:01:53 UTC 2014
>>> >>
>>> >> Used Time:3.134961
>>> >>
>>> >> Sun Oct 19 06:01:56 UTC 2014
>>> >>
>>> >> Used Time:3.135814
>>> >>
>>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>>> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000=
 &&
>>> >> sleep 3; done
>>> >>
>>> >> Sun Oct 19 06:02:03 UTC 2014
>>> >>
>>> >> Used Time:6.536319
>>> >>
>>> >> Sun Oct 19 06:02:10 UTC 2014
>>> >>
>>> >> Used Time:6.648738
>>> >>
>>> >> Sun Oct 19 06:02:16 UTC 2014
>>> >>
>>> >> Used Time:6.585156
>>> >>
>>> >> On Sat, Oct 18, 2014 at 4:37 AM, Somnath Roy <Somnath.Roy@sandis=
k.com> wrote:
>>> >>> Hi Sage/Haomai,
>>> >>>
>>> >>> I did some 4K Random Read benchmarking with latest master havin=
g Async messenger changes and result looks promising.
>>> >>>
>>> >>> My configuration:
>>> >>> ---------------------
>>> >>>
>>> >>> 1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg
>>> >>> cluster wide Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, d=
ual socket, HT enabled, 40 cores.
>>> >>> Used krbd as client.
>>> >>>
>>> >>>
>>> >>> 1 clinet node with 3 rbd images on 3 different pools:
>>> >>> ---------------------------------------------------------------=
---
>>> >>> -
>>> >>> Master :
>>> >>> ---------
>>> >>>
>>> >>> ~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB
>>> >>>
>>> >>> lat (usec) : 4=3D0.01%, 10=3D0.01%, 50=3D0.01%, 100=3D0.01%, 25=
0=3D0.03%
>>> >>> lat (usec) : 500=3D0.86%, 750=3D3.72%, 1000=3D7.19%
>>> >>> lat (msec) : 2=3D39.17%, 4=3D41.45%, 10=3D7.26%, 20=3D0.24%, 50=
=3D0.06%
>>> >>> lat (msec) : 100=3D0.03%, 250=3D0.01%, 500=3D0.01%
>>> >>>
>>> >>> cpu: ~1-2 % idle
>>> >>>
>>> >>> Giant:
>>> >>> ------
>>> >>>
>>> >>> ~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB
>>> >>>
>>> >>> lat (usec) : 250=3D0.01%, 500=3D0.51%, 750=3D2.71%, 1000=3D6.03=
%
>>> >>> lat (msec) : 2=3D34.32%, 4=3D45.74%, 10=3D10.46%, 20=3D0.21%, 5=
0=3D0.02%
>>> >>> lat (msec) : 100=3D0.01%, 250=3D0.01%
>>> >>>
>>> >>> cpu: ~2% idle
>>> >>>
>>> >>> 2 clients with 3 rbd images each on 3 different pools:
>>> >>> ---------------------------------------------------------------=
---
>>> >>> -
>>> >>>
>>> >>> Master :
>>> >>> ---------
>>> >>>
>>> >>> ~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB
>>> >>>
>>> >>> lat (usec) : 250=3D0.03%, 500=3D0.63%, 750=3D2.67%, 1000=3D5.21=
%
>>> >>> lat (msec) : 2=3D25.12%, 4=3D36.19%, 10=3D24.80%, 20=3D3.16%, 5=
0=3D1.34%
>>> >>> lat (msec) : 100=3D0.66%, 250=3D0.18%, 500=3D0.01%
>>> >>>
>>> >>> cpu: ~0-1 % idle
>>> >>>
>>> >>> Giant:
>>> >>> --------
>>> >>> ~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB
>>> >>>
>>> >>> lat (usec) : 250=3D0.01%, 500=3D0.25%, 750=3D1.47%, 1000=3D3.45=
%
>>> >>> lat (msec) : 2=3D21.22%, 4=3D36.69%, 10=3D30.63%, 20=3D4.28%, 5=
0=3D1.70%
>>> >>> lat (msec) : 100=3D0.28%, 250=3D0.02%, 500=3D0.01%
>>> >>>
>>> >>> cpu: ~1% idle
>>> >>>
>>> >>>
>>> >>> So, in summary the master with Async messenger has improved bot=
h in iops and latency.
>>> >>>
>>> >>> Thanks & Regards
>>> >>> Somnath
>>> >>>
>>> >>> ________________________________
>>> >>>
>>> >>> PLEASE NOTE: The information contained in this electronic mail =
message is intended only for the use of the designated recipient(s) nam=
ed above. If the reader of this message is not the intended recipient, =
you are hereby notified that you have received this message in error an=
d that any review, dissemination, distribution, or copying of this mess=
age is strictly prohibited. If you have received this communication in =
error, please notify the sender by telephone or e-mail (as shown above)=
 immediately and destroy any and all copies of this message in your pos=
session (whether hard copies or electronically stored copies).
>>> >>>
>>> >>> --
>>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
>>> >>> in the body of a message to majordomo@vger.kernel.org More
>>> >>> majordomo info at http://vger.kernel.org/majordomo-info.html
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Best Regards,
>>> >>
>>> >> Wheat
>>> >
>>> >
>>> >
>>> > --
>>> > Best Regards,
>>> >
>>> > Wheat
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards,
>
> Wheat



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
