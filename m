From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Important security noticed regarding release
	signing key
Date: Thu, 17 Sep 2015 09:29:35 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-ID: <alpine.DEB.2.00.1509170918021.23022-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Last week, Red Hat investigated an intrusion on the sites of both the Ceph 
community project (ceph.com) and Inktank (download.inktank.com), which 
were hosted on a computer system outside of Red Hat infrastructure.

Ceph.com provided Ceph community versions downloads signed with a Ceph 
signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases 
of the Red Hat Ceph product for Ubuntu and CentOS operating systems signed 
with an Inktank signing key (id 5438C7019DCEEEAD). While the investigation 
into the intrusion is ongoing, our initial focus was on the integrity of 
the software and distribution channel for both sites.

To date, our investigation has not discovered any compromised code or 
binaries available for download on these sites. However, we cannot fully 
rule out the possibility that some compromised code or binaries were 
available for download at some point in the past. Further, we can no 
longer trust the integrity of the Ceph signing key, and therefore have 
created a new signing key (id E84AC2C0460F3994) for verifying downloads. 
This new key is committed to the ceph.git repository and is 
also available from

	https://git.ceph.com/release.asc

The new key should look like:

pub   4096R/460F3994 2015-09-15
uid                  Ceph.com (release key) <security-Qp0mS5GaXlQ@public.gmane.org>

All future release git tags will be signed with this new key.

This intrusion did not affect other Ceph sites such as download.ceph.com 
(which contained some older Ceph downloads) or git.ceph.com (which mirrors 
various source repositories), and is not known to have affected any other 
Ceph community infrastructure.  There is no evidence that build system or 
the Ceph github source repository were compromised.

New hosts for ceph.com and download.ceph.com have been created and the 
sites have been rebuilt.  All content available on download.ceph.com as 
been verified, and all ceph.com URLs for package locations now redirect 
there.  There is still some content missing from download.ceph.com that 
will appear later today: source tarballs will be regenerated from git, and 
older release packages are being resigned with the new release key DNS 
changes are still propogating so you may not see the new versions of the 
ceph.com and download.ceph.com sites for another hour or so.

The download.inktank.com host has been retired and affected Red Hat 
customers have been notified, further information is available at 
https://securityblog.redhat.com/2015/09/17/.

Users of Ceph packages should take action as a precautionary measure to 
download the newly-signed versions.  Please see the instructions below.

The Ceph community would like to thank Kai Fabian for initially alerting 
us to this issue.

Any questions can be directed to the email discussion lists or the #ceph 
IRC channel on irc.oftc.net.

Thank you!
sage

- -----

The following steps should be performed on all nodes with Ceph software 
installed.

Replace APT keys (Debian, Ubuntu)

	sudo apt-key del 17ED316D
	curl https://git.ceph.com/release.asc | sudo apt-key add -

Replace RPM keys (Fedora, CentOS, SUSE, etc.)

	sudo rpm -e --allmatches gpg-pubkey-17ed316d-4fb96ee8
	sudo rpm --import 'https://git.ceph.com/release.asc'

Reinstalling packages (Fedora, CentOS, SUSE, etc.)

	sudo yum clean metadata
	sudo yum reinstall -y $(repoquery --disablerepo= --enablerepo=ceph \
		--queryformat='%{NAME}' list '*')

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlX66k0ACgkQ2kQg7SiJlcg0wQCfVy+/2BfoNqtCfAcbuNABczFx
bpIAoLf8RTHisIn5wFvEb4Akym/UNn5l
=SEws
-----END PGP SIGNATURE-----
