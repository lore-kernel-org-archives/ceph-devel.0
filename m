From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: OSD crash
Date: Fri, 27 May 2011 08:16:37 -0700
Message-ID: <BANLkTimxRbM95_LMJwAa+oUwj-HAePJM+Q@mail.gmail.com>
References: <4DDEEC7C.8060800@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:41687 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab1E0PQk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 11:16:40 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DFFFCC516
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:16:39 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 66DE0C4FD
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:16:39 -0700 (PDT)
Received: by eyx24 with SMTP id 24so692771eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 08:16:37 -0700 (PDT)
In-Reply-To: <4DDEEC7C.8060800@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, Fyodor Ustinov <ufm@ufm.su>

This is an interesting one -- the invariant that assert is checking
isn't too complicated (that the object lives on the RecoveryWQ's
queue) and seems to hold everywhere the RecoveryWQ is called. And the
functions modifying the queue are always called under the workqueue
lock, and do maintenance if the xlist::item is on a different list.
Which makes me think that the problem must be from conflating the
RecoveryWQ lock and the PG lock in the few places that modify the
PG::recovery_item directly, rather than via RecoveryWQ functions.
Anybody more familiar than me with this have ideas?
=46yodor, based on the time stamps and output you've given us, I assume
you don't have more detailed logs?
-Greg

On Thu, May 26, 2011 at 5:12 PM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> 2011-05-27 02:35:22.046798 7fa8ff058700 journal check_for_full at 837=
623808
> : JOURNAL FULL 837623808 >=3D 147455 (max_size 996147200 start 837771=
264)
> 2011-05-27 02:35:23.479379 7fa8f7f49700 journal throttle: waited for =
bytes
> 2011-05-27 02:35:34.730418 7fa8ff058700 journal check_for_full at 836=
984832
> : JOURNAL FULL 836984832 >=3D 638975 (max_size 996147200 start 837623=
808)
> 2011-05-27 02:35:36.050384 7fa8f7f49700 journal throttle: waited for =
bytes
> 2011-05-27 02:35:47.226789 7fa8ff058700 journal check_for_full at 836=
882432
> : JOURNAL FULL 836882432 >=3D 102399 (max_size 996147200 start 836984=
832)
> 2011-05-27 02:35:48.937259 7fa8f874a700 journal throttle: waited for =
bytes
> 2011-05-27 02:35:59.985040 7fa8ff058700 journal check_for_full at 836=
685824
> : JOURNAL FULL 836685824 >=3D 196607 (max_size 996147200 start 836882=
432)
> 2011-05-27 02:36:01.654955 7fa8f874a700 journal throttle: waited for =
bytes
> 2011-05-27 02:36:12.362896 7fa8ff058700 journal check_for_full at 835=
723264
> : JOURNAL FULL 835723264 >=3D 962559 (max_size 996147200 start 836685=
824)
> 2011-05-27 02:36:14.375435 7fa8f7f49700 journal throttle: waited for =
bytes
> ./include/xlist.h: In function 'void xlist<T>::remove(xlist<T>::item*=
) [with
> T =3D PG*]', in thread '0x7fa8f7748700'
> ./include/xlist.h: 107: FAILED assert(i->_list =3D=3D this)
> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c66=
32)
> =A01: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
> =A02: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
> =A03: (ThreadPool::worker()+0x10a) [0x65799a]
> =A04: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
> =A05: (()+0x6d8c) [0x7fa904294d8c]
> =A06: (clone()+0x6d) [0x7fa90314704d]
> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c66=
32)
> =A01: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
> =A02: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
> =A03: (ThreadPool::worker()+0x10a) [0x65799a]
> =A04: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
> =A05: (()+0x6d8c) [0x7fa904294d8c]
> =A06: (clone()+0x6d) [0x7fa90314704d]
> *** Caught signal (Aborted) **
> =A0in thread 0x7fa8f7748700
> =A0ceph version 0.28.1 (commit:d66c6ca19bbde3c363b135b66072de44e67c66=
32)
> =A01: /usr/bin/cosd() [0x6729f9]
> =A02: (()+0xfc60) [0x7fa90429dc60]
> =A03: (gsignal()+0x35) [0x7fa903094d05]
> =A04: (abort()+0x186) [0x7fa903098ab6]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fa90394b6d=
d]
> =A06: (()+0xb9926) [0x7fa903949926]
> =A07: (()+0xb9953) [0x7fa903949953]
> =A08: (()+0xb9a5e) [0x7fa903949a5e]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x362) [0x655e32]
> =A010: (xlist<PG*>::pop_front()+0xbb) [0x54f28b]
> =A011: (OSD::RecoveryWQ::_dequeue()+0x73) [0x56bcc3]
> =A012: (ThreadPool::worker()+0x10a) [0x65799a]
> =A013: (ThreadPool::WorkThread::entry()+0xd) [0x548c8d]
> =A014: (()+0x6d8c) [0x7fa904294d8c]
> =A015: (clone()+0x6d) [0x7fa90314704d]
>
> WBR,
> =A0 =A0Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
