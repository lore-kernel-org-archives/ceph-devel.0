From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v6 3/7] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Tue, 4 Apr 2017 16:57:05 +0200
Message-ID: <CAOi1vP8y=VLhAwodp5y=28KRT8-7-2nQYqBgMpC8FsiJO4dMZw@mail.gmail.com>
References: <20170330180546.11021-1-jlayton@redhat.com> <20170330180707.11137-1-jlayton@redhat.com>
 <20170330180707.11137-3-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34618 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdDDO5G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Apr 2017 10:57:06 -0400
Received: by mail-vk0-f52.google.com with SMTP id z204so178483635vkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Apr 2017 07:57:06 -0700 (PDT)
In-Reply-To: <20170330180707.11137-3-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 30, 2017 at 8:07 PM, Jeff Layton <jlayton@redhat.com> wrote:
> When a Ceph volume hits capacity, a flag is set in the OSD map to
> indicate that, and a new map is sprayed around the cluster. With cephfs
> we want it to shut down any abortable requests that are in progress with
> an -ENOSPC error as they'd just hang otherwise.
>
> Add a new ceph_osdc_abort_on_full helper function to handle this. It
> will first check whether there is an out-of-space condition in the
> cluster and then walk the tree and abort any request that has
> r_abort_on_full set with a -ENOSPC error. Call this new function
> directly whenever we get a new OSD map.
>
> Reviewed-by: "Yan, Zheng=E2=80=9D <zyan@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  net/ceph/osd_client.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 781048990599..4e56cd1ec265 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1806,6 +1806,40 @@ static void abort_request(struct ceph_osd_request =
*req, int err)
>         complete_request(req, err);
>  }
>
> +/*
> + * Drop all pending requests that are stalled waiting on a full conditio=
n to
> + * clear, and complete them with ENOSPC as the return code.
> + */
> +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
> +{
> +       struct rb_node *n;
> +       bool osdmap_full =3D ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);

This variable is still redundant ;)

> +
> +       dout("enter abort_on_full\n");
> +
> +       if (!osdmap_full && !have_pool_full(osdc))
> +               goto out;
> +
> +       for (n =3D rb_first(&osdc->osds); n; n =3D rb_next(n)) {
> +               struct ceph_osd *osd =3D rb_entry(n, struct ceph_osd, o_n=
ode);
> +               struct rb_node *m;
> +
> +               m =3D rb_first(&osd->o_requests);
> +               while (m) {
> +                       struct ceph_osd_request *req =3D rb_entry(m,
> +                                       struct ceph_osd_request, r_node);
> +                       m =3D rb_next(m);
> +
> +                       if (req->r_abort_on_full &&
> +                           (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
> +                            pool_full(osdc, req->r_t.target_oloc.pool)))
> +                               abort_request(req, -ENOSPC);
> +               }
> +       }
> +out:
> +       dout("return abort_on_full\n");
> +}
> +
>  static void check_pool_dne(struct ceph_osd_request *req)
>  {
>         struct ceph_osd_client *osdc =3D req->r_osdc;
> @@ -3264,6 +3298,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *o=
sdc, struct ceph_msg *msg)
>
>         kick_requests(osdc, &need_resend, &need_resend_linger);
>
> +       ceph_osdc_abort_on_full(osdc);
>         ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
>                           osdc->osdmap->epoch);
>         up_write(&osdc->lock);

With osdmap_full dropped,

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
