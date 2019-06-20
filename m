From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] ceph: don't NULL terminate virtual xattr values
Date: Thu, 20 Jun 2019 13:24:10 +0300
Message-ID: <20190620102410.GT9224@smile.fi.intel.com>
References: <20190619164528.31958-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190619164528.31958-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, idryomov@gmail.com, zyan@redhat.com, sage@redhat.com, agruenba@redhat.com, joe@perches.com, pmladek@suse.com, rostedt@goodmis.org, geert+renesas@glider.be
List-Id: ceph-devel.vger.kernel.org

On Wed, Jun 19, 2019 at 12:45:25PM -0400, Jeff Layton wrote:
> v2: drop bogus EXPORT_SYMBOL of static function
> 
> The only real difference between this set and the one I sent originally
> is the removal of a spurious EXPORT_SYMBOL in the snprintf patch.
> 
> I'm mostly sending this with a wider cc list in an effort to get a
> review from the maintainers of the printf code. Basically ceph needs a
> snprintf variant that does not NULL terminate in order to handle its
> virtual xattrs.
> 

> Joe Perches had expressed some concerns about stack usage in vsnprintf
> with this, but I'm not sure I really understand the basis of that
> concern. If it is problematic, then I could use suggestions as to how
> best to fix that up.

It might be problematic, since vsnprintf() can be called recursively.

> ----------------------------8<-----------------------------
> 
> kcephfs has several "virtual" xattrs that return strings that are
> currently populated using snprintf(), which always NULL terminates the
> string.
> 
> This leads to the string being truncated when we use a buffer length
> acquired by calling getxattr with a 0 size first. The last character
> of the string ends up being clobbered by the termination.

So, then don't use snprintf() for this, simple memcpy() designed for that kind
of things.

> The convention with xattrs is to not store the termination with string
> data, given that we have the length. This is how setfattr/getfattr
> operate.

Fine.

> This patch makes ceph's virtual xattrs not include NULL termination
> when formatting their values. In order to handle this, a new
> snprintf_noterm function is added, and ceph is changed over to use
> this to populate the xattr value buffer.

In terms of vsnprintf(), and actually compiler point of view, it's not a string
anymore, it's a text-based data.

Personally, I don't see an advantage of a deep intrusion into vsnprintf().
The wrapper can be made to achieve this w/o touching the generic code. Thus,
you can quickly and cleanly fix the issue, while discussing this with wider
audience.

> Finally, we fix ceph to
> return -ERANGE properly when the string didn't fit in the buffer.
> 
> Jeff Layton (3):
>   lib/vsprintf: add snprintf_noterm
>   ceph: don't NULL terminate virtual xattr strings
>   ceph: return -ERANGE if virtual xattr value didn't fit in buffer
> 
>  fs/ceph/xattr.c        |  49 +++++++-------
>  include/linux/kernel.h |   2 +
>  lib/vsprintf.c         | 144 ++++++++++++++++++++++++++++-------------
>  3 files changed, 129 insertions(+), 66 deletions(-)
> 
> -- 
> 2.21.0
> 

-- 
With Best Regards,
Andy Shevchenko
