From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] ceph: don't NULL terminate virtual xattr values
Date: Fri, 14 Jun 2019 09:46:22 -0400
Message-ID: <20190614134625.6870-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: akpm@linux-foundation.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com
List-Id: ceph-devel.vger.kernel.org

kcephfs has several "virtual" xattrs that return strings that are
currently populated using snprintf(), which always NULL terminates the
string.

This leads to the string being truncated when we use a buffer length
acquired by calling getxattr with a 0 size first. The last character
of the string ends up being clobbered by the termination.

The convention with xattrs is to not store the termination with string
data, given that we have the length. This is how setfattr/getfattr
operate.

This patch makes ceph's virtual xattrs not include NULL termination
when formatting their values. In order to handle this, a new
snprintf_noterm function is added, and ceph is changed over to use
this to populate the xattr value buffer. Finally, we fix ceph to
return -ERANGE properly when the string didn't fit in the buffer.

Jeff Layton (3):
  lib/vsprintf: add snprintf_noterm
  ceph: don't NULL terminate virtual xattr strings
  ceph: return -ERANGE if virtual xattr value didn't fit in buffer

 fs/ceph/xattr.c        |  49 +++++++-------
 include/linux/kernel.h |   2 +
 lib/vsprintf.c         | 145 ++++++++++++++++++++++++++++-------------
 3 files changed, 130 insertions(+), 66 deletions(-)

-- 
2.21.0
