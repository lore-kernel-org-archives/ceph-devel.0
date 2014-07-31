From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Thu, 31 Jul 2014 10:18:01 +0600
Message-ID: <53D9C379.9070904@dachary.org>
References: <or4mxyuvo4.fsf@free.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Kgi9bV0MU6HuGMMeJOFwhBsqjXxJTM4pB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51358 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750881AbaGaESO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jul 2014 00:18:14 -0400
In-Reply-To: <or4mxyuvo4.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kgi9bV0MU6HuGMMeJOFwhBsqjXxJTM4pB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

With this patch ceph-osd -f will try to create the default pid file : thi=
s is a non backward compatible change. Maybe there is a way for systemd t=
o capture the pid of the process and store it instead of requiring the de=
amon to create the pid file ?

Cheers

On 31/07/2014 08:08, Alexandre Oliva wrote:
> systemd wants to run daemons in foreground, but daemons wouldn't write
> out the pid file with -f.  Fixed.
>=20
> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
> ---
>  src/ceph_mon.cc           |    3 +--
>  src/common/config.cc      |    2 --
>  src/global/global_init.cc |   10 +++++++++-
>  3 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
> index 4e84b4d..14dd6da 100644
> --- a/src/ceph_mon.cc
> +++ b/src/ceph_mon.cc
> @@ -406,8 +406,7 @@ int main(int argc, const char **argv)
>    // screwing us over
>    Preforker prefork;
>    if (!(flags & CINIT_FLAG_NO_DAEMON_ACTIONS)) {
> -    if (g_conf->daemonize) {
> -      global_init_prefork(g_ceph_context, 0);
> +    if (global_init_prefork(g_ceph_context, 0) >=3D 0) {
>        prefork.prefork();
>        if (prefork.is_parent()) {
>  	return prefork.parent_wait();
> diff --git a/src/common/config.cc b/src/common/config.cc
> index 0ee7f58..4e3b6fe 100644
> --- a/src/common/config.cc
> +++ b/src/common/config.cc
> @@ -389,12 +389,10 @@ int md_config_t::parse_argv(std::vector<const cha=
r*>& args)
>      }
>      else if (ceph_argparse_flag(args, i, "--foreground", "-f", (char*)=
NULL)) {
>        set_val_or_die("daemonize", "false");
> -      set_val_or_die("pid_file", "");
>      }
>      else if (ceph_argparse_flag(args, i, "-d", (char*)NULL)) {
>        set_val_or_die("daemonize", "false");
>        set_val_or_die("log_file", "");
> -      set_val_or_die("pid_file", "");
>        set_val_or_die("log_to_stderr", "true");
>        set_val_or_die("err_to_stderr", "true");
>        set_val_or_die("log_to_syslog", "false");
> diff --git a/src/global/global_init.cc b/src/global/global_init.cc
> index 7b20343..f03677c 100644
> --- a/src/global/global_init.cc
> +++ b/src/global/global_init.cc
> @@ -166,8 +166,16 @@ int global_init_prefork(CephContext *cct, int flag=
s)
>    if (g_code_env !=3D CODE_ENVIRONMENT_DAEMON)
>      return -1;
>    const md_config_t *conf =3D cct->_conf;
> -  if (!conf->daemonize)
> +  if (!conf->daemonize) {
> +    if (atexit(pidfile_remove_void)) {
> +      derr << "global_init_daemonize: failed to set pidfile_remove fun=
ction "
> +	   << "to run at exit." << dendl;
> +    }
> +
> +    pidfile_write(g_conf);
> +
>      return -1;
> +  }
> =20
>    // stop log thread
>    g_ceph_context->_log->flush();
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Kgi9bV0MU6HuGMMeJOFwhBsqjXxJTM4pB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPZw3kACgkQ8dLMyEl6F20jLQCeLo1Aq03R/4lJC+w75tVYfLbp
hdIAn2SyugUAzdgqXwCHEcdgGkSgmRaB
=fyWv
-----END PGP SIGNATURE-----

--Kgi9bV0MU6HuGMMeJOFwhBsqjXxJTM4pB--
