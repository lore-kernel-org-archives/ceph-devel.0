From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Wed, 16 Nov 2016 20:48:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611162047530.12110@piezo.us.to>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
	<alpine.DEB.2.11.1611141424060.29579@piezo.us.to>
	<CAMMFjmE_S0ew2h7wWFF2wQccjffX7iGiJS=sxgkvOcvv86DG6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMMFjmE_S0ew2h7wWFF2wQccjffX7iGiJS=sxgkvOcvv86DG6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Yuri Weinstein <yweinste-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Vasu Kulkarni <vasu-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Galloway <dgallowa-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org" <ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org>, "Cerza,
	Zack" <zack-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Development, Ceph" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 16 Nov 2016, Yuri Weinstein wrote:
> Sage,
> 
> We had discussed xenial support in sepia today and right now jobs
> asking for it from smithi and mira nodes will fail because there are
> no bare-metals provisioned for it.
> 
> The question is - how do we split nodes between 14.04, 16.04 and centos ?

Yeah.  I thought we'd already split the bar emetal boxes between trusty 
and xenial.. sorry!

s

> 
> Thx
> YuriW
> 
> On Mon, Nov 14, 2016 at 6:24 AM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Fri, 11 Nov 2016, Sage Weil wrote:
> >> Currently the distros we use for upstream testing are
> >>
> >>  centos 7.x
> >>  ubuntu 16.04 (xenial)
> >>  ubuntu 14.04 (trusty)
> >>
> >> We also do some basic testing for Debian 8 and Fedora (some old version).
> >>
> >> Jewel was the first release that had native systemd and full xenial
> >> support, so it's helpful to have both 14.04 and 16.04 supported to provide
> >> an upgrade path.  But I think we can safely drop 14.04 now for kraken and
> >> luminous.  Our options are
> >>
> >> 1) keep testing on xenial and trusty, and keep building packages for both
> >
> > Sounds like we'll keep trusty around for a while.  Thanks, everyone!
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
