From: Loic Dachary <loic@dachary.org>
Subject: SIMD accelerated crush_do_rule proof of concept
Date: Mon, 29 Aug 2016 13:42:22 +0200
Message-ID: <57C41F9E.7090309@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35798 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932820AbcH2Lm1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 07:42:27 -0400
Received: from mfilter42-d.gandi.net (mfilter42-d.gandi.net [217.70.178.172])
        by relay5-d.mail.gandi.net (Postfix) with ESMTP id B429241C08F
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 13:42:24 +0200 (CEST)
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
        by mfilter42-d.gandi.net (mfilter42-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id 9KhhI1Zbi-kK for <ceph-devel@vger.kernel.org>;
        Mon, 29 Aug 2016 13:42:22 +0200 (CEST)
Received: from [192.168.3.6] (x4db42c92.dyn.telefonica.de [77.180.44.146])
        (Authenticated sender: loic@dachary.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D335241C088
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 13:42:22 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

TL;DR: crush_do_rule using SIMD goes twice faster, the implementation is straightforward and would help with crushmap validation, is there any reason not to do it ?

When resolving a crush rule (crush_do_rule in mapper.c), the straw2 function (bucket_straw2_choose) calls the hashing function (crush_hash32_3) for each item in a bucket and keeps the best match. When a bucket has four items, the hash function can be run using SIMD instructions. Each item value is 32 bits and four can fit in a __m128i.

I tried to inline the hash function when the conditions are right[1] and run a test to measure the difference.

crushtool -o /tmp/t.map --num_osds 1024 --build node straw2 8 datacenter straw2 4 root straw2 0
time crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 2048000 --num-rep 4
rule 0 (replicated_ruleset), x = 1..2048000, numrep = 4..4
rule 0 (replicated_ruleset) num_rep 4 result size == 4:	2048000/2048000

With SIMD

real	0m10.433s
user	0m10.428s
sys	0m0.000s

Without SIMD

real	0m19.344s
user	0m19.340s
sys	0m0.004s

Callgrind estimated cycles for each crush_do_rule are in the same range:

rm crush.callgrind ; valgrind --tool=callgrind --callgrind-out-file=crush.callgrind crushtool -i /tmp/t.map --show-bad-mappings --show-statistics --test --rule 0 --min-x 1 --max-x 204800 --num-rep 4
kcachegrind crush.callgrind

With SIMD    : crush_do_rule is estimated to use 21 205 cycles
Without SIMD : crush_do_rule is estimated to use 53 068 cycles

This proof of concept relies on instructions that are available on all ARM & Intel processors, nothing complicated is going on. It is beneficial to crush maps that have more than four disks per host, more than four hosts per rack etc. It probably is a small win for an OSD or even a client. For crushmap validation it helps significantly since the MON are not able to run crushtool asynchronously and it needs to run within a few seconds (because it blocks the MON).

The implementation is straightforward: it needs sub/xor/lshift/rshift. The only relatively tricky part is runtime / compile time detection of the SIMD instructions for both Intel and ARM processors. Luckily this has already been taken care of when integrating with the jerasure erasure code plugin.

Is there any reason why it would not be good to implement this ?

Cheers

[1] https://github.com/dachary/ceph/commit/71ae4584d9ed57f70aad718d0ffe206a01e91fef

-- 
Loïc Dachary, Artisan Logiciel Libre
