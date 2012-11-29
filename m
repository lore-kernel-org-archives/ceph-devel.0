From: Sam Lang <sam.lang@inktank.com>
Subject: Re: Client crash on getcwd with non-default root mount
Date: Thu, 29 Nov 2012 13:58:06 -0600
Message-ID: <50B7BE4E.3010108@inktank.com>
References: <CAPrxi5-bXcBXxifVnS9Q1z2tGN1wuC0s7EjRUjHN_8RaCXH+wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58763 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab2K2T6J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 14:58:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so12714849iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 11:58:09 -0800 (PST)
In-Reply-To: <CAPrxi5-bXcBXxifVnS9Q1z2tGN1wuC0s7EjRUjHN_8RaCXH+wA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 11/29/2012 01:52 PM, Noah Watkins wrote:
> I'm getting the assert failure below with the following test:
>
>    ceph_mount(cmount, "/otherdir");

This should fail with ENOENT if you check the return code.
-sam

>    ceph_getcwd(cmount);
>
> --
>
> client/Inode.h: In function 'Dentry* Inode::get_first_parent()' thread
> 7fded47c8780 time 2012-11-29 11:49:00.890184
> client/Inode.h: 165: FAILED assert(!dn_set.empty())
>   ceph version 0.54-808-g1ed5a1f (1ed5a1f984d8260d86cc25b1ae95ffedf597e579)
>   1: (()+0x11ee89) [0x7fded36fae89]
>   2: (()+0x1429d3) [0x7fded371e9d3]
>   3: (ceph_getcwd()+0x11) [0x7fded36fdb41]
>   4: (MountedTest2_XYZ_Test::TestBody()+0x63a) [0x42563a]
>   5: (testing::Test::Run()+0xaa) [0x45017a]
>   6: (testing::internal::TestInfoImpl::Run()+0x100) [0x450280]
>   7: (testing::TestCase::Run()+0xbd) [0x45034d]
>   8: (testing::internal::UnitTestImpl::RunAllTests()+0x217) [0x4505b7]
>   9: (main()+0x35) [0x423115]
>   10: (__libc_start_main()+0xed) [0x7fded2d2876d]
>   11: /home/nwatkins/projects/ceph/ceph/src/.libs/lt-test_libcephfs() [0x423171]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> terminate called after throwing an instance of 'ceph::FailedAssertion'
> Aborted (core dumped)
>
> Thanks,
> Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

