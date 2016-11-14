From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Mon, 14 Nov 2016 14:24:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611141424060.29579@piezo.us.to>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611111837410.29579-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 11 Nov 2016, Sage Weil wrote:
> Currently the distros we use for upstream testing are
> 
>  centos 7.x
>  ubuntu 16.04 (xenial)
>  ubuntu 14.04 (trusty)
> 
> We also do some basic testing for Debian 8 and Fedora (some old version).
> 
> Jewel was the first release that had native systemd and full xenial 
> support, so it's helpful to have both 14.04 and 16.04 supported to provide 
> an upgrade path.  But I think we can safely drop 14.04 now for kraken and 
> luminous.  Our options are
> 
> 1) keep testing on xenial and trusty, and keep building packages for both

Sounds like we'll keep trusty around for a while.  Thanks, everyone!

sage
