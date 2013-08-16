From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: [ANN] ceph-deploy 1.2.1 released
Date: Fri, 16 Aug 2013 09:01:17 -0400
Message-ID: <CANtztVw3gQ1kLjUTi7vno_uf0ngFqDz-X4cG4SG7eyRtPV9m9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi all,

There is a new bug-fix release of ceph-deploy, the easy ceph deployment tool.

ceph-deploy can be installed from three different sources depending on
your package manager and distribution, currently available for RPMs,
DEBs and directly as a Python package from the Python Package Index.

Documentation has been updated with installation instructions:

https://github.com/ceph/ceph-deploy#installation

This is the list of all fixes that went into this release which can
also be found in the CHANGELOG.rst file in ceph-deploy's git repo:

* Print the help when no arguments are passed
* Add a ``--version`` flag
* Show the version in the help menu
* Catch ``DeployError`` exceptions nicely with the logger
* Fix blocked command when calling ``mon create``
* default to ``dumpling`` for installs
* halt execution on remote exceptions/errors

Make sure you update!

Thanks,


Alfredo
