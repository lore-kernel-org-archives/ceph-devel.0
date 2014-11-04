From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: The Async messenger benchmark with latest master
Date: Tue, 4 Nov 2014 10:29:46 +0100
Message-ID: <CACJqLybamCVBX33NgqtZ76_VH0orXE0-xJmZEhJo07=s2z-CQA@mail.gmail.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2822F3C7@SACMBXIP02.sdcorp.global.sandisk.com>
	<611a8971-3ad7-4f5c-9a11-d2be5aade2df@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33204 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbaKDJ3s convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 04:29:48 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so13069665wgg.33
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 01:29:47 -0800 (PST)
In-Reply-To: <611a8971-3ad7-4f5c-9a11-d2be5aade2df@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>

could you run "ceph -w --debug-ms=3D10/10" ?

On Tue, Nov 4, 2014 at 5:29 AM, Alexandre DERUMIER <aderumier@odiso.com=
> wrote:
> Hi,
>
> I'm try to test the async messenger (ms_type =3D async) with last mas=
ter,
> and I have an assert on line 1046 of AsyncConnection.cc.
> (I don't have tried yet with previous builds)
>
> no tuning in ceph.conf, only the ms_type =3D async.
>
>
>
>
> #ceph -w
> msg/async/AsyncConnection.cc: In function 'int AsyncConnection::_proc=
ess_connection()' thread 7fd396201700 time 2014-11-04 05:22:10.878492
> msg/async/AsyncConnection.cc: 1046: FAILED assert(m)
>  ceph version 0.87-600-g25ca92d (25ca92d7ff5cc326d77c1c3f687ece0718f0=
2db9)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char con=
st*)+0x72) [0x7fd39a1efb52]
>  2: (AsyncConnection::_process_connection()+0x40e9) [0x7fd39a307ac9]
>  3: (AsyncConnection::process()+0xcb) [0x7fd39a3082ab]
>  4: (EventCenter::process_events(int)+0x567) [0x7fd39a321a27]
>  5: (Worker::entry()+0x7f) [0x7fd39a30f1cf]
>  6: (()+0x6b50) [0x7fd39ea11b50]
>  7: (clone()+0x6d) [0x7fd39debb7bd]
>
>
> Any idea ?
>
> ----- Mail original -----
>
> De: "Somnath Roy" <Somnath.Roy@sandisk.com>
> =C3=80: "Sage Weil" <sage@newdream.net>, "Haomai Wang" <haomaiwang@gm=
ail.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 22 Octobre 2014 22:34:34
> Objet: RE: The Async messenger benchmark with latest master
>
> Sage,
> So, with krbd as client, should I use 'ms_type =3D random' in the clu=
ster side to test Async messenger in the cluster side?
> BTW, what this option does ? It will pick Async first and fall back t=
o old messenger in case any problem ?
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Wednesday, October 22, 2014 10:53 AM
> To: Haomai Wang
> Cc: Somnath Roy; ceph-devel@vger.kernel.org
> Subject: Re: The Async messenger benchmark with latest master
>
> On Thu, 23 Oct 2014, Haomai Wang wrote:
>> It should be but I'm not convinced of the current impl of
>> AsyncMessenger. It's possible that exists some corner situations whi=
ch
>> may break
>
> The 'ms_type =3D random' option we added should give us some confidne=
ce that this is true (by doing QA on mixes old both messenger implement=
ations).
>
> sage
>
>
>>
>> On Thu, Oct 23, 2014 at 1:18 AM, Somnath Roy <Somnath.Roy@sandisk.co=
m> wrote:
>> > Thanks Haomai, I will try this branch out.
>> > BTW, will it be compatible with the client which is not using this=
 async messenger for example krbd ?
>> >
>> > Regards
>> > Somnath
>> >
>> > -----Original Message-----
>> > From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> > Sent: Wednesday, October 22, 2014 10:02 AM
>> > To: Somnath Roy
>> > Cc: ceph-devel@vger.kernel.org
>> > Subject: Re: The Async messenger benchmark with latest master
>> >
>> > ms_type =3D async is needed to add [global] section in ceph.conf
>> >
>> > No other options are needed
>> >
>> > On Thu, Oct 23, 2014 at 12:02 AM, Somnath Roy <Somnath.Roy@sandisk=
=2Ecom> wrote:
>> >> Hi Haomai/Sage,
>> >>
>> >> I just figured it out that Async messenger is not yet in master.
>> >> So, I didn't really test the async messenger :-(
>> >>
>> >> I saw here is the pull request.
>> >>
>> >> https://github.com/ceph/ceph/pull/2768
>> >>
>> >> I want to test this out and I have some questions regarding this.
>> >>
>> >> 1. The branch I should test out is the following, right ?
>> >>
>> >> https://github.com/ceph/ceph/tree/wip-msgr
>> >>
>> >> 2. Will Async messenger by default enabled ? OR I need to add som=
e config option for that ?
>> >>
>> >> 3. Other than ms_event_op_threads , is there any tunable paramete=
r I should be playing with ?
>> >>
>> >> Thanks & Regards
>> >> Somnath
>> >>
>> >> -----Original Message-----
>> >> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> >> Sent: Saturday, October 18, 2014 10:15 PM
>> >> To: Somnath Roy
>> >> Cc: ceph-devel@vger.kernel.org
>> >> Subject: Re: The Async messenger benchmark with latest master
>> >>
>> >> Thanks Somnath!
>> >>
>> >> I have another simple performance test for async messenger:
>> >>
>> >> For 4k object read, master branch used 4.46s to complete tests, a=
sync Messenger used 3.14s For 4k object write, master branch used 10.6s=
 to complete, async Messenger used 6.6s!!
>> >>
>> >> Detailf results see below, 4k object read is a simple ceph client
>> >> program which will read 5000 objects and 4k object write will wri=
te
>> >> 5000 objects.
>> >> I increased "ms_event_op_threads" to 10 compared to the default v=
alue is 2.
>> >> Maybe Somnath can do it and tests again, I think we can get more =
improvements for your tests.
>> >>
>> >> Master Branch(6fa686c8c42937dd069591f16de92e954d8ed34d):
>> >>
>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &=
&
>> >> sleep 3; done
>> >>
>> >> Fri Oct 17 17:10:39 UTC 2014
>> >>
>> >> Used Time:4.461581
>> >>
>> >> Fri Oct 17 17:10:44 UTC 2014
>> >>
>> >> Used Time:4.388572
>> >>
>> >> Fri Oct 17 17:10:48 UTC 2014
>> >>
>> >> Used Time:4.448157
>> >>
>> >> [root@ceph-test src]#
>> >>
>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 =
&&
>> >> sleep 3; doneFri Oct 17 17:11:23 UTC 2014
>> >>
>> >> Used Time:10.638783
>> >>
>> >> Fri Oct 17 17:11:33 UTC 2014
>> >>
>> >> Used Time:10.793231
>> >>
>> >> Fri Oct 17 17:11:44 UTC 2014
>> >>
>> >> Used Time:10.908003
>> >>
>> >>
>> >> Master Branch with AsyncMessenger:
>> >>
>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>> >> ~/08.rados_read_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 &=
&
>> >> sleep 3; done
>> >>
>> >> Sun Oct 19 06:01:50 UTC 2014
>> >>
>> >> Used Time:3.155506
>> >>
>> >> Sun Oct 19 06:01:53 UTC 2014
>> >>
>> >> Used Time:3.134961
>> >>
>> >> Sun Oct 19 06:01:56 UTC 2014
>> >>
>> >> Used Time:3.135814
>> >>
>> >> [root@ceph-test src]# for i in `seq 1 3`; do date &&
>> >> ~/01.rados_write_4k_for_each_object /etc/ceph/ceph.conf rbd 5000 =
&&
>> >> sleep 3; done
>> >>
>> >> Sun Oct 19 06:02:03 UTC 2014
>> >>
>> >> Used Time:6.536319
>> >>
>> >> Sun Oct 19 06:02:10 UTC 2014
>> >>
>> >> Used Time:6.648738
>> >>
>> >> Sun Oct 19 06:02:16 UTC 2014
>> >>
>> >> Used Time:6.585156
>> >>
>> >> On Sat, Oct 18, 2014 at 4:37 AM, Somnath Roy <Somnath.Roy@sandisk=
=2Ecom> wrote:
>> >>> Hi Sage/Haomai,
>> >>>
>> >>> I did some 4K Random Read benchmarking with latest master having=
 Async messenger changes and result looks promising.
>> >>>
>> >>> My configuration:
>> >>> ---------------------
>> >>>
>> >>> 1 node, 8 SSDs, 8OSDs, 3 pools , each has 3 images. ~2000 Pg
>> >>> cluster wide Cpu : Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz, du=
al socket, HT enabled, 40 cores.
>> >>> Used krbd as client.
>> >>>
>> >>>
>> >>> 1 clinet node with 3 rbd images on 3 different pools:
>> >>> ----------------------------------------------------------------=
--
>> >>> -
>> >>> Master :
>> >>> ---------
>> >>>
>> >>> ~203k IOPS, ~90% latencies within 4msec, total read : ~5.2TB
>> >>>
>> >>> lat (usec) : 4=3D0.01%, 10=3D0.01%, 50=3D0.01%, 100=3D0.01%, 250=
=3D0.03%
>> >>> lat (usec) : 500=3D0.86%, 750=3D3.72%, 1000=3D7.19%
>> >>> lat (msec) : 2=3D39.17%, 4=3D41.45%, 10=3D7.26%, 20=3D0.24%, 50=3D=
0.06%
>> >>> lat (msec) : 100=3D0.03%, 250=3D0.01%, 500=3D0.01%
>> >>>
>> >>> cpu: ~1-2 % idle
>> >>>
>> >>> Giant:
>> >>> ------
>> >>>
>> >>> ~196k IOPS, ~89-90% latencies within 4msec, total read : ~5.3TB
>> >>>
>> >>> lat (usec) : 250=3D0.01%, 500=3D0.51%, 750=3D2.71%, 1000=3D6.03%
>> >>> lat (msec) : 2=3D34.32%, 4=3D45.74%, 10=3D10.46%, 20=3D0.21%, 50=
=3D0.02%
>> >>> lat (msec) : 100=3D0.01%, 250=3D0.01%
>> >>>
>> >>> cpu: ~2% idle
>> >>>
>> >>> 2 clients with 3 rbd images each on 3 different pools:
>> >>> ----------------------------------------------------------------=
--
>> >>> -
>> >>>
>> >>> Master :
>> >>> ---------
>> >>>
>> >>> ~207K iops, ~70% latencies within 4msec, Total read: ~5.99 TB
>> >>>
>> >>> lat (usec) : 250=3D0.03%, 500=3D0.63%, 750=3D2.67%, 1000=3D5.21%
>> >>> lat (msec) : 2=3D25.12%, 4=3D36.19%, 10=3D24.80%, 20=3D3.16%, 50=
=3D1.34%
>> >>> lat (msec) : 100=3D0.66%, 250=3D0.18%, 500=3D0.01%
>> >>>
>> >>> cpu: ~0-1 % idle
>> >>>
>> >>> Giant:
>> >>> --------
>> >>> ~199K iops, ~64% latencies within 4msec, Total read: ~5.94 TB
>> >>>
>> >>> lat (usec) : 250=3D0.01%, 500=3D0.25%, 750=3D1.47%, 1000=3D3.45%
>> >>> lat (msec) : 2=3D21.22%, 4=3D36.69%, 10=3D30.63%, 20=3D4.28%, 50=
=3D1.70%
>> >>> lat (msec) : 100=3D0.28%, 250=3D0.02%, 500=3D0.01%
>> >>>
>> >>> cpu: ~1% idle
>> >>>
>> >>>
>> >>> So, in summary the master with Async messenger has improved both=
 in iops and latency.
>> >>>
>> >>> Thanks & Regards
>> >>> Somnath
>> >>>
>> >>> ________________________________
>> >>>
>> >>> PLEASE NOTE: The information contained in this electronic mail m=
essage is intended only for the use of the designated recipient(s) name=
d above. If the reader of this message is not the intended recipient, y=
ou are hereby notified that you have received this message in error and=
 that any review, dissemination, distribution, or copying of this messa=
ge is strictly prohibited. If you have received this communication in e=
rror, please notify the sender by telephone or e-mail (as shown above) =
immediately and destroy any and all copies of this message in your poss=
ession (whether hard copies or electronically stored copies).
>> >>>
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel"
>> >>> in the body of a message to majordomo@vger.kernel.org More
>> >>> majordomo info at http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> >>
>> >> --
>> >> Best Regards,
>> >>
>> >> Wheat
>> >
>> >
>> >
>> > --
>> > Best Regards,
>> >
>> > Wheat
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
