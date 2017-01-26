From: myoungwon oh <ohmyoungwon@gmail.com>
Subject: Question about writeback performance and content address obejct for deduplication
Date: Thu, 26 Jan 2017 20:04:53 +0900
Message-ID: <CAFNt83bds6KzCnMvxyN=vPu7dg_NyX3cHdZwgmhiQqKt4B314A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35473 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753162AbdAZLEy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jan 2017 06:04:54 -0500
Received: by mail-vk0-f49.google.com with SMTP id x75so151968442vke.2
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jan 2017 03:04:54 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, =?UTF-8?B?7Jik66qF7JuQ?= <omwmw@sk.com>

I have two questions.

1. I would like to ask about CAS location. current our implementation store
content address object in storage tier.However, If we store the CAO in the
cache tier, we can get a performance advantage. Do you think we can create
CAO in cachetier? or create a separate storage pool for CAS?


2. The results below are performance result for our current implementation.
experiment setup:
PROXY (inline dedup), WRITEBACK (lazy dedup, target_max_bytes: 50MB),
ORIGINAL(without dedup feature and cache tier),
fio, 512K block, seq. I/O, single thread

One thing to note is that the writeback case is slower than the proxy.
We think there are three problems as follows.

A. The current implementation creates a fingerprint by reading the entire
object when flushing. Therefore, there is a problem that read and write are
mixed.

B. When client request read, the promote_object function reads the object
and writes it back to the cache tier, which also causes a mix of read and
write.

C. When flushing, the unchanged part is rewritten because flush operation
perform per-object based.

Do I have something wrong? or Could you give me a suggestion to improve
performance?


a. Write performance (KB/s)

dedup_ratio  0 20 40 60 80 100

PROXY  45586 47804 51120 52844 56167 55302

WRITEBACK  13151 11078 9531 13010 9518 8319

ORIGINAL  121209 124786 122140 121195 122540 132363


b. Read performance (KB/s)

dedup_ratio  0 20 40 60 80 100

PROXY  112231 118994 118070 120071 117884 132748

WRITEBACK  34040 29109 19104 26677 24756 21695

ORIGINAL  285482 284398 278063 277989 271793 285094


thanks,
Myoungwon Oh
