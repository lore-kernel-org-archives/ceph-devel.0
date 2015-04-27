From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: [PATCH] Swift: Set Content-Length when requesting/checking
 Keystone tokens
Date: Mon, 27 Apr 2015 11:35:51 -0400 (EDT)
Message-ID: <1638259563.5815735.1430148951109.JavaMail.zimbra@redhat.com>
References: <1429979938-18465-1-git-send-email-hroussea@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:60657 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbbD0Pf4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 11:35:56 -0400
In-Reply-To: <1429979938-18465-1-git-send-email-hroussea@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Herve Rousseau <hroussea@cern.ch>
Cc: ceph-devel@vger.kernel.org

This looks good. Can you send a pull request to the ceph github reposit=
ory?

Thanks,
Yehuda

----- Original Message -----
> From: "Herve Rousseau" <hroussea@cern.ch>
> To: ceph-devel@vger.kernel.org
> Cc: "Herv=C3=A9 Rousseau" <hroussea@cern.ch>
> Sent: Saturday, April 25, 2015 9:38:58 AM
> Subject: [PATCH] Swift: Set Content-Length when requesting/checking K=
eystone tokens
>=20
> From: Herv=C3=A9 Rousseau <hroussea@cern.ch>
>=20
> Running Keystone with WSGIChunkedRequest=3DOn is not supported.
>=20
> We have to make sure that we set the Content-Length header when getti=
ng
> an admin token and checking revoked tokens, otherwise Keystone return=
s
> a HTTP 411 error.
>=20
> Same applies when checking revoked tickets.
>=20
> Signed-off-by: Herv=C3=A9 Rousseau <hroussea@cern.ch>
> ---
>  src/rgw/rgw_swift.cc |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/src/rgw/rgw_swift.cc b/src/rgw/rgw_swift.cc
> index 76f21ee..a08d944 100644
> --- a/src/rgw/rgw_swift.cc
> +++ b/src/rgw/rgw_swift.cc
> @@ -269,6 +269,7 @@ int	RGWSwift::get_keystone_admin_token(std::strin=
g&
> token)
>      std::stringstream ss;
>      jf.flush(ss);
>      token_req.set_post_data(ss.str());
> +    token_req.set_send_length(ss.str().length());
>      int ret =3D token_req.process("POST", token_url.c_str());
>      if (ret < 0)
>        return ret;
> @@ -296,6 +297,7 @@ int RGWSwift::check_revoked()
>      return -EINVAL;
>    url.append("v2.0/tokens/revoked");
>    req.append_header("X-Auth-Token", token);
> +  req.set_send_length(0);
>    int ret =3D req.process(url.c_str());
>    if (ret < 0)
>      return ret;
> --
> 1.7.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
