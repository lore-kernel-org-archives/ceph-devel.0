From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Date: Wed, 19 Jun 2019 12:45:25 -0400
Message-ID: <20190619164528.31958-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com, joe@perches.com, pmladek@suse.com, rostedt@goodmis.org, geert+renesas@glider.be, andriy.shevchenko@linux.intel.com
List-Id: ceph-devel.vger.kernel.org

v2: drop bogus EXPORT_SYMBOL of static function

The only real difference between this set and the one I sent originally
is the removal of a spurious EXPORT_SYMBOL in the snprintf patch.

I'm mostly sending this with a wider cc list in an effort to get a
review from the maintainers of the printf code. Basically ceph needs a
snprintf variant that does not NULL terminate in order to handle its
virtual xattrs.

Joe Perches had expressed some concerns about stack usage in vsnprintf
with this, but I'm not sure I really understand the basis of that
concern. If it is problematic, then I could use suggestions as to how
best to fix that up.

----------------------------8<-----------------------------

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
 lib/vsprintf.c         | 144 ++++++++++++++++++++++++++++-------------
 3 files changed, 129 insertions(+), 66 deletions(-)

-- 
2.21.0
