From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH] Fix uninitialized pointer in debug.cc:dout_handle_daemonize().
Date: Mon, 13 Dec 2010 08:38:50 -0800
Message-ID: <AANLkTinHthYAHH6=Y3MdSpj1GMHhWJ3hxSHPMgU0EFp_@mail.gmail.com>
References: <20101213133836.GH4783@daedalus.cslab.ece.ntua.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:60313 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545Ab0LMQiv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Dec 2010 11:38:51 -0500
Received: by fxm18 with SMTP id 18so6459949fxm.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Dec 2010 08:38:50 -0800 (PST)
In-Reply-To: <20101213133836.GH4783@daedalus.cslab.ece.ntua.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
Cc: ceph-devel@vger.kernel.org, cven@cslab.ece.ntua.gr

Good find! You must have logging turned fairly low, so you never
created/initialized the stream prior to dout_handle_daemonize().

Colin


2010/12/13 Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>:
> Hello,
>
> Starting the MDS from the unstable branch fails instantly with a
> SEGFAULT. The MDS works when started in nodaemon mode, using "-D".
>
> The segfault happens in common/debug.cc:dout_handle_daemonize(), whic=
h
> attempts to call _doss->handle_stdout_closed() with _doss being NULL.
>
> The following patch calls _dout_open_log() to initialize _doss
> before accessing it.
>
> Signed-off-by: Vangelis Koukis <vkoukis@cslab.ece.ntua.gr>
> Signed-off-by: Constantinos Venetsanopoulos <cven@cslab.ece.ntua.gr>
> ---
> =A0src/common/debug.cc | =A0 =A05 +++++
> =A01 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/src/common/debug.cc b/src/common/debug.cc
> index 10cd6ce..88780f0 100644
> --- a/src/common/debug.cc
> +++ b/src/common/debug.cc
> @@ -38,6 +38,11 @@ void _dout_open_log()
> =A0int dout_handle_daemonize()
> =A0{
> =A0 Mutex::Locker l(_dout_lock);
> +
> + =A0if (_dout_need_open)
> + =A0 =A0 =A0 _dout_open_log();
> +
> + =A0assert(_doss);
> =A0 _doss->handle_stdout_closed();
> =A0 _doss->handle_stderr_closed();
> =A0 return _doss->handle_pid_change();
> --
> 1.7.2.3
>
> --
> Vangelis Koukis
> vkoukis@cslab.ece.ntua.gr
> OpenPGP public key ID:
> pub =A01024D/1D038E97 2003-07-13 Vangelis Koukis <vkoukis@cslab.ece.n=
tua.gr>
> =A0 =A0 Key fingerprint =3D C5CD E02E 2C78 7C10 8A00 =A053D8 FBFC 379=
9 1D03 8E97
>
> Our greatest glory is not in never failing,
> but in rising up every time we fail.
> =A0 =A0 =A0 =A0-- Ralph Waldo Emerson
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
>
> iEYEARECAAYFAk0GIdwACgkQ+/w3mR0DjpfzvQCg+uSs9QhOXKnDeIlMfBsXQY6C
> osEAn2i/HlLopWasTv+g/0lFMzJkWX5Z
> =3DmoAt
> -----END PGP SIGNATURE-----
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
