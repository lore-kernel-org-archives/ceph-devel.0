From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Ceph-mon crashing FAILED assert(addr_name.count(p->second) == 0)
Date: Fri, 10 Jul 2015 15:31:47 -0700
Message-ID: <CAFkUHxe8Qw4-5ggCm51shQdp8aYzdvEp9Bt9Fq11sur2vUf5oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34578 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbGJWbr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jul 2015 18:31:47 -0400
Received: by oiab3 with SMTP id b3so102526559oia.1
        for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2015 15:31:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I am seeing the following error every time I am trying to manually
deploy ceph cluster and do a ceph -s :

mon/MonMap.h: In function 'void MonMap::calc_ranks()' thread
7fb3ccfb6700 time 2015-07-10 15:27:56.004148

mon/MonMap.h: 47: FAILED assert(addr_name.count(p->second) == 0)

 ceph version 9.0.1-1445-g4a179ee (4a179eea527f7cbcf45eed4a63ad0fa8f744fc4a)

 1: (()+0x12716b) [0x7fb3d53ec16b]

 2: (()+0x1c0a6d) [0x7fb3d5485a6d]

 3: (()+0x1b7909) [0x7fb3d547c909]

 4: (()+0x1b8377) [0x7fb3d547d377]

 5: (()+0x2fbbe7) [0x7fb3d55c0be7]

 6: (()+0x310f1d) [0x7fb3d55d5f1d]

 7: (()+0x3112a0) [0x7fb3d55d62a0]

 8: (()+0x8182) [0x7fb3d9e05182]

 9: (clone()+0x6d) [0x7fb3d9b3247d]

 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

terminate called after throwing an instance of 'ceph::FailedAssertion'

Aborted (core dumped)

Any help greatly appreciated :-)

-Neo
