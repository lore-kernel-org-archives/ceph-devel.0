Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E34E533B;
	Mon, 19 Oct 2026 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409655; cv=none; b=BsRIw+kmIEK/Q9n2xzkxhnVuDS505L2KKHtDvy87TuHjHRFFdxogDbbxTS59GlAkkBEmTCrUEI4F/O662bUYF4BNhFrF9W4RzVJ98BzwEyoSpZvihh7DrVypAC2IAQ0RQpnTN2L6aMO0FauUOAYnWF4tvCseDv/+zBD8UqPFVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409655; c=relaxed/simple;
	bh=/4SCbq/zdtyk3n0Y6fBABlY63ZRO3tVyZfGklmriDnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCORvkf/hIZUG4R46a2cQmums9BIKfLrKLK0s3OiM25JJEjwFcONSArCAOGNT28j8uhsl/bs2yr49TaAxj4/SG31+aqIvfsd+kZ/t6Mm81RAl7Ud9+3tS8ELjwAhgRh4HncIG0hHkdUYJNdmhhNmslFYpzXvLZxo/pHfO2Yixsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMGOt7uu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMGOt7uu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF5FFC2BCFC;
	Mon, 19 Oct 2026 11:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792409654;
	bh=/4SCbq/zdtyk3n0Y6fBABlY63ZRO3tVyZfGklmriDnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eMGOt7uu0+wiP0QvJOVYIXKXzQNCW8aas1zKn7JtgcpezW3gcwbiwjaPwvC+bXHP+
	 KcwHH2P3BveUhJ832X+GkPE3Y5RyI4dWtlmp1ZZz+gyvBG7e0vDlhxQqPo9PjbG3je
	 F3M+HyccvExPFngP2nbaSx4B9fq0cSQBmIAv45r6+UnYM+/owMH8FbDtGsN60trDfG
	 9x7aVdAAu2k8K1MnHz4yFnPtM5DXwlrh2HHZHPvLKtuhQQoh4MXbuBuuDYlEhtTaCe
	 ylJqX3RiDBnTUFYpcxptXUVn4aT6Jf8S4uW3B8tSdTEPK43LargsCbqVzwZ+vVyTmq
	 cosbx6Ph9r+dw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E74CCF2E5;
	Mon, 19 Oct 2026 11:34:14 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Mon, 19 Oct 2026 13:33:29 +0200
Subject: [PATCH v2 3/4] ceph: flush the OSD completions before destroying
 the mds client
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-ceph-metrics-percpu-v2-3-1fa5229b00b8@clyso.com>
References: <20261019-ceph-metrics-percpu-v2-0-1fa5229b00b8@clyso.com>
In-Reply-To: <20261019-ceph-metrics-percpu-v2-0-1fa5229b00b8@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792409634; l=2730;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=AMNZbzcI99MT7gaoeLTpmc778lbbAGtoVQURA0nX2pU=;
 b=LXrgnAu0LS/CG2KhY8OO16MQQXFRUUdNmxFexOLKFGSBF62BLQXSFNMOBGnOPuPvBNZaUCUYM
 Y7QVku/x1r1Cr9JR/LDjK+k6I6wdWyReGWG3zwtNiyZ3gRpj5juIL4N
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

The callbacks of OSD requests that complete with an error, or that are
aborted, are run from osdc->completion_wq instead of the messenger.
Like the ones run from the messenger, the read and write ones update the
client metrics in mdsc->metric and mdsc->subvol_metrics.

ceph_mdsc_destroy() only flushes the messenger before it frees those and
mdsc itself, while completion_wq keeps running until ceph_osdc_stop()
destroys it from ceph_destroy_client(), long after.  A callback still
queued there then updates freed memory.

Add ceph_osdc_flush_completions() to libceph and call it right after
ceph_msgr_flush() in ceph_mdsc_destroy().

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c            |  2 ++
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/osd_client.c           | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d4ef8a355a48..b62291f0e351 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7046,6 +7046,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
 
 	/* flush out any connection work with references to us */
 	ceph_msgr_flush();
+	/* and the OSD request callbacks that update our metrics */
+	ceph_osdc_flush_completions(&fsc->client->osdc);
 
 	/*
 	 * Mark reset as failed and wake any blocked waiters before
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 52eb76e9d62a..6028754efe6a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -585,6 +585,7 @@ extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
 extern void ceph_osdc_sync(struct ceph_osd_client *osdc);
 
 extern void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc);
+extern void ceph_osdc_flush_completions(struct ceph_osd_client *osdc);
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc);
 
 int ceph_osdc_call(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5f2c561ff4e2..ec5e8870ec6f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5164,6 +5164,17 @@ void ceph_osdc_flush_notifies(struct ceph_osd_client *osdc)
 }
 EXPORT_SYMBOL(ceph_osdc_flush_notifies);
 
+/*
+ * Wait for the request callbacks queued on completion_wq to finish - for
+ * use before freeing what those callbacks touch
+ */
+void ceph_osdc_flush_completions(struct ceph_osd_client *osdc)
+{
+	dout("%s osdc %p\n", __func__, osdc);
+	flush_workqueue(osdc->completion_wq);
+}
+EXPORT_SYMBOL(ceph_osdc_flush_completions);
+
 void ceph_osdc_maybe_request_map(struct ceph_osd_client *osdc)
 {
 	down_read(&osdc->lock);

-- 
2.53.0


