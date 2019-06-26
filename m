From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: take over for Zheng as CephFS kernel client
 maintainer
Date: Wed, 26 Jun 2019 22:25:37 +0800
Message-ID: <fabceaeb-abe8-243a-8978-157cbd0bbcca@redhat.com>
References: <20190626112633.12267-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626112633.12267-1-jlayton@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 6/26/19 7:26 PM, Jeff Layton wrote:
> Zheng wants to be able to spend more time working on the MDS, so I've
> volunteered to take over for him as the CephFS kernel client maintainer.
> 

ACK

Thanks
Yan, Zheng

> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Zheng, I'm assuming for now that you don't want to stay on as
> co-maintainer. Let me know if that's incorrect and I'll resend.
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d0ed735994a5..8836f9eb2ff0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3715,7 +3715,7 @@ F:	arch/powerpc/platforms/cell/
>   
>   CEPH COMMON CODE (LIBCEPH)
>   M:	Ilya Dryomov <idryomov@gmail.com>
> -M:	"Yan, Zheng" <zyan@redhat.com>
> +M:	Jeff Layton <jlayton@kernel.org>
>   M:	Sage Weil <sage@redhat.com>
>   L:	ceph-devel@vger.kernel.org
>   W:	http://ceph.com/
> @@ -3727,7 +3727,7 @@ F:	include/linux/ceph/
>   F:	include/linux/crush/
>   
>   CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
> -M:	"Yan, Zheng" <zyan@redhat.com>
> +M:	Jeff Layton <jlayton@kernel.org>
>   M:	Sage Weil <sage@redhat.com>
>   M:	Ilya Dryomov <idryomov@gmail.com>
>   L:	ceph-devel@vger.kernel.org
> 
