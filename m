From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Thu, 26 Feb 2015 08:34:41 +0000
Message-ID: <BLU175-W9E8C6C85DB7489697B45FDF140@phx.gbl>
References: <alpine.DEB.2.00.1502251125180.25838@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1502251125180.25838-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Weil Sage <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi Sage,
Is there any timeline around the switch? So that we can plan ahead for the testing.

We are running apache + mod-fastcgi in production at scale (540 OSDs, 9 RGW hosts) and it looks good so far. Although at the beginning we came across a problem with large volume of 500 error, which tracked to that mod-fastcgi is using "select" which limits to 1024 FDs. We used "poll" to replace "select" and the problem was solved.

Thanks,
Guang


----------------------------------------
> Date: Wed, 25 Feb 2015 11:31:54 -0800
> From: sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> To: ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: [ceph-users] who is using radosgw with civetweb?
>
> Hey,
>
> We are considering switching to civetweb (the embedded/standalone rgw web
> server) as the primary supported RGW frontend instead of the current
> apache + mod-fastcgi or mod-proxy-fcgi approach. "Supported" here means
> both the primary platform the upstream development focuses on and what the
> downstream Red Hat product will officially support.
>
> How many people are using RGW standalone using the embedded civetweb
> server instead of apache? In production? At what scale? What
> version(s) (civetweb first appeared in firefly and we've backported most
> fixes).
>
> Have you seen any problems? Any other feedback? The hope is to (vastly)
> simplify deployment.
>
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
 		 	   		  
