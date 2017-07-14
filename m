From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Fri, 14 Jul 2017 12:05:19 +0200 (CEST)
Message-ID: <1992399284.4003.1500026719834@ox.pcextreme.nl>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
	<1718355157.3684.1499801810149@ox.pcextreme.nl>
	<alpine.DEB.2.11.1707112031580.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707112031580.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


> Op 11 juli 2017 om 22:35 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> 
> 
> On Tue, 11 Jul 2017, Wido den Hollander wrote:
> > > Op 11 juli 2017 om 17:03 schreef Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> > > 
> > > 
> > > Hi all,
> > > 
> > > Luminous features a new 'service map' that lets rgw's (and rgw nfs 
> > > gateways and iscsi gateways and rbd mirror daemons and ...) advertise 
> > > themselves to the cluster along with some metadata (like the addresses 
> > > they are binding to and the services the provide).
> > > 
> > > It should be pretty straightforward to build a service that 
> > > auto-configures haproxy based on this information so that you can deploy 
> > > an rgw front-end that dynamically reconfigures itself when additional 
> > > rgw's are deployed or removed.  haproxy has a facility to adjust its 
> > > backend configuration at runtime[1].
> > > 
> > > Anybody interested in tackling this?  Setting up the load balancer in 
> > > front of rgw is one of the more annoying pieces of getting ceph up and 
> > > running in production and until now has been mostly treated as out of 
> > > scope.  It would be awesome if there was an autoconfigured service that 
> > > did it out of the box (and had all the right haproxy options set).
> > > 
> > 
> > Are there easy Python bindings for this? I mean querying the service map.
> 
> Yes and no.  There are no special librados hooks (or python wrappers) to 
> get the map, but you can issue a mon_command for 'service dump' and get it 
> in JSON, which works just as well for python users.
> 
> > I'm personally a fan of running Varnish (with Hitch for SSL) in front of 
> > RGW. Some people might also prefer Traefik [0] since that also supports 
> > dynamic configs.
> 
> How would you go about autoconfiguring varnish via the rgw service map in 
> this case?
> 

Something like this works with RGW: https://gist.github.com/wido/d93f18810f40ecf405a5be0272821999

You see two backends configured there, but you can have more.

You can also replace that by:

include "backends.vcl"

Where the backends.vcl would then contain:

backend rgw1 {
    .host = "rgw1";
    .port = "7480";
    .connect_timeout = 5s;
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 5s;
    .probe = {
        .timeout   = 30s;
        .interval  = 3s;
        .window    = 10;
        .threshold = 3;
        .request =
            "GET / HTTP/1.1"
            "Host: localhost"
            "User-Agent: Varnish-health-check"
            "Connection: close";
    }
}

backend rgw2 {
    .host = "rgw2";
    .port = "7480";
    .connect_timeout = 5s;
    .first_byte_timeout = 15s;
    .between_bytes_timeout = 5s;
    .probe = {
        .timeout   = 30s;
        .interval  = 3s;
        .window    = 10;
        .threshold = 3;
        .request =
            "GET / HTTP/1.1"
            "Host: localhost"
            "User-Agent: Varnish-health-check"
            "Connection: close";
    }
}

A very simple piece of code would generate these backends based on the servicemap in Ceph.

Wido

> sage
