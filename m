From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Continous failing osd-scrub-repair.sh
Date: Wed, 31 May 2017 22:58:39 +0200
Message-ID: <2c70fd7a-f0dd-2847-f740-b9e4d248a95f@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37234 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdEaU6v (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 May 2017 16:58:51 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id C4521422D2
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 22:58:47 +0200 (CEST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Since a few days I have a continuous failing test: osd-scrub-repair.sh

There is a diff failing, where the data looks almost correct. :(
Looks there is something wrong with omap_digest.

Could this be due to bluestore being enable, whilst FreeBSD does not
have that?

Anyways, all suggestions are welcome

--WjW

/home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569:
TEST_corrupt_scrub_replicated:  diff td/osd-scrub-repair/checkcsjson
td/osd-scrub-repair/csjson
322c322
<     "selected_object_info":
"2:f4981d31:::ROBJ4:head(dirty|omap|data_digest|omap_digest s 7 uv 12 dd
2ddbf8f5 od d7178dfe alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:f4981d31:::ROBJ4:head(dirty|omap|data_digest s 7 uv 12 dd 2ddbf8f5
alloc_hint [0 0 0])",
333,335c333
<         "errors": [
<           "omap_digest_mismatch_oi"
<         ],
---
>         "errors": [],
341,343c339
<     "union_shard_errors": [
<       "omap_digest_mismatch_oi"
<     ]
---
>     "union_shard_errors": []
356c352
<     "selected_object_info":
"2:f4bfd4d1:::ROBJ5:head(dirty|omap|data_digest|omap_digest s 7 uv 15 dd
2ddbf8f5 od 1a862a41 alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:f4bfd4d1:::ROBJ5:head(dirty|omap|data_digest s 7 uv 15 dd 2ddbf8f5
alloc_hint [0 0 0])",
367,369c363
<         "errors": [
<           "omap_digest_mismatch_oi"
<         ],
---
>         "errors": [],
375,377c369
<     "union_shard_errors": [
<       "omap_digest_mismatch_oi"
<     ]
---
>     "union_shard_errors": []
390c382
<     "selected_object_info":
"2:a53c12e8:::ROBJ6:head(dirty|omap|data_digest|omap_digest s 7 uv 18 dd
2ddbf8f5 od 689ee887 alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:a53c12e8:::ROBJ6:head(dirty|omap|data_digest s 7 uv 18 dd 2ddbf8f5
alloc_hint [0 0 0])",
401,403c393
<         "errors": [
<           "omap_digest_mismatch_oi"
<         ],
---
>         "errors": [],
409,411c399
<     "union_shard_errors": [
<       "omap_digest_mismatch_oi"
<     ]
---
>     "union_shard_errors": []
424c412
<     "selected_object_info":
"2:8b55fa4b:::ROBJ7:head(dirty|omap|data_digest|omap_digest s 7 uv 21 dd
2ddbf8f5 od efced57a alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:8b55fa4b:::ROBJ7:head(dirty|omap|data_digest s 7 uv 21 dd 2ddbf8f5
alloc_hint [0 0 0])",
435,437c423
<         "errors": [
<           "omap_digest_mismatch_oi"
<         ],
---
>         "errors": [],
443,445c429
<     "union_shard_errors": [
<       "omap_digest_mismatch_oi"
<     ]
---
>     "union_shard_errors": []
459c443
<     "selected_object_info":
"2:86586531:::ROBJ8:head(dirty|omap|data_digest|omap_digest s 7 uv 26 dd
2ddbf8f5 od d6be81dc alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:86586531:::ROBJ8:head(dirty|omap|data_digest s 7 uv 26 dd 2ddbf8f5
alloc_hint [0 0 0])",
532c516
<       "version": 56
---
>       "version": 50
534c518
<     "selected_object_info":
"2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest|omap_digest s 3 uv 56 dd
1f26fb26 od 2eecc539 alloc_hint [0 0 0])",
---
>     "selected_object_info":
"2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest s 3 uv 50 dd 1f26fb26
alloc_hint [0 0 0])",
571c555
<         "object_info":
"2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest|omap_digest s 3 uv 56 dd
1f26fb26 od 2eecc539 alloc_hint [0 0 0])",
---
>         "object_info": "2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest
s 3 uv 50 dd 1f26fb26 alloc_hint [0 0 0])",
/home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569:
TEST_corrupt_scrub_replicated:  test no = yes
/home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569:
