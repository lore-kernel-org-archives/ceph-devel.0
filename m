From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v3 0/2] ceph: don't NULL terminate virtual xattr values
Date: Mon, 24 Jun 2019 16:56:52 +0800
Message-ID: <CAAM7YAmfb0ZoaGMqHE8POFbHUFNvzz+eP3Ygsq-ncRptq6wN7w@mail.gmail.com>
References: <20190621141833.17551-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621141833.17551-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Zheng Yan <zyan@redhat.com>, Sage Weil <sage@redhat.com>, agruenba@redhat.com, joe@perches.com, geert+renesas@glider.be, andriy.shevchenko@linux.intel.com
List-Id: ceph-devel.vger.kernel.org

On Fri, Jun 21, 2019 at 10:21 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> v3: switch to using an intermediate buffer for snprintf destination
>     add patch to fix ceph_vxattrcb_layout return value
> v2: drop bogus EXPORT_SYMBOL of static function
>
> This is the 3rd posting of this patchset. Instead of adding a new
> snprintf variant that doesn't NULL terminate, this set instead has
> the vxattr handlers use an intermediate buffer as the snprintf
> destination and then memcpy's the result into the destination buffer.
>
> Also, I added a patch to fix up the return of ceph_vxattrcb_layout. The
> existing code actually worked, but relied on casting a signed negative
> value to unsigned and back, which seemed a little sketchy.
>
> Most of the rationale for this set is in the description of the first
> patch of the series.
>
> Jeff Layton (2):
>   ceph: fix buffer length handling in virtual xattrs
>   ceph: fix return of ceph_vxattrcb_layout
>
>  fs/ceph/xattr.c | 113 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 81 insertions(+), 32 deletions(-)
>

Reviewed-by
> --
> 2.21.0
>
