From: Neha Ojha <nojha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Ceph-maintainers] v13.2.4 Mimic released
Date: Tue, 8 Jan 2019 09:49:54 -0800
Message-ID: <CAKn7kBnJZvD0XfjGYn0G1fT4AO4kju_-3Oaq-gCzNd9zhqUSMA@mail.gmail.com>
References: <87pnt83ga6.fsf@suse.com>
 <1637654245.3029503.1546873809792.JavaMail.zimbra@oxygem.tv>
 <CA+2bHPZqCnm_QPwW8pt05ndzbLE=ypzJ65bmixGgLD1QFXC4cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+2bHPZqCnm_QPwW8pt05ndzbLE=ypzJ65bmixGgLD1QFXC4cw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-announce <ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

When upgrading from 13.2.1 to 13.2.4, you should be careful about
http://tracker.ceph.com/issues/36686. It might be worth considering
the workaround mentioned here:
https://github.com/ceph/ceph/blob/master/doc/releases/mimic.rst#v1322-mimic.

Thanks,
Neha

On Tue, Jan 8, 2019 at 9:42 AM Patrick Donnelly <pdonnell-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Mon, Jan 7, 2019 at 7:10 AM Alexandre DERUMIER <aderumier-U/x3PoR4x10AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi,
> >
> > >>* Ceph v13.2.2 includes a wrong backport, which may cause mds to go into
> > >>'damaged' state when upgrading Ceph cluster from previous version.
> > >>The bug is fixed in v13.2.3. If you are already running v13.2.2,
> > >>upgrading to v13.2.3 does not require special action.
> >
> > Any special action for upgrading from 13.2.1 ?
>
> No special actions for CephFS are required for the upgrade.
>
> --
> Patrick Donnelly
> _______________________________________________
> Ceph-maintainers mailing list
> Ceph-maintainers-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-maintainers-ceph.com
