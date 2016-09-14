From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 01/47] block-rbd: Use kmalloc_array() in rbd_header_from_disk()
Date: Wed, 14 Sep 2016 17:25:02 +0200
Message-ID: <CAOi1vP_Awcjy_gtg9RrNz3_3J5EnDiT1hG4SWG20cF-mSKg7Gw@mail.gmail.com>
References: <566ABCD9.1060404@users.sourceforge.net> <57806eb1-10ed-582e-72d0-2975e1ee967a@users.sourceforge.net>
 <6917f8b0-6122-3b30-0dc1-0394b28a6f61@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6917f8b0-6122-3b30-0dc1-0394b28a6f61@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@kernel.org>, Sage Weil <sage@redhat.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: ceph-devel.vger.kernel.org

On Mon, Sep 12, 2016 at 8:42 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Sep 2016 12:21:25 +0200
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
>   This issue was detected by using the Coccinelle software.
>
> * Delete the local variable "size" which became unnecessary with
>   this refactoring.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Now applied.

Thanks,

                Ilya
