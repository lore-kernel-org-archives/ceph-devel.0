From: Florian Haas <florian-Aci1KgOBn19BDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.86 released (Giant release candidate)
Date: Fri, 10 Oct 2014 11:26:29 +0200
Message-ID: <CAPUexz-WrBw7AMveSd+ecA+Mx2GctJfu0QnNW6sy35HKY-0bOQ@mail.gmail.com>
References: <alpine.DEB.2.00.1410071028030.13976@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1410071028030.13976-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

On Tue, Oct 7, 2014 at 9:20 PM, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> This is a release candidate for Giant, which will hopefully be out in
> another week or two (s v0.86).  We did a feature freeze about a month ago
> and since then have been doing only stabilization and bug fixing (and a
> handful on low-risk enhancements).  A fair bit of new functionality went
> into the final sprint, but it's baked for quite a while now and we're
> feeling pretty good about it.
>
> Major items include:
>
> * librados locking refactor to improve scaling and client performance
> * local recovery code (LRC) erasure code plugin to trade some
>   additional storage overhead for improved recovery performance
> * LTTNG tracing framework, with initial tracepoints in librados,
>   librbd, and the OSD FileStore backend
> * separate monitor audit log for all administrative commands
> * asynchronos monitor transaction commits to reduce the impact on
>   monitor read requests while processing updates
> * low-level tool for working with individual OSD data stores for
>   debugging, recovery, and testing
> * many MDS improvements (bug fixes, health reporting)
>
> There are still a handful of known bugs in this release, but nothing
> severe enough to prevent a release.  By and large we are pretty
> pleased with the stability and expect the final Giant release to be
> quite reliable.
>
> Please try this out on your non-production clusters for a preview.

Thanks for the summary! Since you mentioned MDS improvements, and just
so it doesn't get lost: as you hinted at in off-list email, please do
provide a write-up of CephFS features expected to work in Giant at the
time of the release (broken down by kernel client vs. Ceph-FUSE, if
necessary). Not in the sense that anyone is offering commercial
support, but in the sense of "if you use this limited feature set, we
are confident that it at least won't eat your data." I think that
would be beneficial to a large portion of the user base, and clear up
a lot of the present confusion about the maturity and stability of the
filesystem.

Cheers,
Florian
