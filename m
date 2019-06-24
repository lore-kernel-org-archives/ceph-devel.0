From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v4 0/3] ceph: don't NULL terminate virtual xattrs
Date: Mon, 24 Jun 2019 12:27:23 -0400
Message-ID: <20190624162726.17413-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

v4: resurrect snprintf_noterm as static function that uses a
    fixed-size intermediate buffer.
    Return -E2BIG and WARN if the formatted string exceeds temp buffer.
    make getxattr_cb callbacks return ssize_t.
v3: switch to using an intermediate buffer for snprintf destination
    add patch to fix ceph_vxattrcb_layout return value
v2: drop bogus EXPORT_SYMBOL of static function

This is the 4th posting of this patchset. In this variant, we add a new
variatic static function that uses an internal buffer and calls
vsnprintf to do the formatting, and then memcpys the result into the
buffer. This also adds a bit of type-sanity cleanup of the vxattr
handling in general.

Most of the rationale for this set is in the description of the last
patch of the series.

Jeff Layton (3):
  ceph: make getxattr_cb return ssize_t
  ceph: return -ERANGE if virtual xattr value didn't fit in buffer
  ceph: don't NULL terminate virtual xattrs

 fs/ceph/xattr.c | 182 ++++++++++++++++++++++++++++--------------------
 1 file changed, 108 insertions(+), 74 deletions(-)

-- 
2.21.0
