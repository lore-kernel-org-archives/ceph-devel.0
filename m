From: KAMEI Hitoshi <hitoshi.kamei.xm@hitachi.com>
Subject: [PATCH 2/2] rbd: add 'thick' sysfs rbd device attribute
Date: Mon, 19 Mar 2018 21:01:34 +0900
Message-ID: <5AAFA69E.2050007@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, sage@redhat.com, elder@kernel.org, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

This patch adds the description of sysfs thick entry.

Signed-off-by: Hitoshi Kamei <hitoshi.kamei.xm@hitachi.com>
Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
---
 Documentation/ABI/testing/sysfs-bus-rbd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rbd b/Documentation/ABI/testing/sysfs-bus-rbd
index f208ac58d613..3023f39328b1 100644
--- a/Documentation/ABI/testing/sysfs-bus-rbd
+++ b/Documentation/ABI/testing/sysfs-bus-rbd
@@ -119,3 +119,9 @@ parent

 	Information identifying the chain of parent images in a layered rbd
 	image.  Entries are separated by empty lines.
+
+thick
+
+	Specifying thick-provision image by writing "1" to this file.
+	And, releasing the flag of thick-provision image by writing
+	"0" to this file.
-- 
2.15.1
