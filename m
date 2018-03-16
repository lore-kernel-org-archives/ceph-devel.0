From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] ceph: only dirty ITER_IOVEC pages for direct read
Date: Thu, 15 Mar 2018 20:40:18 -0700
Message-ID: <20180316034018.GA1120@zzz.localdomain>
References: <20180316033212.30543-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <20180316033212.30543-1-zyan@redhat.com>
Resent-Message-ID: <Hd6aywyUE2B.A.gEF.VC0qaB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20180316034018.GA1120@zzz.localdomain
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, debian-kernel@lists.debian.org, kaipeng94@gmail.com, syzkaller@googlegroups.com
List-Id: ceph-devel.vger.kernel.org

Hi Yan,

On Fri, Mar 16, 2018 at 11:32:12AM +0800, Yan, Zheng wrote:
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Fixes for use-after-free bugs should be marked for stable.  The commit message
should also explain what is being fixed, exactly.  Mentioning that this bug was
found by syzkaller would also be useful, since people are looking out for those.

Thanks,

Eric
