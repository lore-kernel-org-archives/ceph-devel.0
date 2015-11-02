From: Derek Yarnell <derek-+0HnD9Kv66LFajBVf7NWsQ@public.gmane.org>
Subject: Re: who is using radosgw with civetweb?
Date: Mon, 2 Nov 2015 15:50:09 -0500
Message-ID: <5637CC81.4000604@umiacs.umd.edu>
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
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 2/25/15 2:31 PM, Sage Weil wrote:
> Hey,
> 
> We are considering switching to civetweb (the embedded/standalone rgw web 
> server) as the primary supported RGW frontend instead of the current 
> apache + mod-fastcgi or mod-proxy-fcgi approach.  "Supported" here means 
> both the primary platform the upstream development focuses on and what the 
> downstream Red Hat product will officially support.
> 
> How many people are using RGW standalone using the embedded civetweb 
> server instead of apache?  In production?  At what scale?  What 
> version(s) (civetweb first appeared in firefly and we've backported most 
> fixes).
> 
> Have you seen any problems?  Any other feedback?  The hope is to (vastly) 
> simplify deployment.

Hi,

We have been using civetweb proxied by Apache on RHEL7 on both our RGW
clusters and have been very happy with performance and setup. This has
been our default since we upgraded to Hammer.

Only thing we had to make sure that on our ProxyPass we were specifying
nocanon the proxy pass would mangle http encoding.

Reason we use Apache on the front end is so we can collocate a Django
web front end application for the object store to get around the
necessary for CORS (we designed this before RGW was CORS aware anyway).

Thanks,
derek

-- 
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
