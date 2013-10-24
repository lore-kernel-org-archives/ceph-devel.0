From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] ceph: cleanup aborted requests when re-sending requests.
Date: Wed, 23 Oct 2013 17:54:08 -0700
Message-ID: <CAPYLRzj0u+zhUO5EK-Yov0KGDMURdvHaaOj-_2otpHAwzmQX0Q@mail.gmail.com>
References: <1380176736-2949-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:61688 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab3JXAyK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Oct 2013 20:54:10 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm4so1760219wib.6
        for <ceph-devel@vger.kernel.org>; Wed, 23 Oct 2013 17:54:08 -0700 (PDT)
In-Reply-To: <1380176736-2949-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

A little delayed, but Sage just pushed this into our testing repo. Thanks!
(Feel free to poke me in future if you know you have patches that have
been hanging for a while.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Sep 25, 2013 at 11:25 PM, Yan, Zheng <zheng.z.yan@intel.com> wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>
> Aborted requests usually get cleared when the reply is received.
> If MDS crashes, no reply will be received. So we need to cleanup
> aborted requests when re-sending requests.
>
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  fs/ceph/mds_client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f51ab26..b959966 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1875,8 +1875,11 @@ static int __do_request(struct ceph_mds_client *mdsc,
>         int mds = -1;
>         int err = -EAGAIN;
>
> -       if (req->r_err || req->r_got_result)
> +       if (req->r_err || req->r_got_result) {
> +               if (req->r_aborted)
> +                       __unregister_request(mdsc, req);
>                 goto out;
> +       }
>
>         if (req->r_timeout &&
>             time_after_eq(jiffies, req->r_started + req->r_timeout)) {
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
