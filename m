From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 0/3] ceph: don't NULL terminate virtual xattr values
Date: Fri, 14 Jun 2019 18:56:34 +0200
Message-ID: <CAHc6FU5QVQQ43TZNZ7A53D3Ka3e_qq9GEtV_fZt7C5A+xrWm_A@mail.gmail.com>
References: <20190614134625.6870-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614134625.6870-1-jlayton@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
List-Id: ceph-devel.vger.kernel.org

On Fri, 14 Jun 2019 at 15:46, Jeff Layton <jlayton@kernel.org> wrote:
> kcephfs has several "virtual" xattrs that return strings that are
> currently populated using snprintf(), which always NULL terminates the
> string.
>
> This leads to the string being truncated when we use a buffer length
> acquired by calling getxattr with a 0 size first. The last character
> of the string ends up being clobbered by the termination.
>
> The convention with xattrs is to not store the termination with string
> data, given that we have the length. This is how setfattr/getfattr
> operate.
>
> This patch makes ceph's virtual xattrs not include NULL termination
> when formatting their values. In order to handle this, a new
> snprintf_noterm function is added, and ceph is changed over to use
> this to populate the xattr value buffer. Finally, we fix ceph to
> return -ERANGE properly when the string didn't fit in the buffer.

This looks reasonable from an xattr point of view.

Thanks,
Andreas

> Jeff Layton (3):
>   lib/vsprintf: add snprintf_noterm
>   ceph: don't NULL terminate virtual xattr strings
>   ceph: return -ERANGE if virtual xattr value didn't fit in buffer
>
>  fs/ceph/xattr.c        |  49 +++++++-------
>  include/linux/kernel.h |   2 +
>  lib/vsprintf.c         | 145 ++++++++++++++++++++++++++++-------------
>  3 files changed, 130 insertions(+), 66 deletions(-)
>
> --
> 2.21.0
>
