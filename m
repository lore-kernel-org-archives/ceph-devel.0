From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] Rbd: support copy-on-read option
Date: Thu, 21 May 2015 12:09:09 +0300
Message-ID: <CAOi1vP80DLrThmz8uwjU5xhMqtQfdiW-gix1VH1vaYeZWU7zEA@mail.gmail.com>
References: <1432192565-11811-1-git-send-email-liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33030 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbEUJJK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:09:10 -0400
Received: by wgjc11 with SMTP id c11so78768952wgj.0
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 02:09:09 -0700 (PDT)
In-Reply-To: <1432192565-11811-1-git-send-email-liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Min Chen <minchen@ubuntukylin.com>

On Thu, May 21, 2015 at 10:16 AM, Li Wang <liwang@ubuntukylin.com> wrote:
> From: Min Chen <minchen@ubuntukylin.com>
>
> Signed-off-by: Min Chen <minchen@ubuntukylin.com>
> Reviewed-by: Li Wang <liwang@ubuntukylin.com>
> ---
>  doc/man/8/rbd.rst | 1 +
>  src/rbd.cc        | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
> index 4552951..3fb747f 100644
> --- a/doc/man/8/rbd.rst
> +++ b/doc/man/8/rbd.rst
> @@ -430,6 +430,7 @@ the running kernel.
>
>  * ro - Map the image read-only.  Equivalent to --read-only.
>
> +* ro - Map the image with copy-on-read turned on.

Need to change the name of the option, ro -> cor.

Thanks,

                Ilya
