From: Willem Jan Withagen <wjw@digiware.nl>
Subject: AddressSanitizer
Date: Fri, 1 Apr 2016 16:46:20 +0200
Message-ID: <56FE89BC.5040808@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:10908 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbcDAOqd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 1 Apr 2016 10:46:33 -0400
Received: from rack1.digiware.nl (unknown [127.0.0.1])
	by smtp.digiware.nl (Postfix) with ESMTP id CDB4F1534C9
	for <ceph-devel@vger.kernel.org>; Fri,  1 Apr 2016 16:46:30 +0200 (CEST)
Received: from [192.168.101.107] (vpn.ecoracks.nl [31.223.170.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 5A144153402
	for <ceph-devel@vger.kernel.org>; Fri,  1 Apr 2016 16:46:20 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi

In my search for reasons why I have crashes I started using
AddressSanitizer with Clang (since that is native included)
https://github.com/google/sanitizers/wiki/AddressSanitizer,

Below the results which might indicate locations of possible trouble.
Would there be interest into looking into these further?
I know that some unitests under valgrind also complain about memory
leaks just because items are not properly free/deleted since they are
just tests.

But the ceph-mon container-overflow and the .libs/ceph-dencoder double
free are parts of the tree that are used outside the tests.

But I still have to find the flags to actually get the translation to
file codelines for this to be really useful.

--WjW


SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_isa+0x7fea8b)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_isa+0x7e9d0b)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec+0x8144cb)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_all+0x8021ab)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_thread+0x7fb78b)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_shec_arguments+0x7fd74b)
SUMMARY: AddressSanitizer: alloc-dealloc-mismatch
(/usr/srcs/Ceph/work/ceph/src/unittest_erasure_code_plugin_shec+0x7e98db)
SUMMARY: AddressSanitizer: heap-use-after-free
(/usr/srcs/Ceph/work/ceph/src/unittest_pglog+0x92722f)
SUMMARY: AddressSanitizer: dynamic-stack-buffer-overflow
(/usr/srcs/Ceph/work/ceph/src/unittest_lfnindex+0x8ee69f)
SUMMARY: AddressSanitizer: stack-buffer-overflow
(/usr/srcs/Ceph/work/ceph/src/unittest_utf8+0x5ff392)
SUMMARY: AddressSanitizer: container-overflow
(/usr/srcs/Ceph/work/ceph/src/ceph-mon+0xb591b1)
SUMMARY: AddressSanitizer: double-free
(/usr/srcs/Ceph/work/ceph/src/.libs/ceph-dencoder+0x8b1fcb)

