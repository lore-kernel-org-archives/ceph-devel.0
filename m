From: Jan Kara <jack@suse.cz>
Subject: [PATCH 12/15] mm: Add variant of
 pagevec_lookup_range_tag() taking number of pages
Date: Thu, 14 Sep 2017 15:18:16 +0200
Message-ID: <20170914131819.26266-13-jack@suse.cz>
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

Currently pagevec_lookup_range_tag() takes number of pages to look up
but most users don't need this. Create a new function
pagevec_lookup_range_nr_tag() that takes maximum number of pages to
lookup for Ceph which wants this functionality so that we can drop
nr_pages argument from pagevec_lookup_range_tag().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/pagevec.h | 3 +++
 mm/swap.c               | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 371edacc10d5..0281b1d3a91b 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -40,6 +40,9 @@ static inline unsigned pagevec_lookup(struct pagevec *pvec,
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
 		int tag, unsigned nr_pages);
+unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
+		struct address_space *mapping, pgoff_t *index, pgoff_t end,
+		int tag, unsigned max_pages);
 static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, int tag,
 		unsigned nr_pages)
diff --git a/mm/swap.c b/mm/swap.c
index a00065f2a8f2..97186da8e5bd 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -996,6 +996,15 @@ unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 }
 EXPORT_SYMBOL(pagevec_lookup_range_tag);
 
+unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
+		struct address_space *mapping, pgoff_t *index, pgoff_t end,
+		int tag, unsigned max_pages)
+{
+	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
+		min_t(unsigned int, max_pages, PAGEVEC_SIZE), pvec->pages);
+	return pagevec_count(pvec);
+}
+EXPORT_SYMBOL(pagevec_lookup_range_tag);
 /*
  * Perform any setup for the swap system
  */
-- 
2.12.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
