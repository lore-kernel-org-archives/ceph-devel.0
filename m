Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B70C6FA8E
	for <ceph-devel@archiver.kernel.org>; Wed,  1 Mar 2023 03:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjCADHT (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 28 Feb 2023 22:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCADHT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2023 22:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5477837B52
        for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2023 19:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677639992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S7n8ZL3d9ySK1KxY73/F1Pwr+fP/AXw2jUimmvQw7r4=;
        b=CYzptSqP4opUoQmludk+FF6jcnSmlF9F5PCJT7LbT6ly1d0HGyh6niPclJ5122UmLf0iXo
        cuA5RtI2T3x5ySJuUoHTTtHoXakQTWL+PfK8VAaoSsFWk/5g8+x3rNh9pRdrYZYAZM423x
        MndXygeQba+9nqD6O45Vv8dciIRSc94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-qYirB8_kNC6oy20fj1DSHw-1; Tue, 28 Feb 2023 22:06:29 -0500
X-MC-Unique: qYirB8_kNC6oy20fj1DSHw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7641C05140;
        Wed,  1 Mar 2023 03:06:28 +0000 (UTC)
Received: from lxbceph1.gsslab.pek2.redhat.com (unknown [10.72.47.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 133C0140EBF6;
        Wed,  1 Mar 2023 03:06:25 +0000 (UTC)
From:   xiubli@redhat.com
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com, djwong@kernel.org, ceph-devel@vger.kernel.org,
        vshankar@redhat.com, zlang@redhat.com, Xiubo Li <xiubli@redhat.com>
Subject: [PATCH] generic/{075,112}: fix printing the incorrect return value of fsx
Date:   Wed,  1 Mar 2023 11:06:20 +0800
Message-Id: <20230301030620.137153-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

We need to save the result of the 'fsx' temporarily.

Fixes: https://tracker.ceph.com/issues/58834
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 tests/generic/075 | 6 ++++--
 tests/generic/112 | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/generic/075 b/tests/generic/075
index 03a394a6..bc3a11c7 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -53,9 +53,11 @@ _do_test()
 
     # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
     cd $out
-    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $seq.$_n $FSX_AVOID &>/dev/null
+    $here/ltp/fsx $_param -P "$RESULT_DIR" $seq.$_n $FSX_AVOID &>/dev/null
+    local res=$?
+    if [ $res -ne 0 ]
     then
-	echo "    fsx ($_param) failed, $? - compare $seqres.$_n.{good,bad,fsxlog}"
+	echo "    fsx ($_param) failed, $res - compare $seqres.$_n.{good,bad,fsxlog}"
 	mv $out/$seq.$_n $seqres.$_n.full
 	od -xAx $seqres.$_n.full > $seqres.$_n.bad
 	od -xAx "$RESULT_DIR"/$seq.$_n.fsxgood > $seqres.$_n.good
diff --git a/tests/generic/112 b/tests/generic/112
index 971d0467..0e08cbf9 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -53,9 +53,11 @@ _do_test()
 
     # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
     cd $out
-    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>/dev/null
+    $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>/dev/null
+    local res=$?
+    if [ $res -ne 0 ]
     then
-	echo "    fsx ($_param) returned $? - see $seq.$_n.full"
+	echo "    fsx ($_param) returned $res - see $seq.$_n.full"
 	mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.full
 	status=1
 	exit
-- 
2.31.1

