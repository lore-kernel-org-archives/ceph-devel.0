From: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: can we drop support of centos/rhel 7.4?
Date: Fri, 14 Sep 2018 10:12:30 +0100
Message-ID: <CALe9h7cNdS2wffQLO2Gsud3xY7fA5KhfUUKWvDDXGMWYPGhpiA@mail.gmail.com>
References: <CAJE9aONakRfTc_ghzj_6wie4CcnD6KNMgMHtaZMbK5LbiLyn7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJE9aONakRfTc_ghzj_6wie4CcnD6KNMgMHtaZMbK5LbiLyn7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Sep 14, 2018 at 3:48 AM kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> hi ceph-{maintainers,users,developers},
>
> recently, i ran into an issue[0] which popped up when we build Ceph on
> centos 7.5, but test it on centos 7.4. as we know, the gperftools-libs
> package provides the tcmalloc allocator shared library, but centos 7.4
> and centos 7.5 ship different version of gperftools-{devel,libs}. the
> former ships 2.4, and the latter 2.6.1.
>
> the crux is that the tcmalloc in gperftools 2.6.1 implements more
> standard compliant C++ APIs, which were missing in gperftools 2.4.
> that's why we have failures like:
>
> ceph-osd: symbol lookup error: ceph-osd: undefined symbol: _ZdaPvm
>
> when testing Ceph on centos 7.4.
>
> my question is: is it okay to drop the support of centos/rhel 7.4? so
> we will solely build and test the supported Ceph releases (luminous,
> mimic) on 7.5 ?

My preference would be to target the latest minor release (i.e. 7.5)
of the major release.  We don't test on CentOS 7.1, 7.2 etc, so I
don't think we need to give 7.4 any special treatment.

John

>
> thanks,
>
> --
> [0] http://tracker.ceph.com/issues/35969
>
> --
> Regards
> Kefu Chai
