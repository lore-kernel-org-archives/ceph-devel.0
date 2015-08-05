From: Travis Rhoden <trhoden-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [ANN] ceph-deploy 1.5.27 released
Date: Wed, 5 Aug 2015 16:45:17 -0700
Message-ID: <CACkq2mqgjP-J3CFM0zA8uoXbi1oPjni8JbtTwvvE5K0hSDTQig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi everyone,

A new version of ceph-deploy has been released. Version 1.5.27
includes the following:

 - a new "ceph-deploy repo" command that allows for adding and
removing custom repo definitions
 - Makes commands like "ceph-deploy install --rgw" only install the
RGW component of Ceph.

This works for daemons/components such as --rgw, --mds, and --cli,
depending on how packages are split on your distro.  For example,
Debian packages the Ceph MDS into a separate 'ceph-mon' package, and
therefore if you use "install --mds" only the ceph-mds package will be
installed.  RPM packages do not do this, so it has to install "ceph",
which includes MDS, MON, and OSD daemons.  Further package splits are
coming, but right now we do what we can.

 - Some fixes around using DNF (Fedora >= 22)
 - Early support for systemd (Fedora 22 and development Ceph builds only)
 - Loads of internal changes.

Full changelog is at [1].

Updated packages have been uploaded to
{rpm,debian}-{firefly,hammer,testing} repos on ceph.com, and to PyPI.

Cheers,

 - Travis

[1] http://ceph.com/ceph-deploy/docs/changelog.html#id2
