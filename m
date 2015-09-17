From: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>
Subject: Re: Important security noticed regarding release
 signing	key
Date: Thu, 17 Sep 2015 16:57:04 +0000
Message-ID: <7F93AE133E34E64FAB163BD9D9F42E85D508A0@IRV-EXCH-MB05.corp.yp.com>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1509170925140.31198-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-announce-Qp0mS5GaXlQ@public.gmane.org" <ceph-announce-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Thanks for the notice!



=A0
Michael Kuriger
Sr. Unix Systems Engineer
r=A0mk7193-CivJcMWXhi0@public.gmane.org=A0|=A0=A0818-649-7235



-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Sa=
ge Weil
Sent: Thursday, September 17, 2015 9:30 AM
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org=
; ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Subject: [ceph-users] Important security noticed regarding release signing =
key

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Last week, Red Hat investigated an intrusion on the sites of both the Ceph =
community project (ceph.com) and Inktank (download.inktank.com), which were=
 hosted on a computer system outside of Red Hat infrastructure.

Ceph.com provided Ceph community versions downloads signed with a Ceph sign=
ing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases of the=
 Red Hat Ceph product for Ubuntu and CentOS operating systems signed with a=
n Inktank signing key (id 5438C7019DCEEEAD). While the investigation into t=
he intrusion is ongoing, our initial focus was on the integrity of the soft=
ware and distribution channel for both sites.

To date, our investigation has not discovered any compromised code or binar=
ies available for download on these sites. However, we cannot fully rule ou=
t the possibility that some compromised code or binaries were available for=
 download at some point in the past. Further, we can no longer trust the in=
tegrity of the Ceph signing key, and therefore have created a new signing k=
ey (id E84AC2C0460F3994) for verifying downloads. =

This new key is committed to the ceph.git repository and is also available =
from

	https://git.ceph.com/release.asc

The new key should look like:

pub   4096R/460F3994 2015-09-15
uid                  Ceph.com (release key) <security-Qp0mS5GaXlQ@public.gmane.org>

All future release git tags will be signed with this new key.

This intrusion did not affect other Ceph sites such as download.ceph.com (w=
hich contained some older Ceph downloads) or git.ceph.com (which mirrors va=
rious source repositories), and is not known to have affected any other Cep=
h community infrastructure.  There is no evidence that build system or the =
Ceph github source repository were compromised.

New hosts for ceph.com and download.ceph.com have been created and the site=
s have been rebuilt.  All content available on download.ceph.com as been ve=
rified, and all ceph.com URLs for package locations now redirect there.  Th=
ere is still some content missing from download.ceph.com that will appear l=
ater today: source tarballs will be regenerated from git, and older release=
 packages are being resigned with the new release key DNS changes are still=
 propogating so you may not see the new versions of the ceph.com and downlo=
ad.ceph.com sites for another hour or so.

The download.inktank.com host has been retired and affected Red Hat custome=
rs have been notified, further information is available at https://security=
blog.redhat.com/2015/09/17/.

Users of Ceph packages should take action as a precautionary measure to dow=
nload the newly-signed versions.  Please see the instructions below.

The Ceph community would like to thank Kai Fabian for initially alerting us=
 to this issue.

Any questions can be directed to the email discussion lists or the #ceph IR=
C channel on irc.oftc.net.

Thank you!
sage

- -----

The following steps should be performed on all nodes with Ceph software ins=
talled.

Replace APT keys (Debian, Ubuntu)

	sudo apt-key del 17ED316D
	curl https://git.ceph.com/release.asc | sudo apt-key add -

Replace RPM keys (Fedora, CentOS, SUSE, etc.)

	sudo rpm -e --allmatches gpg-pubkey-17ed316d-4fb96ee8
	sudo rpm --import 'https://git.ceph.com/release.asc'

Reinstalling packages (Fedora, CentOS, SUSE, etc.)

	sudo yum clean metadata
	sudo yum reinstall -y $(repoquery --disablerepo=3D --enablerepo=3Dceph \
		--queryformat=3D'%{NAME}' list '*')

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlX66k0ACgkQ2kQg7SiJlcg0wQCfVy+/2BfoNqtCfAcbuNABczFx
bpIAoLf8RTHisIn5wFvEb4Akym/UNn5l
=3DSEws
-----END PGP SIGNATURE-----
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
