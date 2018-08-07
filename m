From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH net-next] ceph: remove unnecessary non NULL check for request_key
Date: Tue, 7 Aug 2018 17:02:04 +0200
Message-ID: <CAOi1vP9Gbv-P=HLAKfr=MwPzTDHMpVmexPmf5TJLZhLfSvVttA@mail.gmail.com>
References: <20180807130234.5380-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807130234.5380-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: "David S. Miller" <davem@davemloft.net>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, linux-kernel@vger.kernel.org, netdev <netdev@vger.kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Aug 7, 2018 at 3:03 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> request_key never return NULL,so no need do non-NULL check.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  net/ceph/ceph_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 584fdbe..9834edc 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -304,7 +304,7 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
>         struct ceph_crypto_key *ckey;
>
>         ukey = request_key(&key_type_ceph, name, NULL);
> -       if (!ukey || IS_ERR(ukey)) {
> +       if (IS_ERR(ukey)) {
>                 /* request_key errors don't map nicely to mount(2)
>                    errors; don't even try, but still printk */
>                 key_err = PTR_ERR(ukey);

Applied.

Thanks,

                Ilya
