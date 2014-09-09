From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Wed, 10 Sep 2014 00:48:40 +0200
Message-ID: <540F83C8.7080809@dachary.org>
References: <or4mxyuvo4.fsf@free.home> <alpine.DEB.2.00.1409091520440.11887@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4X4qakRmCrb5IAT9Er47m7KHbb1DeWFq3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48565 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbaIIWss (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 18:48:48 -0400
In-Reply-To: <alpine.DEB.2.00.1409091520440.11887@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4X4qakRmCrb5IAT9Er47m7KHbb1DeWFq3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The only reason I can think of is that it requires write permission to a =
directory that was previously not used. I think it will break a few unit =
tests but nothing we can't fix.

On 10/09/2014 00:21, Sage Weil wrote:
> I'm inlined to just apply this original patch.  Is there any reason *no=
t*=20
> to create a pid file when -f is used?  It's a change from previous=20
> behavior, but is there any possible harm that can come of it?
>=20
> sage
>=20
>=20
> On Wed, 30 Jul 2014, Alexandre Oliva wrote:
>=20
>> systemd wants to run daemons in foreground, but daemons wouldn't write=

>> out the pid file with -f.  Fixed.
>>
>> Signed-off-by: Alexandre Oliva <oliva@gnu.org>
>> ---
>>  src/ceph_mon.cc           |    3 +--
>>  src/common/config.cc      |    2 --
>>  src/global/global_init.cc |   10 +++++++++-
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/ceph_mon.cc b/src/ceph_mon.cc
>> index 4e84b4d..14dd6da 100644
>> --- a/src/ceph_mon.cc
>> +++ b/src/ceph_mon.cc
>> @@ -406,8 +406,7 @@ int main(int argc, const char **argv)
>>    // screwing us over
>>    Preforker prefork;
>>    if (!(flags & CINIT_FLAG_NO_DAEMON_ACTIONS)) {
>> -    if (g_conf->daemonize) {
>> -      global_init_prefork(g_ceph_context, 0);
>> +    if (global_init_prefork(g_ceph_context, 0) >=3D 0) {
>>        prefork.prefork();
>>        if (prefork.is_parent()) {
>>  	return prefork.parent_wait();
>> diff --git a/src/common/config.cc b/src/common/config.cc
>> index 0ee7f58..4e3b6fe 100644
>> --- a/src/common/config.cc
>> +++ b/src/common/config.cc
>> @@ -389,12 +389,10 @@ int md_config_t::parse_argv(std::vector<const ch=
ar*>& args)
>>      }
>>      else if (ceph_argparse_flag(args, i, "--foreground", "-f", (char*=
)NULL)) {
>>        set_val_or_die("daemonize", "false");
>> -      set_val_or_die("pid_file", "");
>>      }
>>      else if (ceph_argparse_flag(args, i, "-d", (char*)NULL)) {
>>        set_val_or_die("daemonize", "false");
>>        set_val_or_die("log_file", "");
>> -      set_val_or_die("pid_file", "");
>>        set_val_or_die("log_to_stderr", "true");
>>        set_val_or_die("err_to_stderr", "true");
>>        set_val_or_die("log_to_syslog", "false");
>> diff --git a/src/global/global_init.cc b/src/global/global_init.cc
>> index 7b20343..f03677c 100644
>> --- a/src/global/global_init.cc
>> +++ b/src/global/global_init.cc
>> @@ -166,8 +166,16 @@ int global_init_prefork(CephContext *cct, int fla=
gs)
>>    if (g_code_env !=3D CODE_ENVIRONMENT_DAEMON)
>>      return -1;
>>    const md_config_t *conf =3D cct->_conf;
>> -  if (!conf->daemonize)
>> +  if (!conf->daemonize) {
>> +    if (atexit(pidfile_remove_void)) {
>> +      derr << "global_init_daemonize: failed to set pidfile_remove fu=
nction "
>> +	   << "to run at exit." << dendl;
>> +    }
>> +
>> +    pidfile_write(g_conf);
>> +
>>      return -1;
>> +  }
>> =20
>>    // stop log thread
>>    g_ceph_context->_log->flush();
>>
>> --=20
>> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
>> You must be the change you wish to see in the world. -- Gandhi
>> Be Free! -- http://FSFLA.org/   FSF Latin America board member
>> Free Software Evangelist|Red Hat Brasil GNU Toolchain Engineer
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--4X4qakRmCrb5IAT9Er47m7KHbb1DeWFq3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQPg8kACgkQ8dLMyEl6F23lbQCgtnlBLft6XNgjBq4k6KmukRNi
leAAoJC9+SFrHgA8QQ2I7Wq6MLX+DKio
=r26H
-----END PGP SIGNATURE-----

--4X4qakRmCrb5IAT9Er47m7KHbb1DeWFq3--
