From: Ernesto Puerta <epuertat-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: mgr/dashboard: backporting Ceph Dashboard v2 to
 Luminous
Date: Wed, 22 Aug 2018 19:42:24 +0200
Message-ID: <CAE8CVBATwGPmqHmdV2sSMyB5BCHD8XuiOg0AxXKX-GK_WpxkrA@mail.gmail.com>
References: <CAE8CVBBRng2Bp+FZNKc+ocH+GD=YtPNa6rFG7T+N_x3L=MVZ9g@mail.gmail.com>
 <ba0d2586-865a-fcdb-5f8a-85755de7107d@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <ba0d2586-865a-fcdb-5f8a-85755de7107d-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Thanks for your feedback, Willem!

> The old dashboard does not need any package fetch while
> building/installing. Something that is not very handy when building
> FreeBSD packages. And I haven't gotten around to determining how to > get around that.

I thought that https://github.com/ceph/ceph/pull/22562 fixed make-dist
issues on FreeBSD. Is that not working yet? Let us know if that's the
case!

> Suggest renaming it to simpledash or dashboard_v1 and keep it in the
> tree.

Unfortunately, keeping v1 is not as simple as moving the dashboard to
a separate directory (unless we leave it hanging as dead code).
Dashboard_v2 completely replaces dashboard_v1, and that also means
unit test, QA suites, and references in common files (install-deps.sh,
CMakeLists.txt, ceph.spec.in, debian/*, do_freebsd.sh, vstart.sh,
etc.).

My concern is that properly keeping both ones would go beyond a
long-but-mostly-clean cherry-picking. It'd involve Luminous actively
diverging from master, which might burden other backports with
manual/creative conflict-solving.

KR,

Ernesto

On Wed, Aug 22, 2018 at 12:43 PM Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org> wrote:
>
> On 22/08/2018 12:16, Ernesto Puerta wrote:
> > [sent both to ceph-devel and ceph-users lists, as it might be of
> > interest for both audiences]
> >
> > Hi all,
> >
> > This e-mail is just to announce the WIP on backporting dashboard_v2
> > (http://docs.ceph.com/docs/master/mgr/dashboard/) from master to
> > Luminous release.
> >
> > The ultimate goal for this backport is to replace dashboard_v1 in
> > Luminous and provide, **as much as possible**, (see note below) a
> > level of functionality on a par with master's (i. e.: RBD and RGW
> > management, HTTPS support, User Management, Role Based Access Control,
> > Grafana integration, SSO, etc.).
>
> If done so, I would prefer to also keep the old "simple" Dashboard.
> Reason for that is the ease of portability.
>
> The old dashboard does not need any package fetch while
> building/installing. Something that is not very handy when building
> FreeBSD packages. And I haven't gotten around to determining how to get
> around that.
>
> Next to that: that dashboard is "simple". Something I really like, but
> that is perhaps personal.
>
> Suggest renaming it to simpledash or dashboard_v1 and keep it in the tree.
>
> Thanx,
> --WjW
>
