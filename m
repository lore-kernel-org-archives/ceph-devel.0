From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/1 linux-next] ceph: use standard Opt_err
Date: Mon, 8 Jun 2015 10:49:13 +0300
Message-ID: <CAOi1vP8Bm05VQFy-fcZmaZS9N=_k6WcfOK5D4Wpw3zgtwfVoBw@mail.gmail.com>
References: <1433531567-3948-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433531567-3948-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Jun 5, 2015 at 10:12 PM, Fabian Frederick <fabf@skynet.be> wrote:
> ceph used -1 for the last match_table_t option.
> Use Opt_err enum like other FS
>
> match_token() is based on the pattern (NULL)
> so behavior should remain the same.
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> This is untested. If this one is ok, I can send the same update
> for rbd and net/ceph.
>
>  fs/ceph/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 4e99053..35ef692 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -137,7 +137,8 @@ enum {
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
>         Opt_acl,
>  #endif
> -       Opt_noacl
> +       Opt_noacl,
> +       Opt_err
>  };
>
>  static match_table_t fsopt_tokens = {
> @@ -169,7 +170,7 @@ static match_table_t fsopt_tokens = {
>         {Opt_acl, "acl"},
>  #endif
>         {Opt_noacl, "noacl"},
> -       {-1, NULL}
> +       {Opt_err, NULL}
>  };
>
>  static int parse_fsopt_token(char *c, void *private)

This would result in a BUG on any unknown option - match_token->token
is what match_token() returns and parse_fsopt_token() clearly expects
that to be a negative value.

Thanks,

                Ilya
