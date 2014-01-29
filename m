From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH v2] ceph: fix posix ACL hooks
Date: Wed, 29 Jan 2014 22:43:28 +0200
Message-ID: <CALFYKtCtTTuDwzFYdPHiNLh92iNjeTizVD6h4Q=DNuES+d_g0A@mail.gmail.com>
References: <CALFYKtDCNWK+9m5m3P01dcxOOV7iHFeNaOH=Q=6Pffuo8gmrMQ@mail.gmail.com>
	<1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1391013467-7598-1-git-send-email-ilya.dryomov@inktank.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dave Jones <davej@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Guangliang Zhao <lucienchao@gmail.com>, Li Wang <li.wang@ubuntykylin.com>, "Yan, Zheng" <zheng.z.yan@intel.com>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jan 29, 2014 at 6:37 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> From: Sage Weil <sage@inktank.com>
>
> The merge of 7221fe4c2 raced with upstream changes in the generic POSIX
> ACL code (2aeccbe95).  Update Ceph to use the new helpers as well by
> dropping the now-generic functions and setting the set_acl inode op.
>
> Signed-off-by: Sage Weil <sage@inktank.com>

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

Thanks,

                Ilya
