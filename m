From: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: slow request problem
Date: Sun, 14 Jul 2013 14:15:28 +0200
Message-ID: <51E29660.4040200@profihost.ag>
References: <51E00197.7010708@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <51E00197.7010708-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello list,

might this be a problem due to having too much PGs? I've 370 per OSD 
instead of having 33 / OSD (OSDs*100/3).

Is there any plan for PG merging?

Stefan
> Hello list,
>
> anyone else here who always has problems bringing back an offline OSD?
> Since cuttlefish i'm seeing slow requests for the first 2-5 minutes
> after bringing an OSD oinline again but that's so long that the VMs
> crash as they think their disk is offline...
>
> Under bobtail i never had any problems with that.
>
> Please HELP!
>
> Greets,
> Stefan
>
