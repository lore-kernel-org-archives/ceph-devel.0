From: Sage Weil <sage@newdream.net>
Subject: [PATCH 0/4] More RBD updates
Date: Thu, 15 Sep 2011 14:11:07 -0700
Message-ID: <1316121071-7690-1-git-send-email-sage@newdream.net>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>
List-Id: ceph-devel.vger.kernel.org

Hi,

Here are a few more improvements to the qemu rbd support.  The first 
patch makes the configuration file handling cleaner (do not error out if 
/etc/ceph/ceph.conf doesn't exist).  One allows characters in the conf 
string to be escaped, so you can (for example) specify an ip\:port (':' 
is used as a delimiter).

The last patch implements flush when rbd_flush() is available.  This lets 
us take advantage of write buffering in newer versions of librbd, which 
improves performance significantly for many workloads (including the 
trivial qemu-img convert).

Thanks!
sage


Sage Weil (4):
  rbd: ignore failures when reading from default conf location
  rbd: allow escaping in config string
  rbd: update comment heading
  rbd: call flush, if available

 block/rbd.c |   83 +++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 56 insertions(+), 27 deletions(-)

-- 
1.7.2.5
