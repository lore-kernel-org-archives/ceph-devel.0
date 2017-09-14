From: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/15 v1] Ranged pagevec tagged lookup
Date: Thu, 14 Sep 2017 15:18:04 +0200
Message-ID: <20170914131819.26266-1-jack@suse.cz>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Jan Kara <jack@suse.cz>
List-Id: ceph-devel.vger.kernel.org

Hello,

This is second part of the split out of the larger series to clean up pagevec
APIs and provide ranged lookups. In this series I provide a ranged variant of
pagevec_lookup_tag() and use it in places where it makes sense. This series
removes some common code and it also has a potential for speeding up some
operations similarly as for pagevec_lookup_range() (but for now I can think
of only artificial cases where this happens).

I'd like to ask f2fs and Ceph people to have a look since changes there are
non-trivial. Review from other fs people is welcome.

Full series including dependencies can be also obtained from my git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git find_get_pages_range

Opinions and review welcome!

								Honza

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
