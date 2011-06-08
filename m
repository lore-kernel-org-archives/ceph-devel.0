From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: libceph: osd0 down
Date: Tue, 7 Jun 2011 23:12:26 -0700
Message-ID: <BANLkTinc4PMMzw3CV_4-kkGjLk5B_ENbHw@mail.gmail.com>
References: <BANLkTim6cJxoxqXJaRhoca5HSmuad6p2SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46121 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab1FHGM2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2011 02:12:28 -0400
Received: by bwz15 with SMTP id 15so145979bwz.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jun 2011 23:12:27 -0700 (PDT)
In-Reply-To: <BANLkTim6cJxoxqXJaRhoca5HSmuad6p2SQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: biyan chen <riby.chen@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Jun 7, 2011 at 10:16 PM, biyan chen <riby.chen@gmail.com> wrote=
:
>
<snip>
> 2011-06-08 21:03:24.460849 7f57cc5f8710 FileStore: sync_entry timed
> out after 600 seconds.
> =A0ceph version 0.28.2 (commit:23242045db6b0ec87400441acbe0ea14eedbe6=
cc)
> 2011-06-08 21:03:24.460919 1: (SafeTimer::timer_thread()+0x35e) [0x61=
bbbe]
> 2011-06-08 21:03:24.460936 2: (SafeTimerThread::entry()+0xd) [0x61e76=
d]
> 2011-06-08 21:03:24.460947 3: /lib64/libpthread.so.0() [0x3f724077e1]
> 2011-06-08 21:03:24.460960 4: (clone()+0x6d) [0x3f718e153d]
> 2011-06-08 21:03:24.460971 *** Caught signal (Aborted) **
> =A0in thread 0x7f57cc5f8710
> =A0ceph version 0.28.2 (commit:23242045db6b0ec87400441acbe0ea14eedbe6=
cc)
> =A01: /usr/local/bin/cosd() [0x639d12]
> =A02: /lib64/libpthread.so.0() [0x3f7240f4c0]
> =A03: (gsignal()+0x35) [0x3f718329a5]
> =A04: (abort()+0x175) [0x3f71834185]
> =A05: (__assert_fail()+0xf5) [0x3f7182b935]
> =A06: (SyncEntryTimeout::finish(int)+0xf4) [0x5c2454]
> =A07: (SafeTimer::timer_thread()+0x35e) [0x61bbbe]
> =A08: (SafeTimerThread::entry()+0xd) [0x61e76d]
> =A09: /lib64/libpthread.so.0() [0x3f724077e1]
> =A010: (clone()+0x6d) [0x3f718e153d]
>
>
> Why did the osd dead?,

The osd committed suicide, giving up after waiting for 10 minutes for
the underlying file system to flush an operation. Might be that btrfs
(or any other filesystem you're using) died. Could it be that you have
some kernel oops in dmesg?

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
