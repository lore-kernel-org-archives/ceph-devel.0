From: Travis Rhoden <trhoden@gmail.com>
Subject: Should an OSD crash when journal device is out of space?
Date: Wed, 20 Jun 2012 15:56:35 -0400
Message-ID: <CACkq2mpgqYhxwRCCYCj+xUJmAgWvGqU0LGrQK4EQMZUaA4uyAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52013 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2FTT44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 15:56:56 -0400
Received: by bkcji2 with SMTP id ji2so6609489bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 12:56:55 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Not sure if this is a bug or not.  It was definitely user error -- but
since the OSD process bailed, figured I would report it.

I had /tmpfs mounted with 2.5GB of space:

tmpfs on /tmpfs type tmpfs (rw,size=2560m)

Then I decided to increase my journal size to 5G, but forgot to
increase the limit on /tmpfs.  =)

osd journal size = 5000


Predictably, things didn't go well when I ran a rados bench that
filled up the journal.  I'm not sure if such a case can be handled
more gracefully:


    -4> 2012-06-20 12:39:36.648773 7fc042a5f780  1 journal _open
/tmpfs/osd.2.journal fd 30: 5242880000 bytes, block size 4096 bytes,
directio = 0, aio = 0
    -3> 2012-06-20 12:42:23.179164 7fc02e1ad700  1
CephxAuthorizeHandler::verify_authorizer isvalid=1
    -2> 2012-06-20 12:42:46.643205 7fc0396cf700 -1 journal
FileJournal::write_bl : write_fd failed: (28) No space left on device
    -1> 2012-06-20 12:42:46.643245 7fc0396cf700 -1 journal
FileJournal::do_write: write_bl(pos=2678079488) failed
     0> 2012-06-20 12:42:46.676991 7fc0396cf700 -1 os/FileJournal.cc:
In function 'void FileJournal::do_write(ceph::bufferlist&)' thread
7fc0396cf700 time 2012-06-20 12:42:46.643315
os/FileJournal.cc: 994: FAILED assert(0)

 ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
 1: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
 2: (FileJournal::write_thread_entry()+0x735) [0x659545]
 3: (FileJournal::Writer::entry()+0xd) [0x5de41d]
 4: (()+0x7e9a) [0x7fc042434e9a]
 5: (clone()+0x6d) [0x7fc0409e94bd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- end dump of recent events ---
2012-06-20 12:42:46.693963 7fc0396cf700 -1 *** Caught signal (Aborted) **
 in thread 7fc0396cf700

 ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
 1: /usr/bin/ceph-osd() [0x6eb32a]
 2: (()+0xfcb0) [0x7fc04243ccb0]
 3: (gsignal()+0x35) [0x7fc04092d445]
 4: (abort()+0x17b) [0x7fc040930bab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc04127b69d]
 6: (()+0xb5846) [0x7fc041279846]
 7: (()+0xb5873) [0x7fc041279873]
 8: (()+0xb596e) [0x7fc04127996e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x282) [0x79dd02]
 10: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
 11: (FileJournal::write_thread_entry()+0x735) [0x659545]
 12: (FileJournal::Writer::entry()+0xd) [0x5de41d]
 13: (()+0x7e9a) [0x7fc042434e9a]
 14: (clone()+0x6d) [0x7fc0409e94bd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
     0> 2012-06-20 12:42:46.693963 7fc0396cf700 -1 *** Caught signal
(Aborted) **
 in thread 7fc0396cf700

 ceph version 0.47.2 (commit:8bf9fde89bd6ebc4b0645b2fe02dadb1c17ad372)
 1: /usr/bin/ceph-osd() [0x6eb32a]
 2: (()+0xfcb0) [0x7fc04243ccb0]
 3: (gsignal()+0x35) [0x7fc04092d445]
 4: (abort()+0x17b) [0x7fc040930bab]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7fc04127b69d]
 6: (()+0xb5846) [0x7fc041279846]
 7: (()+0xb5873) [0x7fc041279873]
 8: (()+0xb596e) [0x7fc04127996e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x282) [0x79dd02]
 10: (FileJournal::do_write(ceph::buffer::list&)+0xe22) [0x653082]
 11: (FileJournal::write_thread_entry()+0x735) [0x659545]
 12: (FileJournal::Writer::entry()+0xd) [0x5de41d]
 13: (()+0x7e9a) [0x7fc042434e9a]
 14: (clone()+0x6d) [0x7fc0409e94bd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- end dump of recent events ---
