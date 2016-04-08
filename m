From: Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Subject: Re: [Ceph-maintainers] v10.1.1 Jewel candidate released
Date: Fri, 8 Apr 2016 13:16:12 +0200
Message-ID: <570792FC.5010502@dachary.org>
References: <alpine.DEB.2.11.1604071410170.21587@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1604071410170.21587-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi,

The notable changes since 10.1.0 are at:

http://docs.ceph.com/docs/master/release-notes/#v10-1-1

and the Jewel release candidate information is at:

http://docs.ceph.com/docs/master/release-notes/#v10-1-0-jewel-release-candi=
date

Cheers

On 07/04/2016 20:14, Sage Weil wrote:
> Hi all,
> =

> We've pushed 10.1.1, a second release candidate for Jewel.  This fixes =

> another round of bugs, and we are getting pretty close to a final release=
.  =

> There are a few known issues to watch out for:
> =

>  - Old CephFS clusters will mangle the layouts with this release; the =

> fix was committed just after it was cut.  Wait for the next RC or the =

> release if you're upgrading a cluster that has a CephFS data pool as pool =

> 0.
> =

>  - The upstart ceph-mds-all.conf file is missing.
> =

> Also, this is the first release build that includes arm64/aarch64 package=
s =

> for Ubuntu Xenial 16.04.  Yay!  The CentOS7 builds are waiting on =

> the EPEL repos; hopefully that will happen soon.
> =

> Please review the release notes before trying:
> =

> 	http://docs.ceph.com/docs/master/release-notes/
> =

> Thanks!
> sage
> =

> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
> =


-- =

Lo=EFc Dachary, Artisan Logiciel Libre
