From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/2] CacheFiles: Don't try to dump the index
 key if the cookie has been cleared
Date: Fri, 20 Sep 2013 14:18:00 +0100
Message-ID: <20130920131800.24001.38851.stgit@warthog.procyon.org.uk>
References: <20130920131752.24001.87500.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <20130920131752.24001.87500.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: torvalds@linux-foundation.org
Cc: ceph-devel@vger.kernel.org, linux-cachefs@redhat.com, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Don't try to dump the index key that distinguishes an object if netfs data in
the cookie the object refers to has been cleared (ie. the cookie has passed
most of the way through __fscache_relinquish_cookie()).

Since the netfs holds the index key, we can't get at it once the ->def and
->netfs_data pointers have been cleared - and a NULL pointer exception will
ensue, usually just after a:

	CacheFiles: Error: Unexpected object collision

error is reported.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 25badd1..f4a08d7 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -56,7 +56,7 @@ void __cachefiles_printk_object(struct cachefiles_object *object,
 		       object->fscache.cookie->parent,
 		       object->fscache.cookie->netfs_data,
 		       object->fscache.cookie->flags);
-		if (keybuf)
+		if (keybuf && cookie->def)
 			keylen = cookie->def->get_key(cookie->netfs_data, keybuf,
 						      CACHEFILES_KEYBUF_SIZE);
 		else
