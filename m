From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Assertion failure in ceph_readlink()
Date: Thu, 01 Nov 2012 18:13:50 -0500
Message-ID: <5093022E.3040604@inktank.com>
References: <5092F9CB.7020501@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40603 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940Ab2KAXNz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 19:13:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2050114pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 16:13:54 -0700 (PDT)
In-Reply-To: <5092F9CB.7020501@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On 11/01/2012 05:38 PM, Noah Watkins wrote:
> I'm getting the following assertion failure when running a test that creates a symlink and then tries to read it using ceph_readlink().
>
> This is the failure, and the test is shown below (and is in wip-java-symlinks). Also note that if the test below is altered to use relative paths for both symlink parameters, that readlink() returns an error that the path is not a symlink, despite the S_ISLNK test passing.
>
> Thanks, Noah
>

Hi Noah,

The path_walk() function has a followsym parameter that defaults to 
true, so it looks like the path_walk was walking through the symlink and 
we weren't getting back the symlink's inode.  The following patch should 
fix it.

-sam

diff --git a/src/client/Client.cc b/src/client/Client.cc
index 424be09..aa1d891 100644
--- a/src/client/Client.cc
+++ b/src/client/Client.cc
@@ -3955,7 +3955,7 @@ int Client::readlink(const char *relpath, char 
*buf, loff_t size)

    filepath path(relpath);
    Inode *in;
-  int r = path_walk(path, &in);
+  int r = path_walk(path, &in, false);
    if (r < 0)
      return r;



> (master)kyoto:src $ ./test_libcephfs
> Running main() from gtest_main.cc
> [==========] Running 19 tests from 1 test case.
> [----------] Global test environment set-up.
> [----------] 19 tests from LibCephFS
> [ RUN      ] LibCephFS.Readlink_absolute
> ./include/filepath.h: In function 'void filepath::append(const filepath&)' thread 7ffec07dc780 time 2012-11-01 15:31:28.256797
> ./include/filepath.h: 180: FAILED assert(a.pure_relative())
>   ceph version 0.53-583-gdfc57c4 (dfc57c4fa50b84cd4bdc29a266b955455d0e9d5b)
>   1: (Client::path_walk(filepath const&, Inode**, bool)+0xb4f) [0x7ffebf746a6f]
>   2: (Client::readlink(char const*, char*, long)+0xf9) [0x7ffebf748ae9]
>   3: (LibCephFS_Readlink_absolute_Test::TestBody()+0x9f1) [0x4233d1]
>   4: (testing::Test::Run()+0xaa) [0x4407aa]
>   5: (testing::internal::TestInfoImpl::Run()+0x100) [0x4408b0]
>   6: (testing::TestCase::Run()+0xbd) [0x44097d]
>   7: (testing::internal::UnitTestImpl::RunAllTests()+0x217) [0x440be7]
>   8: (main()+0x35) [0x4194b5]
>   9: (__libc_start_main()+0xed) [0x7ffebed5d76d]
>   10: /home/nwatkins/projects/ceph/ceph/src/.libs/lt-test_libcephfs() [0x419511]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted (core dumped)
>
> ---
>
> TEST(LibCephFS, Readlink_absolute) {
>    struct ceph_mount_info *cmount;
>    ASSERT_EQ(ceph_create(&cmount, NULL), 0);
>    ASSERT_EQ(ceph_conf_read_file(cmount, NULL), 0);
>    ASSERT_EQ(ceph_mount(cmount, NULL), 0);
>
>    /* make source */
>    char oldpath[256];
>    sprintf(oldpath, "/test_readlinkabs_%d", getpid());
>    int fd = ceph_open(cmount, oldpath, O_CREAT|O_RDWR, 0666);
>    ASSERT_GT(fd, 0);
>    ceph_close(cmount, fd);
>
>    /* make target */
>    char newpath[256];
>    sprintf(newpath, "/test_readlinkabs_sym_%d", getpid());
>    ASSERT_EQ(ceph_symlink(cmount, oldpath, newpath), 0);
>
>    /* size of link */
>    struct stat stat;
>    ASSERT_EQ(ceph_lstat(cmount, newpath, &stat), 0);
>    ASSERT_TRUE(S_ISLNK(stat.st_mode));
>
>    char linkname[256];
>    ASSERT_GT((int)sizeof(linkname), stat.st_size);
>    memset(linkname, 0, sizeof(linkname));
>
>    ceph_readlink(cmount, newpath, linkname, stat.st_size + 1);
>
>    ceph_shutdown(cmount);
> }
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

