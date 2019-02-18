From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: ceph mon_data_size_warn limits for large cluster
Date: Mon, 18 Feb 2019 17:00:58 +0530
Message-ID: <CANA9Uk42oDaySWdS48oTfkr4JvH+j7ZPgU=Toz812WkUCNv+Uw@mail.gmail.com>
References: <CANA9Uk437gWgTABHq66dw8v2KN6LqGF5DVc+ecaqoV24ABt++w@mail.gmail.com>
 <alpine.DEB.2.11.1902061225330.4436@piezo.novalocal>
 <CABZ+qqmBshV3DvSrP2UnvKLo1pSEDtVy_xfgP2YNd8e1ctW=xw@mail.gmail.com>
 <CANA9Uk5byzNw8ewi3YHKtnxZnWprMYcmtvB9N3Qq3DaqPtMOwg@mail.gmail.com>
 <CABZ+qqn=NtW5oEb-qiqwTku2N4A04PvYBPLGspUnr29wCXqwjg@mail.gmail.com>
 <alpine.DEB.2.11.1902141327510.14565@piezo.novalocal>
 <CANA9Uk4BHvaZk9dQ8v7+a780U+c5usYqcQJB_M6fuNR0nRnzTA@mail.gmail.com>
 <CANA9Uk4yVo65S5gsfzMOxzE0ya80Brqkmhxb3tFVW49a1c_MFA@mail.gmail.com>
 <CABZ+qqktu6RXFSA9-9tHcUGYy2CkuGPJU9s=uvrParrzujoiEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CABZ+qqktu6RXFSA9-9tHcUGYy2CkuGPJU9s=uvrParrzujoiEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: Bryan Stillwell <bokeoa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

OK, sure will restart the ceph-mon (starting from non leader first,
and then last leader node).


On Mon, Feb 18, 2019 at 4:59 PM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
>
> Not really.
>
> You should just restart your mons though -- if done one at a time it
> has zero impact on your clients.
>
> -- dan
>
>
> On Mon, Feb 18, 2019 at 12:11 PM M Ranga Swami Reddy
> <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > Hi Sage - If the mon data increases, is this impacts the ceph cluster
> > performance (ie on ceph osd bench, etc)?
> >
> > On Fri, Feb 15, 2019 at 3:13 PM M Ranga Swami Reddy
> > <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > >
> > > today I again hit the warn with 30G also...
> > >
> > > On Thu, Feb 14, 2019 at 7:39 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > > >
> > > > On Thu, 7 Feb 2019, Dan van der Ster wrote:
> > > > > On Thu, Feb 7, 2019 at 12:17 PM M Ranga Swami Reddy
> > > > > <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > > > >
> > > > > > Hi Dan,
> > > > > > >During backfilling scenarios, the mons keep old maps and grow quite
> > > > > > >quickly. So if you have balancing, pg splitting, etc. ongoing for
> > > > > > >awhile, the mon stores will eventually trigger that 15GB alarm.
> > > > > > >But the intended behavior is that once the PGs are all active+clean,
> > > > > > >the old maps should be trimmed and the disk space freed.
> > > > > >
> > > > > > old maps not trimmed after cluster reached to "all+clean" state for all PGs.
> > > > > > Is there (known) bug here?
> > > > > > As the size of dB showing > 15G, do I need to run the compact commands
> > > > > > to do the trimming?
> > > > >
> > > > > Compaction isn't necessary -- you should only need to restart all
> > > > > peon's then the leader. A few minutes later the db's should start
> > > > > trimming.
> > > >
> > > > The next time someone sees this behavior, can you please
> > > >
> > > > - enable debug_mon = 20 on all mons (*before* restarting)
> > > >    ceph tell mon.* injectargs '--debug-mon 20'
> > > > - wait for 10 minutes or so to generate some logs
> > > > - add 'debug mon = 20' to ceph.conf (on mons only)
> > > > - restart the monitors
> > > > - wait for them to start trimming
> > > > - remove 'debug mon = 20' from ceph.conf (on mons only)
> > > > - tar up the log files, ceph-post-file them, and share them with ticket
> > > > http://tracker.ceph.com/issues/38322
> > > >
> > > > Thanks!
> > > > sage
> > > >
> > > >
> > > >
> > > >
> > > > > -- dan
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks
> > > > > > Swami
> > > > > >
> > > > > > On Wed, Feb 6, 2019 at 6:24 PM Dan van der Ster <dan-EOCVfBHj35C+XT7JhA+gdA@public.gmane.org> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > With HEALTH_OK a mon data dir should be under 2GB for even such a large cluster.
> > > > > > >
> > > > > > > During backfilling scenarios, the mons keep old maps and grow quite
> > > > > > > quickly. So if you have balancing, pg splitting, etc. ongoing for
> > > > > > > awhile, the mon stores will eventually trigger that 15GB alarm.
> > > > > > > But the intended behavior is that once the PGs are all active+clean,
> > > > > > > the old maps should be trimmed and the disk space freed.
> > > > > > >
> > > > > > > However, several people have noted that (at least in luminous
> > > > > > > releases) the old maps are not trimmed until after HEALTH_OK *and* all
> > > > > > > mons are restarted. This ticket seems related:
> > > > > > > http://tracker.ceph.com/issues/37875
> > > > > > >
> > > > > > > (Over here we're restarting mons every ~2-3 weeks, resulting in the
> > > > > > > mon stores dropping from >15GB to ~700MB each time).
> > > > > > >
> > > > > > > -- Dan
> > > > > > >
> > > > > > >
> > > > > > > On Wed, Feb 6, 2019 at 1:26 PM Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > > > > > > >
> > > > > > > > Hi Swami
> > > > > > > >
> > > > > > > > The limit is somewhat arbitrary, based on cluster sizes we had seen when
> > > > > > > > we picked it.  In your case it should be perfectly safe to increase it.
> > > > > > > >
> > > > > > > > sage
> > > > > > > >
> > > > > > > >
> > > > > > > > On Wed, 6 Feb 2019, M Ranga Swami Reddy wrote:
> > > > > > > >
> > > > > > > > > Hello -  Are the any limits for mon_data_size for cluster with 2PB
> > > > > > > > > (with 2000+ OSDs)?
> > > > > > > > >
> > > > > > > > > Currently it set as 15G. What is logic behind this? Can we increase
> > > > > > > > > when we get the mon_data_size_warn messages?
> > > > > > > > >
> > > > > > > > > I am getting the mon_data_size_warn message even though there a ample
> > > > > > > > > of free space on the disk (around 300G free disk)
> > > > > > > > >
> > > > > > > > > Earlier thread on the same discusion:
> > > > > > > > > https://www.spinics.net/lists/ceph-users/msg42456.html
> > > > > > > > >
> > > > > > > > > Thanks
> > > > > > > > > Swami
> > > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > _______________________________________________
> > > > > > > > ceph-users mailing list
> > > > > > > > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > > > > > > > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > > > >
> > > > >
> > > > >
