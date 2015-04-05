From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Cehp - tip - build break ?
Date: Sat, 4 Apr 2015 22:07:00 -0700
Message-ID: <CAFkUHxdMwZDR7=Z1XeyF9zrNzV2e1U+OWcsRpVusi_GhzCPN1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35940 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbDEFHB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Apr 2015 01:07:01 -0400
Received: by pdea3 with SMTP id a3so8476189pde.3
        for <ceph-devel@vger.kernel.org>; Sat, 04 Apr 2015 22:07:01 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I am seeing build break in ceph master.

make[3]: *** No rule to make target
`../src/gmock/lib/libgmock_main.la', needed by `unittest_librbd'.
Stop.

make[3]: *** Waiting for unfinished jobs....

  CXX      test/erasure-code/ceph_erasure_code_non_regression.o


Am I missing anything obvious ?


-Neo
