From: Junwang Zhao <zhjwpku@gmail.com>
Subject: [GSoC] wrong patch "msg: change entity_addr_t encode/decode"
Date: Tue, 31 May 2016 21:04:45 +0800
Message-ID: <CAEG8a3JF2t1hkHY2MQK5DVwbOy3VGZUNuB-uF5mOzBSO8xhQeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33306 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbcEaNEq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2016 09:04:46 -0400
Received: by mail-vk0-f67.google.com with SMTP id m81so22403472vka.0
        for <ceph-devel@vger.kernel.org>; Tue, 31 May 2016 06:04:45 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage A. Weil" <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage & Haomai,

I try to run './vstart.sh -d -x -n' to test the patches today, I got
some error like 'wrong node', after some work, I found the
error was introduced by this patch[0]. I change the code to
use the legacy decode and encode, but got stuck somewhere.

--- a/src/msg/msg_types.h
+++ b/src/msg/msg_types.h
@@ -371,7 +371,7 @@ struct entity_addr_t {
   // broader study

   void encode(bufferlist& bl, uint64_t features) const {
-    if ((features & CEPH_FEATURE_MSG_ADDR2) == 0) {
+    if ((features & CEPH_FEATURE_MSG_ADDR2) != 0) {
       ::encode((__u32)0, bl);
       ::encode(nonce, bl);
       sockaddr_storage ss = get_sockaddr_storage();


Can you please see the patch again and give some comments?

[0]https://github.com/zhjwpku/ceph/commit/8934f038fdf28156038770e601e4a27f7a684390

Thanks,
Zhao
