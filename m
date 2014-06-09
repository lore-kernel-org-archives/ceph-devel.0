From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: ceph-deploy 1.5.4 (addressing packages coming from
	EPEL)
Date: Mon, 9 Jun 2014 08:33:00 -0400
Message-ID: <CANtztVyYc1kobPs9wU9VpeECCOkCmCgEUoeNN52ZXE3FHuDxZg@mail.gmail.com>
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi All,

We've experienced a lot of issues since EPEL started packaging a
0.80.1-2 version that YUM
will see as higher than 0.80.1 and therefore will choose to install
the EPEL one.

That package has some issues from what we have seen and in most cases
will break the installation
process.

There is a new version of ceph-deploy (1.5.4) that addresses this
problem by setting the priorities
so that the ceph.repo will be considered before the EPEL one.

Some improvements where done for how ceph-deploy parses
cephdeploy.conf files so that priorities
can be correctly set (and honored) from there as well.

The changelog with the details of this release can be found here:

http://ceph.com/ceph-deploy/docs/changelog.html#id1

Make sure you update!


-Alfredo
