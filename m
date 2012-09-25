From: hemant surale <hemant.surale@gmail.com>
Subject: Re: How to use ruleset
Date: Tue, 25 Sep 2012 15:49:02 +0530
Message-ID: <CAGfy=6m2vGuDi4jARaat+rUR-aP2eDcuhNJyWCpWtAEbQGGLDA@mail.gmail.com>
References: <CAGfy=6=6P1zA-0gkBqEowuuiP0qqCjnFpGCSM-R0xKBL13W7uQ@mail.gmail.com>
	<50573BF1.4010001@widodh.nl>
	<CAGfy=6mGaH_MP+3ROUqhLGYHikPUvFHZwR3H=9za6qmnn=ZZuA@mail.gmail.com>
	<50617FEA.9010700@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57033 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771Ab2IYKTD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Sep 2012 06:19:03 -0400
Received: by vcbfo13 with SMTP id fo13so7404202vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Sep 2012 03:19:03 -0700 (PDT)
In-Reply-To: <50617FEA.9010700@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

# begin crush map


# devices
device 0 device0
device 1 device1
device 2 device2

# types
type 0 osd
type 1 domain
type 2 pool
type 3 host
type 4 ghost

host hone {
        id -2
        alg straw
        hash 0
        item device0 weight 1.000
        item device1 weight 1.000
}
ghost hsec {
        id -3
        alg straw
        hash 0
        item device2 weight 1.000
}
domain root {
        id -1
        alg straw
        hash 0
        item hone weight 1.000
        item hsec weight 1.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type osd
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type osd
        step emit
}
rule rbd {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type osd
        step emit
}
rule forhone {
        ruleset 3
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type host
        step choose firstn 0 type osd
        step emit
}
rule forhsecond {
        ruleset 4
        type replicated
        min_size 1
        max_size 10
        step take root
        step choose firstn 0 type ghost
        step choose firstn 0 type osd
        step emit
}
# end crush map

i tried to create new pool with size= 2 & crush_ruleset= 3 . it works
fine but when i create Object inside pool error is :
root@third-virtual-machine:~# rados -p new create Obj1
rados: crush/mapper.c:369: crush_choose: Assertion `!(item >= 0 ||
(-1-item) >= map->max_buckets)' failed.
*** Caught signal (Aborted) **
 in thread 0xb6e4f6e0
 ceph version 0.36 (commit:877cacbbdbb78d120b431cb762f57332d62ef0a6)
 1: rados() [0x808a9f8]
 2: [0xb7793400]
 3: [0xb7793424]
 4: (gsignal()+0x4f) [0xb6e7ec8f]
 5: (abort()+0x175) [0xb6e822b5]
 6: (__assert_fail()+0xf6) [0xb6e77826]
 7: (()+0x1caa6f) [0xb771ba6f]
 8: (crush_do_rule()+0x2ef) [0xb771bddf]
 9: (()+0x8ad29) [0xb75dbd29]
 10: (OSDMap::pg_to_acting_osds(pg_t, std::vector<int,
std::allocator<int> >&)+0x15f) [0xb75f783f]
 11: (Objecter::recalc_op_target(Objecter::Op*)+0x1b9) [0xb75e02c9]
 12: (Objecter::op_submit(Objecter::Op*, Objecter::OSDSession*)+0xc27)
[0xb75e72b7]
 13: (Objecter::create(object_t const&, object_locator_t const&,
SnapContext const&, utime_t, int, int, Context*, Context*,
eversion_t*, ObjectOperation*)+0x23d) [0xb75d6aed]
 14: (librados::RadosClient::create(librados::IoCtxImpl&, object_t
const&, bool)+0x202) [0xb75c23a2]
 15: (librados::IoCtx::create(std::string const&, bool)+0x51) [0xb75c2521]
 16: (main()+0x4ba2) [0x8074512]
 17: (__libc_start_main()+0xf3) [0xb6e6a113]
Aborted

I was able to put file onto osd0,osd1 specifically then suddenly i was
modifying something and i am unable to recall what went wrong . now I
am unable to create Objs ..


-
Hemant Surale.
