From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
Date: Mon, 14 Nov 2011 11:11:58 -0800
Message-ID: <CAF3hT9BZh8cFy+weYxuRSH+B36mf0z18ai4whqtcfyCAUPAu1Q@mail.gmail.com>
References: <4EC11FF2.1030109@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45665 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366Ab1KNTL7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 14:11:59 -0500
Received: by iage36 with SMTP id e36so7538165iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 11:11:59 -0800 (PST)
In-Reply-To: <4EC11FF2.1030109@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Do you have any other system state? (More logs, core dumps.)

Make a bug in the tracker either way so it doesn't get lost track of. :=
)
-Greg

On Mon, Nov 14, 2011 at 6:04 AM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi,
> today one of my ods died, the log is.
>
> sd/OSD.cc: In function 'void OSD::dequeue_op(PG*)', in thread '7faeb6=
139700'
> osd/OSD.cc: 5534: FAILED assert(pending_ops > 0)
> =A0ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9=
)
> =A01: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> =A02: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> =A03: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> =A04: (()+0x6d8c) [0x7faec4d12d8c]
> =A05: (clone()+0x6d) [0x7faec355404d]
> =A0ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9=
)
> =A01: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> =A02: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> =A03: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> =A04: (()+0x6d8c) [0x7faec4d12d8c]
> =A05: (clone()+0x6d) [0x7faec355404d]
> *** Caught signal (Aborted) **
> =A0in thread 7faeb6139700
> =A0ceph version 0.38 (commit:b600ec2ac7c0f2e508720f8e8bb87c3db15509b9=
)
> =A01: /usr/bin/ceph-osd() [0x5b8b52]
> =A02: (()+0xfc60) [0x7faec4d1bc60]
> =A03: (gsignal()+0x35) [0x7faec34a1d05]
> =A04: (abort()+0x186) [0x7faec34a5ab6]
> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7faec3d586d=
d]
> =A06: (()+0xb9926) [0x7faec3d56926]
> =A07: (()+0xb9953) [0x7faec3d56953]
> =A08: (()+0xb9a5e) [0x7faec3d56a5e]
> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x396) [0x5bddb6]
> =A010: (OSD::dequeue_op(PG*)+0x4bb) [0x55a4db]
> =A011: (ThreadPool::worker()+0x6e6) [0x5b7b16]
> =A012: (ThreadPool::WorkThread::entry()+0xd) [0x57398d]
> =A013: (()+0x6d8c) [0x7faec4d12d8c]
> =A014: (clone()+0x6d) [0x7faec355404d]
>
> Anything else needed to debug this?
>
> -martin
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
