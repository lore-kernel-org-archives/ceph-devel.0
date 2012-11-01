From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Assertion failure in ceph_readlink()
Date: Thu, 01 Nov 2012 15:38:03 -0700
Message-ID: <5092F9CB.7020501@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:55864 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab2KAWiG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 18:38:06 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1365914dak.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 15:38:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm getting the following assertion failure when running a test that creates a symlink and then tries to read it using ceph_readlink().

This is the failure, and the test is shown below (and is in wip-java-symlinks). Also note that if the test below is altered to use relative paths for both symlink parameters, that readlink() returns an error that the path is not a symlink, despite the S_ISLNK test passing.

Thanks, Noah

(master)kyoto:src $ ./test_libcephfs
Running main() from gtest_main.cc
[==========] Running 19 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 19 tests from LibCephFS
[ RUN      ] LibCephFS.Readlink_absolute
./include/filepath.h: In function 'void filepath::append(const filepath&)' thread 7ffec07dc780 time 2012-11-01 15:31:28.256797
./include/filepath.h: 180: FAILED assert(a.pure_relative())
 ceph version 0.53-583-gdfc57c4 (dfc57c4fa50b84cd4bdc29a266b955455d0e9d5b)
 1: (Client::path_walk(filepath const&, Inode**, bool)+0xb4f) [0x7ffebf746a6f]
 2: (Client::readlink(char const*, char*, long)+0xf9) [0x7ffebf748ae9]
 3: (LibCephFS_Readlink_absolute_Test::TestBody()+0x9f1) [0x4233d1]
 4: (testing::Test::Run()+0xaa) [0x4407aa]
 5: (testing::internal::TestInfoImpl::Run()+0x100) [0x4408b0]
 6: (testing::TestCase::Run()+0xbd) [0x44097d]
 7: (testing::internal::UnitTestImpl::RunAllTests()+0x217) [0x440be7]
 8: (main()+0x35) [0x4194b5]
 9: (__libc_start_main()+0xed) [0x7ffebed5d76d]
 10: /home/nwatkins/projects/ceph/ceph/src/.libs/lt-test_libcephfs() [0x419511]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion'
Aborted (core dumped)

---

TEST(LibCephFS, Readlink_absolute) {
  struct ceph_mount_info *cmount;
  ASSERT_EQ(ceph_create(&cmount, NULL), 0);
  ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
  ASSERT_EQ(ceph_mount(cmount, NULL), 0);

  /* make source */
  char oldpath[256];
  sprintf(oldpath, "/test_readlinkabs_%d", getpid());
  int fd = ceph_open(cmount, oldpath, O_CREAT|O_RDWR, 0666);
  ASSERT_GT(fd, 0);
  ceph_close(cmount, fd);

  /* make target */
  char newpath[256];
  sprintf(newpath, "/test_readlinkabs_sym_%d", getpid());
  ASSERT_EQ(ceph_symlink(cmount, oldpath, newpath), 0);

  /* size of link */
  struct stat stat;
  ASSERT_EQ(ceph_lstat(cmount, newpath, &stat), 0);
  ASSERT_TRUE(S_ISLNK(stat.st_mode));

  char linkname[256];
  ASSERT_GT((int)sizeof(linkname), stat.st_size);
  memset(linkname, 0, sizeof(linkname));

  ceph_readlink(cmount, newpath, linkname, stat.st_size + 1);

  ceph_shutdown(cmount);
}
