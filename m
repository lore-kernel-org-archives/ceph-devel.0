From: Alex Elder <elder@inktank.com>
Subject: [PATCH 11/16] ceph: ensure auth ops are defined before use
Date: Thu, 17 May 2012 09:05:02 -0500
Message-ID: <4FB5058E.4020800@inktank.com>
References: <4FB50329.7010206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34817 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676Ab2EQOE7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 10:04:59 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so1802686ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 07:04:59 -0700 (PDT)
In-Reply-To: <4FB50329.7010206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In the create_authorizer method for both the mds and osd clients,
the auth_client->ops pointer is blindly dereferenced.  There is no
obvious guarantee that this pointer has been assigned.  And
furthermore, even if the ops pointer is non-null there is definitely
no guarantee that the create_authorizer or destroy_authorizer
methods are defined.

Add checks in both routines to make sure they are defined (non-null)
before use.  Add similar checks in a few other spots in these files
while we're at it.

Signed-off-by: Alex Elder <elder@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
  fs/ceph/mds_client.c  |   14 ++++++--------
  net/ceph/osd_client.c |   15 ++++++++++-----
  2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b71ffd2..4622817 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3406,16 +3406,14 @@ static int get_authorizer(struct ceph_connection 
*con,
  	int ret = 0;

  	if (force_new && auth->authorizer) {
-		ac->ops->destroy_authorizer(ac, auth->authorizer);
+		if (ac->ops && ac->ops->destroy_authorizer)
+			ac->ops->destroy_authorizer(ac, auth->authorizer);
  		auth->authorizer = NULL;
  	}
-	if (auth->authorizer == NULL) {
-		if (ac->ops->create_authorizer) {
-			ret = ac->ops->create_authorizer(ac,
-						CEPH_ENTITY_TYPE_MDS, auth);
-			if (ret)
-				return ret;
-		}
+	if (!auth->authorizer && ac->ops && ac->ops->create_authorizer) {
+		ret = ac->ops->create_authorizer(ac, CEPH_ENTITY_TYPE_MDS, auth);
+		if (ret)
+			return ret;
  	}

  	*proto = ac->protocol;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2da4b9e..f640bdf 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -664,10 +664,10 @@ static void put_osd(struct ceph_osd *osd)
  {
  	dout("put_osd %p %d -> %d\n", osd, atomic_read(&osd->o_ref),
  	     atomic_read(&osd->o_ref) - 1);
-	if (atomic_dec_and_test(&osd->o_ref)) {
+	if (atomic_dec_and_test(&osd->o_ref) && osd->o_auth.authorizer) {
  		struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;

-		if (osd->o_auth.authorizer)
+		if (ac->ops && ac->ops->destroy_authorizer)
  			ac->ops->destroy_authorizer(ac, osd->o_auth.authorizer);
  		kfree(osd);
  	}
@@ -2119,10 +2119,11 @@ static int get_authorizer(struct ceph_connection 
*con,
  	int ret = 0;

  	if (force_new && auth->authorizer) {
-		ac->ops->destroy_authorizer(ac, auth->authorizer);
+		if (ac->ops && ac->ops->destroy_authorizer)
+			ac->ops->destroy_authorizer(ac, auth->authorizer);
  		auth->authorizer = NULL;
  	}
-	if (auth->authorizer == NULL) {
+	if (!auth->authorizer && ac->ops && ac->ops->create_authorizer) {
  		ret = ac->ops->create_authorizer(ac, CEPH_ENTITY_TYPE_OSD, auth);
  		if (ret)
  			return ret;
@@ -2144,6 +2145,10 @@ static int verify_authorizer_reply(struct 
ceph_connection *con, int len)
  	struct ceph_osd_client *osdc = o->o_osdc;
  	struct ceph_auth_client *ac = osdc->client->monc.auth;

+	/*
+	 * XXX If ac->ops or ac->ops->verify_authorizer_reply is null,
+	 * XXX which do we do:  succeed or fail?
+	 */
  	return ac->ops->verify_authorizer_reply(ac, o->o_auth.authorizer, len);
  }

@@ -2153,7 +2158,7 @@ static int invalidate_authorizer(struct 
ceph_connection *con)
  	struct ceph_osd_client *osdc = o->o_osdc;
  	struct ceph_auth_client *ac = osdc->client->monc.auth;

-	if (ac->ops->invalidate_authorizer)
+	if (ac->ops && ac->ops->invalidate_authorizer)
  		ac->ops->invalidate_authorizer(ac, CEPH_ENTITY_TYPE_OSD);

  	return ceph_monc_validate_auth(&osdc->client->monc);
-- 
1.7.5.4

