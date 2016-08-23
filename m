From: Ning Yao <zay11022@gmail.com>
Subject: BUG ON librbd or libc
Date: Tue, 23 Aug 2016 15:45:58 +0800
Message-ID: <CALZt5jz5K_+bduZg6DgQxjm4E6L4Eizp_aW8pOgiEWB33Vc=ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36442 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbcHWHqA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2016 03:46:00 -0400
Received: by mail-qk0-f176.google.com with SMTP id l2so99606831qkf.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Aug 2016 00:45:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi, all

Our vm is terminated unexpectedly when using librbd in our production
environment with CentOS 7.0 kernel 3.12 with Ceph version 0.94.5 and
glibc version 2.17. we get log from libvirtd as below

*** Error in `/usr/libexec/qemu-kvm': invalid fastbin entry (free):
0x00007f7db7eed740 ***

======= Backtrace: =========

/lib64/libc.so.6(+0x7d1fd)[0x7f8520fe61fd]

/lib64/librbd.so.1(_ZNSt10_List_baseIN4ceph6buffer3ptrESaIS2_EE8_M_clearEv+0x2f)[0x7f8527589b3f]

/lib64/librados.so.2(+0xb8a06)[0x7f8525080a06]

/lib64/librados.so.2(+0xb9457)[0x7f8525081457]

/lib64/librados.so.2(+0x718f7)[0x7f85250398f7]

/lib64/librados.so.2(+0x2bffe5)[0x7f8525287fe5]

/lib64/librados.so.2(+0x2cbaad)[0x7f8525293aad]

/lib64/libpthread.so.0(+0x7df5)[0x7f852ab12df5]

/lib64/libc.so.6(clone+0x6d)[0x7f852105f1ad]

but the log does not show symbols so that we cannot know which
functions cause the error, any suggestions?



Regards
Ning Yao
