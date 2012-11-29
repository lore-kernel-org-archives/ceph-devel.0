From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Client crash on getcwd with non-default root mount
Date: Thu, 29 Nov 2012 11:52:21 -0800
Message-ID: <CAPrxi5-bXcBXxifVnS9Q1z2tGN1wuC0s7EjRUjHN_8RaCXH+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34675 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab2K2TwY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 14:52:24 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so9634295vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 11:52:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm getting the assert failure below with the following test:

  ceph_mount(cmount, "/otherdir");
  ceph_getcwd(cmount);

--

client/Inode.h: In function 'Dentry* Inode::get_first_parent()' thread
7fded47c8780 time 2012-11-29 11:49:00.890184
client/Inode.h: 165: FAILED assert(!dn_set.empty())
 ceph version 0.54-808-g1ed5a1f (1ed5a1f984d8260d86cc25b1ae95ffedf597e579)
 1: (()+0x11ee89) [0x7fded36fae89]
 2: (()+0x1429d3) [0x7fded371e9d3]
 3: (ceph_getcwd()+0x11) [0x7fded36fdb41]
 4: (MountedTest2_XYZ_Test::TestBody()+0x63a) [0x42563a]
 5: (testing::Test::Run()+0xaa) [0x45017a]
 6: (testing::internal::TestInfoImpl::Run()+0x100) [0x450280]
 7: (testing::TestCase::Run()+0xbd) [0x45034d]
 8: (testing::internal::UnitTestImpl::RunAllTests()+0x217) [0x4505b7]
 9: (main()+0x35) [0x423115]
 10: (__libc_start_main()+0xed) [0x7fded2d2876d]
 11: /home/nwatkins/projects/ceph/ceph/src/.libs/lt-test_libcephfs() [0x423171]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
Aborted (core dumped)

Thanks,
Noah
