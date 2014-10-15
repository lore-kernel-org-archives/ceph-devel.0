From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: the state of cephfs in giant
Date: Tue, 14 Oct 2014 19:06:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410141906170.10462@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
	<543CD16C.6060708@m-privacy.de>
	<alpine.DEB.2.00.1410140718050.10462@cobra.newdream.net>
	<543DBCE9.2080605@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <543DBCE9.2080605-g2h0fw6BmCNmR6Xm/wNWPw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alphe Salas <asalas-g2h0fw6BmCNmR6Xm/wNWPw@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Amon Ott <a.ott-oFjU9DtLk10Mb+B85CZM8Q@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This sounds like any number of readdir bugs that Zheng has fixed over the 
last 6 months.

sage


On Tue, 14 Oct 2014, Alphe Salas wrote:

> Hello sage, last time I used CephFS it had a strange behaviour when if used in
> conjunction with a nfs reshare of the cephfs mount point, I experienced a
> partial random disapearance of the tree folders.
> 
> According to people in the mailing list it was a kernel module bug (not using
> ceph-fuse) do you know if any work has been done recently in that topic?
> 
> best regards
> 
> Alphe Salas
> I.T ingeneer
> 
> On 10/14/2014 11:23 AM, Sage Weil wrote:
> > On Tue, 14 Oct 2014, Amon Ott wrote:
> > > Am 13.10.2014 20:16, schrieb Sage Weil:
> > > > We've been doing a lot of work on CephFS over the past few months. This
> > > > is an update on the current state of things as of Giant.
> > > ...
> > > > * Either the kernel client (kernel 3.17 or later) or userspace
> > > > (ceph-fuse
> > > >    or libcephfs) clients are in good working order.
> > > 
> > > Thanks for all the work and specially for concentrating on CephFS! We
> > > have been watching and testing for years by now and really hope to
> > > change our Clusters to CephFS soon.
> > > 
> > > For kernel maintenance reasons, we only want to run longterm stable
> > > kernels. And for performance reasons and because of severe known
> > > problems we want to avoid Fuse. How good are our chances of a stable
> > > system with the kernel client in the latest longterm kernel 3.14? Will
> > > there be further bugfixes or feature backports?
> > 
> > There are important bug fixes missing from 3.14.  IIRC, the EC, cache
> > tiering, and firefly CRUSH changes aren't there yet either (they landed in
> > 3.15), and that is not appropriate for a stable series.
> > 
> > They can be backported, but no commitment yet on that :)
> > 
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
