From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] ceph: fix message length computation
Date: Thu, 1 Oct 2015 21:40:10 +0800
Message-ID: <CAAM7YAm-YrSrYuNiUEC7z8t3FC0j+9bFs9Tdf4PpmRy5CojyqA@mail.gmail.com>
References: <9959810.KasB66Ks40@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9959810.KasB66Ks40@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, y2038@lists.linaro.org, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Sep 30, 2015 at 9:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> create_request_message() computes the maximum length of a message,
> but uses the wrong type for the time stamp: sizeof(struct timespec)
> may be 8 or 16 depending on the architecture, while sizeof(struct
> ceph_timespec) is always 8, and that is what gets put into the
> message.
>
> Found while auditing the uses of timespec for y2038 problems.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b8e69066d8af ("ceph: include time stamp in every MDS request")
> ---
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 51cb02da75d9..fe2c982764e7 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1935,7 +1935,7 @@ static struct ceph_msg *create_request_message(struct ceph_mds_client *mdsc,
>
>         len = sizeof(*head) +
>                 pathlen1 + pathlen2 + 2*(1 + sizeof(u32) + sizeof(u64)) +
> -               sizeof(struct timespec);
> +               sizeof(struct ceph_timespec);
>
>         /* calculate (max) length for cap releases */
>         len += sizeof(struct ceph_mds_request_release) *
>

Applied. thanks

Yan, Zheng

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
