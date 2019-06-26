From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Changing the release cadence
Date: Wed, 26 Jun 2019 12:55:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1906261248400.17148@piezo.novalocal>
References: <alpine.DEB.2.11.1906051556500.987@piezo.novalocal>
 <alpine.DEB.2.11.1906171621000.20504@piezo.novalocal>
 <CAN-Gep+9bxadHMTFQgUFUt_q9Jmfpy3MPU5UTTRNY1jueu7n9w@mail.gmail.com>
 <CAC-Np1zcniBxm84SEGhzYfu55t+fckg1d-Dq0xpab62+ON4K5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAC-Np1zcniBxm84SEGhzYfu55t+fckg1d-Dq0xpab62+ON4K5w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ceph Devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, dev-a8pt6IJUokc@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Tue, 25 Jun 2019, Alfredo Deza wrote:
> On Mon, Jun 17, 2019 at 4:09 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > This was a little long to respond with on Twitter, so I thought I'd share my thoughts here. I love the idea of a 12 month cadence. I like October because admins aren't upgrading production within the first few months of a new release. It gives it plenty of time to be stable for the OS distros as well as giving admins something low-key to work on over the holidays with testing the new releases in stage/QA.
> 
> October sounds ideal, but in reality, we haven't been able to release
> right on time as long as I can remember. Realistically, if we set
> October, we are probably going to get into November/December.
> 
> For example, Nautilus was set to release in February and we got it out
> late in late March (Almost April)
> 
> Would love to see more of a discussion around solving the problem of
> releasing when we say we are going to - so that we can then choose
> what the cadence is.

I think the "on time" part is solveable.  We should just use the amount 
of time between take the previous release's freeze date and the 
target release date and go with that.  It is a bit fuzzy because I left it 
up to the leads how they handle the freeze, but I think mid-Januaray is 
about right (in reality we waiting longer than that for lots of RADOS 
stuff).  v14.2.0 was Mar 18, so ~2 months.

The cadence is really separate from that, though: even if every release 
were 2 full months late, if we start with the same target it's still a 1 
year cycle.

sage
