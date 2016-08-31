From: Jeff Layton <jlayton@samba.org>
Subject: [samba RFC PATCH 1/6] vfs:ceph: add configure test for ceph_statx
Date: Wed, 31 Aug 2016 09:01:09 -0400
Message-ID: <1472648474-3131-2-git-send-email-jlayton@samba.org>
References: <1472648474-3131-1-git-send-email-jlayton@samba.org>
Return-path: <samba-technical-bounces@lists.samba.org>
In-Reply-To: <1472648474-3131-1-git-send-email-jlayton@samba.org>
List-Unsubscribe: <https://lists.samba.org/mailman/options/samba-technical>,
 <mailto:samba-technical-request@lists.samba.org?subject=unsubscribe>
List-Archive: <http://lists.samba.org/pipermail/samba-technical/>
List-Post: <mailto:samba-technical@lists.samba.org>
List-Help: <mailto:samba-technical-request@lists.samba.org?subject=help>
List-Subscribe: <https://lists.samba.org/mailman/listinfo/samba-technical>,
 <mailto:samba-technical-request@lists.samba.org?subject=subscribe>
Errors-To: samba-technical-bounces@lists.samba.org
Sender: "samba-technical" <samba-technical-bounces@lists.samba.org>
To: samba-technical@lists.samba.org
Cc: ceph-devel@vger.kernel.org, ira@wakeful.net
List-Id: ceph-devel.vger.kernel.org

...so we can conditionally compile in its use.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 source3/wscript | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/source3/wscript b/source3/wscript
index 5ce1b77e23b1..c6b2421c45b7 100644
--- a/source3/wscript
+++ b/source3/wscript
@@ -1582,6 +1582,8 @@ main() {
     if conf.CHECK_HEADERS('cephfs/libcephfs.h', False, False, 'cephfs') and conf.CHECK_LIB('cephfs', shlib=True) and Options.options.with_cephfs:
         if Options.options.with_acl_support:
             conf.DEFINE('HAVE_CEPH', '1')
+            if conf.CHECK_FUNCS_IN('ceph_statx', 'cephfs', headers='cephfs/libcephfs.h'):
+                conf.DEFINE('HAVE_CEPH_STATX', '1')
         else:
             Logs.warn("ceph support disabled due to --without-acl-support")
             conf.undefine('HAVE_CEPH')
-- 
2.7.4
