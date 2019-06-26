From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Changing the release cadence
Date: Wed, 26 Jun 2019 14:45:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1906261437280.17148@piezo.novalocal>
References: <alpine.DEB.2.11.1906051556500.987@piezo.novalocal>
 <alpine.DEB.2.11.1906171621000.20504@piezo.novalocal>
 <CAN-Gep+9bxadHMTFQgUFUt_q9Jmfpy3MPU5UTTRNY1jueu7n9w@mail.gmail.com>
 <CAC-Np1zcniBxm84SEGhzYfu55t+fckg1d-Dq0xpab62+ON4K5w@mail.gmail.com>
 <CAE6AcseMEfRjRtA0iUPMwsQPP+ebEqDDHYeWUpXWGeWTggnKRw@mail.gmail.com>
 <alpine.DEB.2.11.1906261255530.17148@piezo.novalocal>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-408392694-1561560335=:17148"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1906261255530.17148-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, dev-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-408392694-1561560335=:17148
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi everyone,

We talked a bit about this during the CLT meeting this morning.  How about 
the following proposal:

- Target release date of Mar 1 each year.
- Target freeze in Dec.  That will allow us to use the holidays to do a 
  lot of testing when the lab infrastructure tends to be somewhat idle.

If we get an early build out at the point of the freeze (or even earlier), 
perhaps this capture some of the time that the retailers have during their 
lockdown to identify structural issues with release.  It is probably 
better to do more of this testing at this point in the cycle so that we 
have time to properly fix any big issues (like performance or scaling 
regressions).  It is of course a challenge to motivate testing on 
something that is too far from the final a release, but we can try.

This avoids an abbreviated octopus cycle, and avoids placing August (which 
also often has people out for vacations) right in the middle of the 
lead-up to the freeze.

Thoughts?
sage



On Wed, 26 Jun 2019, Sage Weil wrote:

> On Wed, 26 Jun 2019, Alfonso Martinez Hidalgo wrote:
> > I think March is a good idea.
> 
> Spring had a slight edge over fall in the twitter poll (for whatever 
> that's worth).  I see the appeal for fall when it comes to down time for  
> retailers, but as a practical matter for Octopus specifically, a target of
> say October means freezing in August, which means we only have 2
> more months of development time.  I'm worried that will turn Octopus 
> in another weak (aka lightly adopted) release.
> 
> March would mean freezing in January again, which would give us July to 
> Dec... 6 more months.
> 
> sage
> 
> 
> 
> > 
> > On Tue, Jun 25, 2019 at 4:32 PM Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > 
> > > On Mon, Jun 17, 2019 at 4:09 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > wrote:
> > > >
> > > > This was a little long to respond with on Twitter, so I thought I'd
> > > share my thoughts here. I love the idea of a 12 month cadence. I like
> > > October because admins aren't upgrading production within the first few
> > > months of a new release. It gives it plenty of time to be stable for the OS
> > > distros as well as giving admins something low-key to work on over the
> > > holidays with testing the new releases in stage/QA.
> > >
> > > October sounds ideal, but in reality, we haven't been able to release
> > > right on time as long as I can remember. Realistically, if we set
> > > October, we are probably going to get into November/December.
> > >
> > > For example, Nautilus was set to release in February and we got it out
> > > late in late March (Almost April)
> > >
> > > Would love to see more of a discussion around solving the problem of
> > > releasing when we say we are going to - so that we can then choose
> > > what the cadence is.
> > >
> > > >
> > > > On Mon, Jun 17, 2019 at 12:22 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > > >>
> > > >> On Wed, 5 Jun 2019, Sage Weil wrote:
> > > >> > That brings us to an important decision: what time of year should we
> > > >> > release?  Once we pick the timing, we'll be releasing at that time
> > > *every
> > > >> > year* for each release (barring another schedule shift, which we want
> > > to
> > > >> > avoid), so let's choose carefully!
> > > >>
> > > >> I've put up a twitter poll:
> > > >>
> > > >>         https://twitter.com/liewegas/status/1140655233430970369
> > > >>
> > > >> Thanks!
> > > >> sage
> > > >> _______________________________________________
> > > >> ceph-users mailing list
> > > >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > >
> > > > _______________________________________________
> > > > ceph-users mailing list
> > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > >
> > 
> > 
> > -- 
> > 
> > Alfonso Martínez
> > 
> > Senior Software Engineer, Ceph Storage
> > 
> > Red Hat <https://www.redhat.com>
> > <https://red.ht/sig>
> > 
--8323329-408392694-1561560335=:17148
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-408392694-1561560335=:17148--
