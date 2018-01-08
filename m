From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: C++17 and C++ ABI on master
Date: Mon, 8 Jan 2018 16:44:25 -0500
Message-ID: <20180108214425.GA10545@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752168AbeAHVo0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 8 Jan 2018 16:44:26 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Esoteric Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>
Cc: The Exoteric Order of the Squid Cybernetic <ceph-users@ceph.com>

Good day,

I've just merged some changs into master that set us up to compile
with C++17. This will require a reasonably new compiler to build
master.

Due to a change in how 'noexcept' is handled (it is now part of the type
signature of a function), mangled symbol names of noexcept functions are
different, so if you have custom clients using the C++ libraries, you may
need to recompile.

Do not worry, there should be no change to the C ABI. Any C clients
should be unaffected.

Thank you.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@OFTC, Actinic@Freenode
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
