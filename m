From: Jan Kara <jack@suse.cz>
Subject: [PATCH 13/15] ceph: Use pagevec_lookup_range_nr_tag()
Date: Thu, 14 Sep 2017 15:18:17 +0200
Message-ID: <20170914131819.26266-14-jack@suse.cz>
References: <20170914131819.26266-1-jack@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20170914131819.26266-1-jack@suse.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-mm@kvack.org
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net, "Yan,
 Zheng" <zyan@redhat.com>, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

Use new function for looking up pages since nr_pages argument from
pagevec_lookup_range_tag() is going away.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ceph/addr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e57e9d37bf2d..87789c477381 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -869,11 +869,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 		max_pages = wsize >> PAGE_SHIFT;
 
 get_more_pages:
-		pvec_pages = min_t(unsigned, PAGEVEC_SIZE,
-				   max_pages - locked_pages);
-		pvec_pages = pagevec_lookup_range_tag(&pvec, mapping, &index,
+		pvec_pages = pagevec_lookup_range_nr_tag(&pvec, mapping, &index,
 						end, PAGECACHE_TAG_DIRTY,
-						pvec_pages);
+						max_pages - locked_pages);
 		dout("pagevec_lookup_range_tag got %d\n", pvec_pages);
 		if (!pvec_pages && !locked_pages)
 			break;
-- 
2.12.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
