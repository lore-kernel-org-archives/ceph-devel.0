From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: ceph-deploy 2.0.0
Date: Tue, 20 Feb 2018 15:13:55 -0500
Message-ID: <CAC-Np1xi6tPKeTtAmJ+dCsfb28TCaexoePWHesPn7WHPmBDxBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

A fully backwards incompatible release of ceph-deploy was completed in
early January [0] which removed ceph-disk as a backend to create OSDs
in favor of ceph-volume.

The backwards incompatible change means that the API for creating OSDs
has changed [1], and also that it now relies on Ceph versions that are
Luminous or newer (e.g. dev releases).

The last version that supported ceph-disk is 1.5.39. Since ceph-deploy
gets included in community Ceph repos, these will get updated with
Ceph releases. The upcoming Luminous release will include version
2.0.0 of ceph-deploy.

Our repositories do not support multi-package versions, so it is
currently not possible to specify a previous version of ceph-deploy
even though we include them in all Ceph repos. As a workaround,
ceph-deploy is also released to the Python package Index [2] and can
be installed form there.

We want to keep the easy ceph-deploy deployment experience, so please
follow bugs as soon as you find them at
http://tracker.ceph.com/projects/ceph-deploy/issues/new

[0] http://docs.ceph.com/ceph-deploy/docs/changelog.html#id1
[1] http://docs.ceph.com/ceph-deploy/docs/index.html#deploying-osds
[2] https://pypi.python.org/pypi/ceph-deploy
