From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: removing cluster name support
Date: Fri, 9 Jun 2017 16:30:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706091626211.3646@piezo.novalocal>
References: <alpine.DEB.2.11.1706081936570.3646@piezo.novalocal>
	<alpine.DEB.2.11.1706091602210.3646@piezo.novalocal>
	<CAHUi5cOM8zrnZ80RMqJhEwowE6XmM3dnAKJmxNf8E82fM7Nfbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAHUi5cOM8zrnZ80RMqJhEwowE6XmM3dnAKJmxNf8E82fM7Nfbg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Erik McCormick <emccormick-hzxOQuFdzaZcUxcyEe/BTA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 9 Jun 2017, Erik McCormick wrote:
> On Fri, Jun 9, 2017 at 12:07 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Thu, 8 Jun 2017, Sage Weil wrote:
> >> Questions:
> >>
> >>  - Does anybody on the list use a non-default cluster name?
> >>  - If so, do you have a reason not to switch back to 'ceph'?
> >
> > It sounds like the answer is "yes," but not for daemons. Several users use
> > it on the client side to connect to multiple clusters from the same host.
> >
> 
> I thought some folks said they were running with non-default naming
> for daemons, but if not, then count me as one who does. This was
> mainly a relic of the past, where I thought I would be running
> multiple clusters on one host. Before long I decided it would be a bad
> idea, but by then the cluster was already in heavy use and I couldn't
> undo it.
> 
> I will say that I am not opposed to renaming back to ceph, but it
> would be great to have a documented process for accomplishing this
> prior to deprecation. Even going so far as to remove --cluster from
> deployment tools will leave me unable to add OSDs if I want to upgrade
> when Luminous is released.

Note that even if the tool doesn't support it, the cluster name is a 
host-local thing, so you can always deploy ceph-named daemons on other 
hosts.

For an existing host, the removal process should be as simple as

 - stop the daemons on the host
 - rename /etc/ceph/foo.conf -> /etc/ceph/ceph.conf
 - rename /var/lib/ceph/*/foo-* -> /var/lib/ceph/*/ceph-* (this mainly 
matters for non-osds, since the osd dirs will get dynamically created by 
ceph-disk, but renaming will avoid leaving clutter behind)
 - comment out the CLUSTER= line in /etc/{sysconfig,default}/ceph (if 
you're on jewel)
 - reboot

If you wouldn't mind being a guinea pig and verifying that this is 
sufficient that would be really helpful!  We'll definitely want to 
document this process.

Thanks!
sage


> 
> > Nobody is colocating multiple daemons from different clusters on the same
> > host.  Some have in the past but stopped.  If they choose to in the
> > future, they can customize the systemd units themselves.
> >
> > The rbd-mirror daemon has a similar requirement to talk to multiple
> > clusters as a client.
> >
> > This makes me conclude our current path is fine:
> >
> >  - leave existing --cluster infrastructure in place in the ceph code, but
> >  - remove support for deploying daemons with custom cluster names from the
> > deployment tools.
> >
> > This neatly avoids the systemd limitations for all but the most
> > adventuresome admins and avoid the more common case of an admin falling
> > into the "oh, I can name my cluster? cool! [...] oh, i have to add
> > --cluster rover to every command? ick!" trap.
> >
> 
> Yeah, that was me in 2012. Oops.
> 
> -Erik
> 
> > sage
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
