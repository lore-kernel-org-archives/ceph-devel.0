From: Joao Eduardo Luis <joao@suse.de>
Subject: Errors building ceph post c++11 merge
Date: Mon, 10 Aug 2015 18:07:14 +0100
Message-ID: <55C8DA42.3070001@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49453 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754423AbbHJRHR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 10 Aug 2015 13:07:17 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 8C42CABC6
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2015 17:07:15 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

To all of those who may be afflicted by various build failures after the
c++11 patches were merged, don't panic just yet.

If you are using ccache to help your builds, try clearing the whole
cache first.

As of right now, this has fixed the following build errors on trusty for
(at least) two developers:


> ./.libs/librados.so: undefined reference to
`__cxa_throw_bad_array_new_length'
> collect2: error: ld returned 1 exit status

and

> /usr/bin/ld: test/librados/ceph_test_rados_api_io-io.o: relocation
R_X86_64_32 against `.rodata' can not be used when making a shared
object; recompile with -fPIC


Hope this email helps someone else avoid wasting a morning on this.

  -Joao
