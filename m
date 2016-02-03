From: Karol Mroz <kmroz@suse.com>
Subject: logfile created with root:root ownership when "log_file" config
 option specified
Date: Wed, 3 Feb 2016 15:17:27 -0800
Message-ID: <20160203231727.GA18601@oak.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:34290 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbcBCXRj (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 3 Feb 2016 18:17:39 -0500
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings Ceph Developers,

I recently discovered that when explicitly setting "log_file" for radosgw in
ceph.conf, the logfile was created with root:root ownership. Initially I th=
ought
that this was a RGW issue, which prompted me to open: http://tracker.ceph.c=
om/issues/14613

Tracing this a bit further, I believe it to be a more general problem with =
when the
LogObs observer is invoked.

The LogObs observer is first invoked from global_pre_init() by way of:

global_pre_init():
=2E..
  conf->apply_changes(NULL)
=2E..

Which then invokes:

md_config_t::_apply_changes()
{
=2E..
  // Make any pending observer callbacks
  for (rev_obs_map_t::const_iterator r =3D robs.begin(); r !=3D robs.end();=
 ++r) {
    md_config_obs_t *obs =3D r->first;
    obs->handle_conf_change(this, r->second);
  }
=2E..
}

Which in turn fires the LogObs observer code:

class LogObs : public md_config_obs_t {
=2E..
void handle_conf_change()
=2E..
  if (changed.count("log_file")) {
    log->set_log_file(conf->log_file);
    log->reopen_log_file();
  }
=2E..

When "log_file" is specified in ceph.conf, Log::reopen_log_file() is called=
 and
the logfile is open()'d. However, at this point in time, the daemon is stil=
l running
as root, and thus the logfile is created with root:root ownership.

A quick workaround is to manually not set "log_file" in ceph.conf. The defa=
ult
logfile is then created later on in global_init(), by way of:

global_init()
=2E..
  g_conf->call_all_observers();
=2E..

This is called _after_ the correct permissions have been set.

=46rom a quick glance, removing changed.count("log_file"...) from
LogObs::handle_conf_changes() would skip over the early logfile creation in=
 this observer.
A more invasive option would be to remove conf->apply_changes() from global=
_pre_init(),
thus delaying running the observers for the first time until after the perm=
issions drop.
However, I suspect there may be valid reason why conf->apply_changes() is n=
eeded in
global_pre_init()? As I'm not familiar with the nuances here, a comment fro=
m someone more
familiar with this would be appreciated.

--=20
Regards,
Karol

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsoqEAAoJECp28bThgzatiPAH+QG+VtYZCG4qscZOyP9eRJg9
rE9fQ4SsusHDN/JIR6sf/JGRGNNPU4Ng8+SrRWM893KRkfqnk8HWtDxqQQ5MDUzn
8/yKkdSq8VtHjCoz5htw4j+UI6B5EIJq3ZOx735nUEOloG8RQ9Vpe/rKAw6+ghBH
A/OQbyQIvHBSSgRlm8yD7aob3S7LkOLFS/Y4JaOshaLtU2SQpwVRVTMAMoyubMqs
vvF2yGuePkNfh45uNYir7UYAgbHo4hYVQzX7UD7jd7K/kCFNR33MJMO8WdQuAO/L
3m0/ebcNYXbkKKjshzPiCgXLUYAl5U/eM31DIUBDMK2QScGyKlHN86svsdPzG5g=
=mzKG
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
