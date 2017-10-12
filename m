From: kefu chai <tchaikov@gmail.com>
Subject: do we support building on rhel/centos 7.{0,1,2} ?
Date: Thu, 12 Oct 2017 12:27:28 +0800
Message-ID: <CAJE9aOMu87QgwZ5jrRPSUa6E461mYAJnxurmGwV-DU_=CTFgvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35687 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdJLE13 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Oct 2017 00:27:29 -0400
Received: by mail-oi0-f66.google.com with SMTP id e123so1918191oig.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 21:27:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

hi all,


rocksdb's cmake script is using features[0] introduced by cmake
2.8.12[1]. as install()[2] on 2.8.11 does not support "INCLUDES"
argument. hence, the build on el 7.{0,1,2} is broken now. but
http://docs.ceph.com/docs/master/start/os-recommendations/#luminous-12-2-z
claims that we support centos7..

the reason why we are not trouble now is that we are not
building/testing build on them now.

so the question is, shall we support build on centos 7.{0,1,2} on
which cmake 2.8.11? if the answer is yes, we need to maintain the
patched rocksdb submodule in our fork.

--
[0] https://github.com/facebook/rocksdb/pull/2998
[1] https://cmake.org/cmake/help/v2.8.12/cmake.html#command:install
[2] https://cmake.org/cmake/help/v2.8.11/cmake.html#command:install

-- 
Regards
Kefu Chai
