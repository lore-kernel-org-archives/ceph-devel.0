From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH v2] src/seek_sanity_test: ensure file size is big enough
Date: Mon,  8 May 2017 16:12:27 +0100
Message-ID: <20170508151227.16881-1-lhenriques@suse.com>
References: <20170508104728.GW7250@eguan.usersys.redhat.com>
Return-path: <fstests-owner@vger.kernel.org>
In-Reply-To: <20170508104728.GW7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, fstests@vger.kernel.org, ceph-devel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Tests test07, test08, and test09 preallocate a file and assume the file
size used is bigger than 10xbufsz (100xbufsz for test09).  This patch
adjusts the file size so this assumption is always true.

As an example, here's test07 output for cephfs, where the allocation size
is set to 4194304, and the output is (4194304 * 10 + 4194304)

  07. Test file with unwritten extents, only have dirty pages
  07.01 SEEK_HOLE expected 0 or 4194304, got 46137344.              FAIL
  07.02 SEEK_HOLE expected 1 or 4194304, got 46137344.              FAIL

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
changes since v1:
 - Adjust max file size directly instead of looping
 - Drop integer overflow test
 - Updated changelog

 src/seek_sanity_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index a6dd48cc257b..0f5c22e7f450 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -280,7 +280,7 @@ static int test09(int fd, int testnum)
 	int ret = 0;
 	char *buf = NULL;
 	int bufsz = alloc_size;
-	int filsz = 8 << 20;
+	int filsz = bufsz * 100 + bufsz;
 
 	/*
 	 * HOLE - unwritten DATA in dirty page - HOLE -
@@ -336,7 +336,7 @@ static int test08(int fd, int testnum)
 	int ret = 0;
 	char *buf = NULL;
 	int bufsz = alloc_size;
-	int filsz = 4 << 20;
+	int filsz = bufsz * 10 + bufsz;
 
 	/* HOLE - unwritten DATA in writeback page */
 	/* Each unit is bufsz */
@@ -385,7 +385,7 @@ static int test07(int fd, int testnum)
 	int ret = 0;
 	char *buf = NULL;
 	int bufsz = alloc_size;
-	int filsz = 4 << 20;
+	int filsz = bufsz * 10 + bufsz;
 
 	/* HOLE - unwritten DATA in dirty page */
 	/* Each unit is bufsz */
