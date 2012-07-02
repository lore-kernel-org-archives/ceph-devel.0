From: Gregory Farnum <greg@inktank.com>
Subject: Re: Should an OSD crash when journal device is out of space?
Date: Mon, 2 Jul 2012 12:49:14 -0700
Message-ID: <CAPYLRzjyCXG2NRYTAsFe3t8op7NrSkfzLykbC_wXoAd0KdFunA@mail.gmail.com>
References: <CACkq2mpgqYhxwRCCYCj+xUJmAgWvGqU0LGrQK4EQMZUaA4uyAA@mail.gmail.com>
	<CADXA5U1vdZQnWwQ8SF=5U9S4bwB5UuFM5Dw86May_37U43JnkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59583 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2GBTtQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 15:49:16 -0400
Received: by lbbgm6 with SMTP id gm6so8095733lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 12:49:14 -0700 (PDT)
In-Reply-To: <CADXA5U1vdZQnWwQ8SF=5U9S4bwB5UuFM5Dw86May_37U43JnkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>, Matthew Roy <imjustmatthew@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hey guys,
Thanks for the problem report. I've created an issue to track it at
http://tracker.newdream.net/issues/2687.
It looks like we just assume that if you're using a file, you've got
enough space for it. It shouldn't be a big deal to at least do some
startup checks which will fail gracefully.
-Greg

On Wed, Jun 20, 2012 at 1:57 PM, Matthew Roy <imjustmatthew@gmail.com> =
wrote:
> I hit this a couple times and wondered the same thing. Why does the
> OSD need to bail when it runs out of journal space?
>
> On Wed, Jun 20, 2012 at 3:56 PM, Travis Rhoden <trhoden@gmail.com> wr=
ote:
>> Not sure if this is a bug or not. =A0It was definitely user error --=
 but
>> since the OSD process bailed, figured I would report it.
>>
>> I had /tmpfs mounted with 2.5GB of space:
>>
>> tmpfs on /tmpfs type tmpfs (rw,size=3D2560m)
>>
>> Then I decided to increase my journal size to 5G, but forgot to
>> increase the limit on /tmpfs. =A0=3D)
>>
>> osd journal size =3D 5000
>>
>>
>> Predictably, things didn't go well when I ran a rados bench that
>> filled up the journal. =A0I'm not sure if such a case can be handled
>> more gracefully:
>>
>>
>> =A0 =A0-4> 2012-06-20 12:39:36.648773 7fc042a5f780 =A01 journal _ope=
n
>> /tmpfs/osd.2.journal fd 30: 5242880000 bytes, block size 4096 bytes,
>> directio =3D 0, aio =3D 0
>> =A0 =A0-3> 2012-06-20 12:42:23.179164 7fc02e1ad700 =A01
>> CephxAuthorizeHandler::verify_authorizer isvalid=3D1
>> =A0 =A0-2> 2012-06-20 12:42:46.643205 7fc0396cf700 -1 journal
>> FileJournal::write_bl : write_fd failed: (28) No space left on devic=
e
>> =A0 =A0-1> 2012-06-20 12:42:46.643245 7fc0396cf700 -1 journal
>> FileJournal::do_write: write_bl(pos=3D2678079488) failed
>> =A0 =A0 0> 2012-06-20 12:42:46.676991 7fc0396cf700 -1 os/FileJournal=
=2Ecc:
>> In function 'void FileJournal::do_write(ceph::bufferlist&)' thread
>> 7fc0396cf700 time 2012-06-20 12:42:46.643315
>> os/FileJournal.cc: 994: FAILED assert(0)
>>
>> =A0ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad=
372)
>> =A01: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
>> =A02: (FileJournal::write_thread_entry()+0x735) [0x659545]
>> =A03: (FileJournal::Writer::entry()+0xd) [0x5de41d]
>> =A04: (()+0x7e9a) [0x7fc042434e9a]
>> =A05: (clone()+0x6d) [0x7fc0409e94bd]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- end dump of recent events ---
>> 2012-06-20 12:42:46.693963 7fc0396cf700 -1 *** Caught signal (Aborte=
d) **
>> =A0in thread 7fc0396cf700
>>
>> =A0ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad=
372)
>> =A01: /usr/bin/ceph-osd() [0x6eb32a]
>> =A02: (()+0xfcb0) [0x7fc04243ccb0]
>> =A03: (gsignal()+0x35) [0x7fc04092d445]
>> =A04: (abort()+0x17b) [0x7fc040930bab]
>> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc04127b6=
9d]
>> =A06: (()+0xb5846) [0x7fc041279846]
>> =A07: (()+0xb5873) [0x7fc041279873]
>> =A08: (()+0xb596e) [0x7fc04127996e]
>> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x282) [0x79dd02]
>> =A010: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
>> =A011: (FileJournal::write_thread_entry()+0x735) [0x659545]
>> =A012: (FileJournal::Writer::entry()+0xd) [0x5de41d]
>> =A013: (()+0x7e9a) [0x7fc042434e9a]
>> =A014: (clone()+0x6d) [0x7fc0409e94bd]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- begin dump of recent events ---
>> =A0 =A0 0> 2012-06-20 12:42:46.693963 7fc0396cf700 -1 *** Caught sig=
nal
>> (Aborted) **
>> =A0in thread 7fc0396cf700
>>
>> =A0ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad=
372)
>> =A01: /usr/bin/ceph-osd() [0x6eb32a]
>> =A02: (()+0xfcb0) [0x7fc04243ccb0]
>> =A03: (gsignal()+0x35) [0x7fc04092d445]
>> =A04: (abort()+0x17b) [0x7fc040930bab]
>> =A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc04127b6=
9d]
>> =A06: (()+0xb5846) [0x7fc041279846]
>> =A07: (()+0xb5873) [0x7fc041279873]
>> =A08: (()+0xb596e) [0x7fc04127996e]
>> =A09: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x282) [0x79dd02]
>> =A010: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
>> =A011: (FileJournal::write_thread_entry()+0x735) [0x659545]
>> =A012: (FileJournal::Writer::entry()+0xd) [0x5de41d]
>> =A013: (()+0x7e9a) [0x7fc042434e9a]
>> =A014: (clone()+0x6d) [0x7fc0409e94bd]
>> =A0NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> needed to interpret this.
>>
>> --- end dump of recent events ---
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
