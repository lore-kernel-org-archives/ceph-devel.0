From: sheng qiu <herbert1984106@gmail.com>
Subject: crash on ceph
Date: Wed, 26 Oct 2011 09:12:32 -0500
Message-ID: <CAB7xdim2nuP-J__fG2RippWx-2U8xQBas4SmTRF=Bugy9sa0-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53730 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab1JZOMd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Oct 2011 10:12:33 -0400
Received: by iaby12 with SMTP id y12so1773241iab.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Oct 2011 07:12:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,

thanks for the reply. i met a new problem. now i can mount the ceph
using cfuse. and write small single file. but it will crash when file
size increased to some number. the osd.log is:
2011-10-26 08:59:20.156983 7febdca06700 journal FileJournal::write_bl
: write_fd failed: error 13: Permission denied
2011-10-26 08:59:20.157000 7febdca06700 journal FileJournal::do_write:
write_bl(pos=10481664) failed
os/FileJournal.cc: In function 'void
FileJournal::do_write(ceph::bufferlist&)', in thread '0x7febdca06700'
os/FileJournal.cc: 817: FAILED assert(0)
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 2: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 3: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 4: (()+0x69ca) [0x7febe38119ca]
 5: (clone()+0x6d) [0x7febe22f870d]
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 2: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 3: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 4: (()+0x69ca) [0x7febe38119ca]
 5: (clone()+0x6d) [0x7febe22f870d]
*** Caught signal (Aborted) **
 in thread 0x7febdca06700
 ceph version 0.34 (commit:2f039eeeb745622b866d80feda7afa055e15f6d6)
 1: ./cosd() [0x5c69d4]
 2: (()+0xf8f0) [0x7febe381a8f0]
 3: (gsignal()+0x35) [0x7febe2245a75]
 4: (abort()+0x180) [0x7febe22495c0]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7febe2afb8e5]
 6: (()+0xcad16) [0x7febe2af9d16]
 7: (()+0xcad43) [0x7febe2af9d43]
 8: (()+0xcae3e) [0x7febe2af9e3e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x39f) [0x5cbb1f]
 10: (FileJournal::do_write(ceph::buffer::list&)+0x367) [0x6b61f7]
 11: (FileJournal::write_thread_entry()+0x3e6) [0x6b97c6]
 12: (FileJournal::Writer::entry()+0xd) [0x6a50dd]
 13: (()+0x69ca) [0x7febe38119ca]
 14: (clone()+0x6d) [0x7febe22f870d]

does any one have idea about this?

Thanks,
Sheng

-- 
Sheng Qiu
Texas A & M University
Room 302 Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
