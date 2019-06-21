From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] ceph: don't NULL terminate virtual xattr values
Date: Fri, 21 Jun 2019 10:18:31 -0400
Message-ID: <20190621141833.17551-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com, joe@perches.com, geert+renesas@glider.be, andriy.shevchenko@linux.intel.com
List-Id: ceph-devel.vger.kernel.org

v3: switch to using an intermediate buffer for snprintf destination
    add patch to fix ceph_vxattrcb_layout return value
v2: drop bogus EXPORT_SYMBOL of static function

This is the 3rd posting of this patchset. Instead of adding a new
snprintf variant that doesn't NULL terminate, this set instead has
the vxattr handlers use an intermediate buffer as the snprintf
destination and then memcpy's the result into the destination buffer.

Also, I added a patch to fix up the return of ceph_vxattrcb_layout. The
existing code actually worked, but relied on casting a signed negative
value to unsigned and back, which seemed a little sketchy.

Most of the rationale for this set is in the description of the first
patch of the series.

Jeff Layton (2):
  ceph: fix buffer length handling in virtual xattrs
  ceph: fix return of ceph_vxattrcb_layout

 fs/ceph/xattr.c | 113 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 32 deletions(-)

-- 
2.21.0
