From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [patch 1/2] ceph: null deref on allocation failure
Date: Tue, 29 Mar 2011 02:31:43 -0700
Message-ID: <AANLkTi=XhutjMEhfYQZ3qpo=r-PzS5fbcF7U9Z0+1wMW@mail.gmail.com>
References: <20110329032529.GE9856@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44035 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab1C2Jbo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 05:31:44 -0400
In-Reply-To: <20110329032529.GE9856@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Mar 28, 2011 at 8:25 PM, Dan Carpenter <error27@gmail.com> wrot=
e:
>
> The original code checked "event_work" for allocation failures, but o=
nly
> after it had already use it.
>
> Signed-off-by: Dan Carpenter <error27@gmail.com>
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 02212ed..b6776cb 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1602,11 +1602,11 @@ void handle_watch_notify(struct ceph_osd_clie=
nt *osdc, struct ceph_msg *msg)
> =A0 =A0 =A0 =A0 =A0 =A0 cookie, ver, event);
> =A0 =A0 =A0 =A0if (event) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event_work =3D kmalloc(sizeof(*event_w=
ork), GFP_NOIO);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&event_work->work, do_event_w=
ork);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!event_work) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("ERROR: could not=
 allocate event_work\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto done_err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 INIT_WORK(&event_work->work, do_event_w=
ork);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event_work->event =3D event;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event_work->ver =3D ver;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0event_work->notify_id =3D notify_id;
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Thanks.

This is already fixed in the latest master branch and will be sent to
Linus soon.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
