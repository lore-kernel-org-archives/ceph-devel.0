From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Bug with ceph_mount and non-existent directory
Date: Tue, 26 Jun 2012 20:20:54 -0700
Message-ID: <071130CA-B2AB-4C9D-80A7-23BE3DEF12C9@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40011 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab2F0DU5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 23:20:57 -0400
Received: by pbbrp8 with SMTP id rp8so932126pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 20:20:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I get the following assert failure during cleanup if ceph_mount() is passed a non-existent directory, while ceph_mount() returns success. Nothing critical, but it got triggered with Java unit test framework.

    [junit] ./include/xlist.h: In function 'xlist<T>::item::~item() [with T = Inode*]' thread 7fafb175f700 time 2012-06-24 11:11:03.038030
    [junit] ./include/xlist.h: 28: FAILED assert(!is_on_list())
    [junit]  ceph version 0.47.2-414-gc4bf133 (commit:c4bf133b87403016cff0355cbebd54f95d3f753b)
    [junit]  1: (()+0x1073c8) [0x7fafa862d3c8]
    [junit]  2: (Inode::~Inode()+0x249) [0x7fafa867f8f9]
    [junit]  3: (Client::tear_down_cache()+0x2c3) [0x7fafa8667393]
    [junit]  4: (Client::~Client()+0x2f) [0x7fafa866747f]
    [junit]  5: (Client::~Client()+0x9) [0x7fafa8667b49]
    [junit]  6: (ceph_mount()+0x136) [0x7fafa862f8d6]

Thanks,
- Noah