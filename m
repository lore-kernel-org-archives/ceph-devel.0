From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: OSD crash
Date: Fri, 27 May 2011 12:18:27 -0700
Message-ID: <BANLkTinQmX5HnzaxQE11Mst9Pjei7j90FA@mail.gmail.com>
References: <4DDEEC7C.8060800@ufm.su>
	<BANLkTimxRbM95_LMJwAa+oUwj-HAePJM+Q@mail.gmail.com>
	<4DDFD44E.8070305@ufm.su>
	<BANLkTinGoEpm3C22HuPN2dH8wsVWPuAFgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55325 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab1E0TS3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 15:18:29 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 675E7C27A
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 12:18:29 -0700 (PDT)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id E6DA2C070
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 12:18:28 -0700 (PDT)
Received: by ewy4 with SMTP id 4so739979ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 12:18:27 -0700 (PDT)
In-Reply-To: <BANLkTinGoEpm3C22HuPN2dH8wsVWPuAFgA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Can you check out the recoverywq_fix branch and see if that prevents
this issue? Or just apply the patch I've included below. :)
-Greg

diff --git a/src/osd/OSD.cc b/src/osd/OSD.cc
index 2224e67..41c09d6 100644
--- a/src/osd/OSD.cc
+++ b/src/osd/OSD.cc
@@ -4789,11 +4789,17 @@ void OSD::do_recovery(PG *pg)
        do_queries(query_map);
       else {
        dout(10) << "do_recovery  no luck, giving up on this pg for
now" << dendl;
+       recovery_wq.lock();
        pg->recovery_item.remove_myself();      // sigh...
+       recovery_wq.unlock();
+
       }
     }
-    else if (started < max)
+    else if (started < max) {
+      recovery_wq.lock();
       pg->recovery_item.remove_myself();
+      recovery_wq.unlock();
+    }

     pg->unlock();
   }


On Fri, May 27, 2011 at 9:49 AM, Gregory Farnum <gregf@hq.newdream.net>=
 wrote:
> Okay, one of us should have a patch for you later today to try out;
> the only cause I can come up with seems unlikely but there aren't man=
y
> options so it should be pretty simple. :)
> I opened a tracker issue for it: http://tracker.newdream.net/issues/1=
116
> -Greg
>
> On Fri, May 27, 2011 at 9:41 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
>> On 05/27/2011 06:16 PM, Gregory Farnum wrote:
>>>
>>> This is an interesting one -- the invariant that assert is checking
>>> isn't too complicated (that the object lives on the RecoveryWQ's
>>> queue) and seems to hold everywhere the RecoveryWQ is called. And t=
he
>>> functions modifying the queue are always called under the workqueue
>>> lock, and do maintenance if the xlist::item is on a different list.
>>> Which makes me think that the problem must be from conflating the
>>> RecoveryWQ lock and the PG lock in the few places that modify the
>>> PG::recovery_item directly, rather than via RecoveryWQ functions.
>>> Anybody more familiar than me with this have ideas?
>>> Fyodor, based on the time stamps and output you've given us, I assu=
me
>>> you don't have more detailed logs?
>>> -Greg
>>
>> Greg, i got this crash again.
>> Let me tell you the configuration and what is happening:
>> Configuration:
>> 6 osd servers. 4G RAM, 4*1T hdd (mdadmed to raid0), 2*1G etherchanne=
l
>> ethernet, Ubuntu server 11.04/64 =A0with kernel 2.6.39 (hand compile=
d)
>> mon+mds server 24G RAM, the same os.
>>
>> On each OSD Journal placed on 1G tempfs. OSD data - on xfs in this c=
ase.
>>
>> Configuration file:
>>
>> [global]
>> =A0 =A0 =A0 =A0max open files =3D 131072
>> =A0 =A0 =A0 =A0log file =3D /var/log/ceph/$name.log
>> =A0 =A0 =A0 =A0pid file =3D /var/run/ceph/$name.pid
>>
>> [mon]
>> =A0 =A0 =A0 =A0mon data =3D /mfs/mon$id
>>
>> [mon.0]
>> =A0 =A0 =A0 =A0mon addr =A0=3D 10.5.51.230:6789
>>
>> [mds]
>> =A0 =A0 =A0 =A0keyring =3D /mfs/mds/keyring.$name
>>
>> [mds.0]
>> =A0 =A0 =A0 =A0host =3D mds0
>>
>>
>> [osd]
>> =A0 =A0 =A0 =A0osd data =3D /$name
>> =A0 =A0 =A0 =A0osd journal =3D /journal/$name
>> =A0 =A0 =A0 =A0osd journal size =3D 950
>> =A0 =A0 =A0 =A0journal dio =3D false
>>
>> [osd.0]
>> =A0 =A0 =A0 =A0host =3D osd0
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.10
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.140
>>
>> [osd.1]
>> =A0 =A0 =A0 =A0host =3D osd1
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.11
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.141
>>
>> [osd.2]
>> =A0 =A0 =A0 =A0host =3D osd2
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.12
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.142
>>
>> [osd.3]
>> =A0 =A0 =A0 =A0host =3D osd3
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.13
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.143
>>
>> [osd.4]
>> =A0 =A0 =A0 =A0host =3D osd4
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.14
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.144
>>
>> [osd.5]
>> =A0 =A0 =A0 =A0host =3D osd5
>> =A0 =A0 =A0 =A0cluster addr =3D 10.5.51.15
>> =A0 =A0 =A0 =A0public addr =3D 10.5.51.145
>>
>> What happening:
>> osd2 was crashed, rebooted, osd data and journal created from scratc=
h by
>> "cosd --mkfs -i 2 --monmap /tmp/monmap" and server started.
>> Additional - on osd2 enables "writeahaed", but I think it's not prin=
cipal in
>> this case.
>>
>> Well, server start rebalancing:
>>
>> 2011-05-27 15:12:49.323558 7f3b69de5740 ceph version 0.28.1.commit:
>> d66c6ca19bbde3c363b135b66072de44e67c6632. process: cosd. pid: 1694
>> 2011-05-27 15:12:49.325331 7f3b69de5740 filestore(/osd.2) mount FIEM=
AP ioctl
>> is NOT supported
>> 2011-05-27 15:12:49.325378 7f3b69de5740 filestore(/osd.2) mount did =
NOT
>> detect btrfs
>> 2011-05-27 15:12:49.325467 7f3b69de5740 filestore(/osd.2) mount foun=
d snaps
>> <>
>> 2011-05-27 15:12:49.325512 7f3b69de5740 filestore(/osd.2) mount: WRI=
TEAHEAD
>> journal mode explicitly enabled in conf
>> 2011-05-27 15:12:49.325526 7f3b69de5740 filestore(/osd.2) mount WARN=
ING: not
>> btrfs or ext3; data may be lost
>> 2011-05-27 15:12:49.325606 7f3b69de5740 journal _open /journal/osd.2=
 fd 11:
>> 996147200 bytes, block size 4096 bytes, directio =3D 0
>> 2011-05-27 15:12:49.325641 7f3b69de5740 journal read_entry 4096 : se=
q 1 203
>> bytes
>> 2011-05-27 15:12:49.325698 7f3b69de5740 journal _open /journal/osd.2=
 fd 11:
>> 996147200 bytes, block size 4096 bytes, directio =3D 0
>> 2011-05-27 15:12:49.544716 7f3b59656700 -- 10.5.51.12:6801/1694 >>
>> 10.5.51.14:6801/5070 pipe(0x1239d20 sd=3D27 pgs=3D0 cs=3D0 l=3D0).ac=
cept we reset
>> (peer sent cseq 2), sending RESETSESSION
>> 2011-05-27 15:12:49.544798 7f3b59c5c700 -- 10.5.51.12:6801/1694 >>
>> 10.5.51.13:6801/5165 pipe(0x104b950 sd=3D14 pgs=3D0 cs=3D0 l=3D0).ac=
cept we reset
>> (peer sent cseq 2), sending RESETSESSION
>> 2011-05-27 15:12:49.544864 7f3b59757700 -- 10.5.51.12:6801/1694 >>
>> 10.5.51.15:6801/1574 pipe(0x11e7cd0 sd=3D16 pgs=3D0 cs=3D0 l=3D0).ac=
cept we reset
>> (peer sent cseq 2), sending RESETSESSION
>> 2011-05-27 15:12:49.544909 7f3b59959700 -- 10.5.51.12:6801/1694 >>
>> 10.5.51.10:6801/6148 pipe(0x11d7d30 sd=3D15 pgs=3D0 cs=3D0 l=3D0).ac=
cept we reset
>> (peer sent cseq 2), sending RESETSESSION
>> 2011-05-27 15:13:23.015637 7f3b64579700 journal check_for_full at 66=
404352 :
>> JOURNAL FULL 66404352 >=3D 851967 (max_size 996147200 start 67256320=
)
>> 2011-05-27 15:13:25.586081 7f3b5dc6b700 journal throttle: waited for=
 bytes
>> 2011-05-27 15:13:25.601789 7f3b5d46a700 journal throttle: waited for=
 bytes
>>
>> [...] and after 2 hours:
>>
>> 2011-05-27 17:30:21.355034 7f3b64579700 journal check_for_full at 41=
5199232
>> : JOURNAL FULL 415199232 >=3D 778239 (max_size 996147200 start 41597=
7472)
>> 2011-05-27 17:30:23.441445 7f3b5d46a700 journal throttle: waited for=
 bytes
>> 2011-05-27 17:30:36.362877 7f3b64579700 journal check_for_full at 41=
4326784
>> : JOURNAL FULL 414326784 >=3D 872447 (max_size 996147200 start 41519=
9232)
>> 2011-05-27 17:30:38.391372 7f3b5d46a700 journal throttle: waited for=
 bytes
>> 2011-05-27 17:30:50.373936 7f3b64579700 journal check_for_full at 41=
4314496
>> : JOURNAL FULL 414314496 >=3D 12287 (max_size 996147200 start 414326=
784)
>> ./include/xlist.h: In function 'void xlist<T>::remove(xlist<T>::item=
*) [with
>> T =3D PG*]', in thread '0x7f3b5cc69700'
>> ./include/xlist.h: 107: FAILED assert(i->_list =3D=3D this)
>> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6=
632)
>> =A01: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
>> =A02: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
>> =A03: (ThreadPool::worker()+0x10a) [0x65799a]
>> =A04: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
>> =A05: (()+0x6d8c) [0x7f3b697b5d8c]
>> =A06: (clone()+0x6d) [0x7f3b6866804d]
>> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6=
632)
>> =A01: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
>> =A02: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
>> =A03: (ThreadPool::worker()+0x10a) [0x65799a]
>> =A04: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
>> =A05: (()+0x6d8c) [0x7f3b697b5d8c]
>> =A06: (clone()+0x6d) [0x7f3b6866804d]
>> *** Caught signal (Aborted) **
>> =A0in thread 0x7f3b5cc69700
>> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c6=
632)
>> =A01: /usr/bin/cosd() [0x6729f9]
>> =A02: (()+0xfc60) [0x7f3b697bec60]
>> =A03: (gsignal()+0x35) [0x7f3b685b5d05]
>> =A04: (abort()+0x186) [0x7f3b685b9ab6]
>> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f3b68e6c6=
dd]
>> =A06: (()+0xb9926) [0x7f3b68e6a926]
>> =A07: (()+0xb9953) [0x7f3b68e6a953]
>> =A08: (()+0xb9a5e) [0x7f3b68e6aa5e]
>> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x362) [0x655e32]
>> =A010: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
>> =A011: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
>> =A012: (ThreadPool::worker()+0x10a) [0x65799a]
>> =A013: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
>> =A014: (()+0x6d8c) [0x7f3b697b5d8c]
>> =A015: (clone()+0x6d) [0x7f3b6866804d]
>>
>> I.e. it's not "easy reproduced" bug. While I had less data in the cl=
uster -
>> I not seen this error.
>>
>> I think that I do not have enough space for "full" log for 2-3 hours=
=2E Sorry.
>>
>> WBR,
>> =A0 =A0Fyodor.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
