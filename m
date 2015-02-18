From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: kfree() in put_osd() shouldn't depend on authorizer
Date: Wed, 18 Feb 2015 16:34:15 +0300
Message-ID: <CAOi1vP-==3Q-83_TNjPi6N7hLzgmHQKYJSt2==uG3rFWg7vU3g@mail.gmail.com>
References: <1424266050-40892-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45701 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbBRNeR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Feb 2015 08:34:17 -0500
Received: by wesw62 with SMTP id w62so1128621wes.12
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2015 05:34:16 -0800 (PST)
In-Reply-To: <1424266050-40892-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

On Wed, Feb 18, 2015 at 4:27 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> a255651d4cad ("ceph: ensure auth ops are defined before use") made
> kfree() in put_osd() conditional on the authorizer.  A mechanical
> mistake most likely - fix it.
>
> Cc: Alex Elder <elder@linaro.org>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/osd_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index f693a2f8ac86..41a4abc7e98e 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1035,10 +1035,11 @@ static void put_osd(struct ceph_osd *osd)
>  {
>         dout("put_osd %p %d -> %d\n", osd, atomic_read(&osd->o_ref),
>              atomic_read(&osd->o_ref) - 1);
> -       if (atomic_dec_and_test(&osd->o_ref) && osd->o_auth.authorizer) {
> +       if (atomic_dec_and_test(&osd->o_ref)) {
>                 struct ceph_auth_client *ac = osd->o_osdc->client->monc.auth;
>
> -               ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
> +               if (osd->o_auth.authorizer)
> +                       ceph_auth_destroy_authorizer(ac, osd->o_auth.authorizer);
>                 kfree(osd);
>         }
>  }

Sorry, this is a dup - ignore it.

Thanks,

                Ilya
