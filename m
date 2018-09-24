From: Ken Dreyer <kdreyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: can we drop support of centos/rhel 7.4?
Date: Mon, 24 Sep 2018 09:39:17 -0600
Message-ID: <CALqRxCz5GoWzb7iTZNSGoA2iaY1RBqcY=VGv+8pzciTTLFYL-A@mail.gmail.com>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 13, 2018 at 8:48 PM kefu chai <tchaikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> my question is: is it okay to drop the support of centos/rhel 7.4? so
> we will solely build and test the supported Ceph releases (luminous,
> mimic) on 7.5 ?

CentOS itself does not support old point releases, and I don't think
we should imply that we do either.

From #centos-devel earlier:

< fidencio> TrevorH: avij: do you know whether there's an offical EOL
                  announcement for 6.9?
< avij> fidencio: it happens every time there's a 6.(x+1) release
< avij> it's always implied
< avij> RH has some support for past RHEL releases, but there's no such
              mechanism in CentOS

- Ken
