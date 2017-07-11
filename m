From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 16:17:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707111614080.3424@piezo.novalocal>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
	<alpine.DEB.2.11.1707111507220.3424@piezo.novalocal>
	<CACJqLyY0fhZJtDZ3ZS3OL=K6TcK_S2fPAE1uUGHPmnbuxDHmvw@mail.gmail.com>
	<alpine.DEB.2.11.1707111537290.3424@piezo.novalocal>
	<CABZ+qqk=kvoTdVebgJrxQ1kdVogY2g9aiSVZKXYzPqGaRAQ+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqk=kvoTdVebgJrxQ1kdVogY2g9aiSVZKXYzPqGaRAQ+5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 11 Jul 2017, Dan van der Ster wrote:
> On Tue, Jul 11, 2017 at 5:40 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Tue, 11 Jul 2017, Haomai Wang wrote:
> >> On Tue, Jul 11, 2017 at 11:11 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >> > On Tue, 11 Jul 2017, Sage Weil wrote:
> >> >> Hi all,
> >> >>
> >> >> Luminous features a new 'service map' that lets rgw's (and rgw nfs
> >> >> gateways and iscsi gateways and rbd mirror daemons and ...) advertise
> >> >> themselves to the cluster along with some metadata (like the addresses
> >> >> they are binding to and the services the provide).
> >> >>
> >> >> It should be pretty straightforward to build a service that
> >> >> auto-configures haproxy based on this information so that you can deploy
> >> >> an rgw front-end that dynamically reconfigures itself when additional
> >> >> rgw's are deployed or removed.  haproxy has a facility to adjust its
> >> >> backend configuration at runtime[1].
> >> >>
> >> >> Anybody interested in tackling this?  Setting up the load balancer in
> >> >> front of rgw is one of the more annoying pieces of getting ceph up and
> >> >> running in production and until now has been mostly treated as out of
> >> >> scope.  It would be awesome if there was an autoconfigured service that
> >> >> did it out of the box (and had all the right haproxy options set).
> >> >
> >> > [1] https://stackoverflow.com/questions/42678269/haproxy-dynamic-configuration
> >>
> >> it looks we do more compared to before. do we need to care the
> >> lifecycle of haproxy?  we need to manage haproxy in ceph command?
> >
> > I don't think so, although not having done this much I'm not the
> > expert.
> >
> > My suggestion would be a new package like radosgw-haproxy-agent that
> > depends on haproxy and includes a script and some systemd units etc so
> > that with minimal configuration (i.e., set up ceph.conf auth key or
> > something) it will wake up periodically and refresh the running haproxy's
> > config.
> 
> So IIUC you want to periodically discover the set of radosgw backends
> to fill haproxy.cfg, then reload the haproxy daemons. That would be
> useful to (a) keep the set of radosgw hosts up to date and (b) to
> provide a high quality haproxy configuration OOTB.

Right.

> The stackoverflow link you sent is about another interesting use-case
> of haproxy -- mapping different urls to different backends. Indeed we
> used this in the past to migrate between ceph clusters, bucket by
> bucket. And we still use it today to redirect a few very busy buckets
> to an isolated set of radosgw's. I can share our config if that helps
> explain how this works [2]. And maybe that config can already start a
> debate about which are the best settings for an haproxy frontend (I
> won't claim ours is generally correct -- happy to hear about how it
> could be improved).

Oops, yeah, I didn't look at the link carefully.  I was just verifying 
that haproxy can be reconfigured on the fly without a restart.

> I don't know if the bucket mapping concept is generally applicable.
> Maybe this haproxy-agent should focus on configuring a single backend
> populated with the radosgw's, and leave more complex configurations up
> to their admins?

Yeah.  (The dynamic remapping is interesting, though!  That could 
potentially be controlled by rgw as well to automatically isolate busy 
buckets or objects.)
 
> (BTW, we generate this haproxy.cfg dynamically via puppet, which fills
> a template by discovering the radosgw hosts in our PuppetDB).

Right.  The idea here is to remove the puppet dependency by discovering 
the rgw's directly from the cluster.

sage


> Cheers, Dan
> 
> [2] https://gist.github.com/dvanders/857ffcf7249849cffc8d784c55b1a4d5
> 
> > We could add a 'ceph-deploy haproxy create ...' command to deploy it,
> > along with something similar in ceph-ansible...
> >
> > sage
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
