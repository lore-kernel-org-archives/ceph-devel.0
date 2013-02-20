From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: eliminate sparse warnings
Date: Tue, 19 Feb 2013 18:45:58 -0600
Message-ID: <51241CC6.5090101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:39924 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933373Ab3BTAqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:46:01 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so9433131iea.28
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:46:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Eliminate most of the problems in the libceph code that cause sparse
to issue warnings.
    - Convert functions that are never referenced externally to have
      static scope.
    - Pass NULL rather than 0 for a pointer argument in one spot in
      ceph_monc_delete_snapid()

This partially resolves:
    http://tracker.ceph.com/issues/4184

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/crypto.c     |    7 ++++---
 net/ceph/messenger.c  |    2 +-
 net/ceph/mon_client.c |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index af14cb4..6e7a236 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -423,7 +423,8 @@ int ceph_encrypt2(struct ceph_crypto_key *secret,
void *dst, size_t *dst_len,
 	}
 }

-int ceph_key_instantiate(struct key *key, struct key_preparsed_payload
*prep)
+static int ceph_key_instantiate(struct key *key,
+				struct key_preparsed_payload *prep)
 {
 	struct ceph_crypto_key *ckey;
 	size_t datalen = prep->datalen;
@@ -458,12 +459,12 @@ err:
 	return ret;
 }

-int ceph_key_match(const struct key *key, const void *description)
+static int ceph_key_match(const struct key *key, const void *description)
 {
 	return strcmp(key->description, description) == 0;
 }

-void ceph_key_destroy(struct key *key) {
+static void ceph_key_destroy(struct key *key) {
 	struct ceph_crypto_key *ckey = key->payload.data;

 	ceph_crypto_key_destroy(ckey);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8a62a55..ab702cd 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -172,7 +172,7 @@ static void encode_my_addr(struct ceph_messenger *msgr)
  */
 static struct workqueue_struct *ceph_msgr_wq;

-void _ceph_msgr_exit(void)
+static void _ceph_msgr_exit(void)
 {
 	if (ceph_msgr_wq) {
 		destroy_workqueue(ceph_msgr_wq);
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 812eb3b..aef5b10 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -697,7 +697,7 @@ int ceph_monc_delete_snapid(struct ceph_mon_client
*monc,
 			    u32 pool, u64 snapid)
 {
 	return do_poolop(monc,  POOL_OP_CREATE_UNMANAGED_SNAP,
-				   pool, snapid, 0, 0);
+				   pool, snapid, NULL, 0);

 }

-- 
1.7.9.5

