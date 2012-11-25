From: Drunkard Zhang <gongfan193@gmail.com>
Subject: BUG: mount failed with IP and hostname mixed
Date: Mon, 26 Nov 2012 01:26:47 +0800
Message-ID: <CAJiejCQqjStwZi1Tgei-AsKrkrbo876mWziP1FoPVhDBm8Yjqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33960 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab2KYR1J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 12:27:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so5261118iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 09:27:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's ceph-0.51, easy to reproduce, just mix IP and hostname and put IP
before hostnames when mount use ceph-fuse or mount.ceph, like:

ceph-fuse -m 150.164.100.218,log21,log3 /mnt/bc
mount -t ceph 150.164.100.218,log21,log3 /mnt/bc
mount.ceph 150.164.100.218,log21,log3 /mnt/bc

Here's failed message using ceph-fuse:
log2 /tmp # ceph-fuse -m 150.164.100.218,log21,log3 /mnt/bc
2012-11-26 01:23:38.712704 7f4a4bfc6780 -1 did not load config file,
using default settings.
mon/MonMap.h: In function 'void MonMap::add(const std::string&, const
entity_addr_t&)' thread 7f4a4bfc6780 time 2012-11-26 01:23:38.713625
mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)
 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 4: (main()+0x1bd) [0x482cad]
 5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 6: ceph-fuse() [0x4829b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
2012-11-26 01:23:38.715137 7f4a4bfc6780 -1 mon/MonMap.h: In function
'void MonMap::add(const std::string&, const entity_addr_t&)' thread
7f4a4bfc6780 time 2012-11-26 01:23:38.713625
mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)

 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 4: (main()+0x1bd) [0x482cad]
 5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 6: ceph-fuse() [0x4829b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

    -1> 2012-11-26 01:23:38.712704 7f4a4bfc6780 -1 did not load config
file, using default settings.
     0> 2012-11-26 01:23:38.715137 7f4a4bfc6780 -1 mon/MonMap.h: In
function 'void MonMap::add(const std::string&, const entity_addr_t&)'
thread 7f4a4bfc6780 time 2012-11-26 01:23:38.713625
mon/MonMap.h: 97: FAILED assert(addr_name.count(addr) == 0)

 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 2: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 3: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 4: (main()+0x1bd) [0x482cad]
 5: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 6: ceph-fuse() [0x4829b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

terminate called after throwing an instance of 'ceph::FailedAssertion'
*** Caught signal (Aborted) **
 in thread 7f4a4bfc6780
 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: ceph-fuse() [0x67a904]
 2: (()+0x10410) [0x7f4a4b972410]
 3: (gsignal()+0x35) [0x7f4a49fdea85]
 4: (abort()+0x185) [0x7f4a49fdfd85]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
 6: (()+0xb8976) [0x7f4a4a917976]
 7: (()+0xb89a3) [0x7f4a4a9179a3]
 8: (()+0xb8a9e) [0x7f4a4a917a9e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x7a2) [0x59f1d2]
 10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 13: (main()+0x1bd) [0x482cad]
 14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 15: ceph-fuse() [0x4829b9]
2012-11-26 01:23:38.716314 7f4a4bfc6780 -1 *** Caught signal (Aborted) **
 in thread 7f4a4bfc6780

 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: ceph-fuse() [0x67a904]
 2: (()+0x10410) [0x7f4a4b972410]
 3: (gsignal()+0x35) [0x7f4a49fdea85]
 4: (abort()+0x185) [0x7f4a49fdfd85]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
 6: (()+0xb8976) [0x7f4a4a917976]
 7: (()+0xb89a3) [0x7f4a4a9179a3]
 8: (()+0xb8a9e) [0x7f4a4a917a9e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x7a2) [0x59f1d2]
 10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 13: (main()+0x1bd) [0x482cad]
 14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 15: ceph-fuse() [0x4829b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

     0> 2012-11-26 01:23:38.716314 7f4a4bfc6780 -1 *** Caught signal
(Aborted) **
 in thread 7f4a4bfc6780

 ceph version 0.51 (commit:c03ca95d235c9a072dcd8a77ad5274a52e93ae30)
 1: ceph-fuse() [0x67a904]
 2: (()+0x10410) [0x7f4a4b972410]
 3: (gsignal()+0x35) [0x7f4a49fdea85]
 4: (abort()+0x185) [0x7f4a49fdfd85]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f4a4a9197cd]
 6: (()+0xb8976) [0x7f4a4a917976]
 7: (()+0xb89a3) [0x7f4a4a9179a3]
 8: (()+0xb8a9e) [0x7f4a4a917a9e]
 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x7a2) [0x59f1d2]
 10: (MonMap::build_from_host_list(std::string, std::string)+0xb13) [0x55cf03]
 11: (MonMap::build_initial(CephContext*, std::ostream&)+0xe7) [0x55e827]
 12: (MonClient::build_initial_monmap()+0x6c) [0x54debc]
 13: (main()+0x1bd) [0x482cad]
 14: (__libc_start_main()+0xfd) [0x7f4a49fcb4bd]
 15: ceph-fuse() [0x4829b9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
Aborted

Here's direct mount message:
log2 /tmp # mount.ceph 150.164.100.218,log21,log3 /mnt/bc
source mount path was not specified
failed to resolve source
