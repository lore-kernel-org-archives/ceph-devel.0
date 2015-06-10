From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: fix wrong name "Ceph filesystem for Linux"
Date: Wed, 10 Jun 2015 16:37:45 +0300
Message-ID: <CAOi1vP_HidOFR+VeuhyHmVqk=uQUtDdbrBGqmCZo9hu9Jkvp9g@mail.gmail.com>
References: <1433942005-15368-1-git-send-email-zhiguohong@tencent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:36461 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbbFJNhq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 09:37:46 -0400
Received: by wgbgq6 with SMTP id gq6so36088621wgb.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 06:37:45 -0700 (PDT)
In-Reply-To: <1433942005-15368-1-git-send-email-zhiguohong@tencent.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Hong Zhiguo <honkiko@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Hong Zhiguo <zhiguohong@tencent.com>

On Wed, Jun 10, 2015 at 4:13 PM, Hong Zhiguo <honkiko@gmail.com> wrote:
> modinfo libceph prints the module name "Ceph filesystem for Linux",
> which is same as the real fs module ceph. It's confusing.
>
> Signed-off-by: Hong Zhiguo <zhiguohong@tencent.com>
> ---
>  net/ceph/ceph_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index 925d0c8..cb7db32 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -741,5 +741,5 @@ module_exit(exit_ceph_lib);
>  MODULE_AUTHOR("Sage Weil <sage@newdream.net>");
>  MODULE_AUTHOR("Yehuda Sadeh <yehuda@hq.newdream.net>");
>  MODULE_AUTHOR("Patience Warnick <patience@newdream.net>");
> -MODULE_DESCRIPTION("Ceph filesystem for Linux");
> +MODULE_DESCRIPTION("Ceph core library");
>  MODULE_LICENSE("GPL");

Applied.

Thanks,

                Ilya
