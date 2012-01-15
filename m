From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH RESEND] ceph: fix length validation in parse_reply_info()
Date: Sat, 14 Jan 2012 21:18:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201142117210.24825@cobra.newdream.net>
References: <1326597659-3892-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326597659-3892-1-git-send-email-xi.wang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Sat, 14 Jan 2012, Xi Wang wrote:
> "len" is read from network and thus needs validation.  Otherwise, given
> a bogus "len" value, p+len could be an out-of-bounds pointer, which is
> used in further parsing.
> 
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Applied.  Sorry I missed this the first time around!

sage


> ---
>  fs/ceph/mds_client.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 23ab6a3..3cc9b0b 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -262,6 +262,7 @@ static int parse_reply_info(struct ceph_msg *msg,
>  	/* trace */
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
> +		ceph_decode_need(&p, end, len, bad);
>  		err = parse_reply_info_trace(&p, p+len, info, features);
>  		if (err < 0)
>  			goto out_bad;
> @@ -270,6 +271,7 @@ static int parse_reply_info(struct ceph_msg *msg,
>  	/* extra */
>  	ceph_decode_32_safe(&p, end, len, bad);
>  	if (len > 0) {
> +		ceph_decode_need(&p, end, len, bad);
>  		err = parse_reply_info_extra(&p, p+len, info, features);
>  		if (err < 0)
>  			goto out_bad;
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
