From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: size of inc_osdmap vs osdmap
Date: Thu, 3 Jan 2019 03:03:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1901030301170.6449@piezo.novalocal>
References: <CADn0Px8=b6mYkFdOvwwb15WEuV=KtubxAH0P-+sjHdw9Rptdtw@mail.gmail.com>
 <CAJ4mKGbeg4NXaVvzFfGrJnXM84Q4h4yu0+BTYe81oX+dp7wuQA@mail.gmail.com>
 <CADn0Px_4SZYm63TrgqYT2bUbrUThn5ZRa5+rW_gAeg5aXgFLwg@mail.gmail.com>
 <CAJ4mKGZBkSd-syes=nDD8cwC517QFwu26FjXYJDDkR0o4ZkCXQ@mail.gmail.com>
 <CADn0Px-h+NUxcLVB5eNEQwo58Q0=fbBJZMqOYHHGkrN+MmakeA@mail.gmail.com>
 <CAJ4mKGaeDKhx9v1M-4=-+dmgX-8u_BFXjismNTQn09bk1cmLUA@mail.gmail.com>
 <CADn0Px8_i_axxnE56T351=uVghFdQs1gRdPqfAaYdQcSzuKTDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-157122013-1546484602=:6449"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CADn0Px8_i_axxnE56T351=uVghFdQs1gRdPqfAaYdQcSzuKTDQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sergey Dolgov <palza00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-157122013-1546484602=:6449
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

I think that code was broken by 
ea723fbb88c69bd00fefd32a3ee94bf5ce53569c and should be fixed like so:

diff --git a/src/mon/OSDMonitor.cc b/src/mon/OSDMonitor.cc
index 8376a40668..12f468636f 100644
--- a/src/mon/OSDMonitor.cc
+++ b/src/mon/OSDMonitor.cc
@@ -1006,7 +1006,8 @@ void OSDMonitor::prime_pg_temp(
   int next_up_primary, next_acting_primary;
   next.pg_to_up_acting_osds(pgid, &next_up, &next_up_primary,
                            &next_acting, &next_acting_primary);
-  if (acting == next_acting && next_up != next_acting)
+  if (acting == next_acting &&
+      !(up != acting && next_up == next_acting))
     return;  // no change since last epoch
 
   if (acting.empty())


The original intent was to clear out pg_temps during priming, but as 
written it would set a new_pg_temp item clearing the pg_temp even if one 
didn't already exist.  Adding the up != acting condition in there makes us 
only take that path if there is an existing pg_temp entry to remove.

Xie, does that sound right?

sage


On Thu, 3 Jan 2019, Sergey Dolgov wrote:

> >
> > Well those commits made some changes, but I'm not sure what about them
> > you're saying is wrong?
> >
> I mean,  that all pgs have "up == acting && next_up == next_acting" but at
> https://github.com/ceph/ceph/blob/luminous/src/mon/OSDMonitor.cc#L1009
> condition
> "next_up != next_acting" false and we clear acting for all pgs at
> https://github.com/ceph/ceph/blob/luminous/src/mon/OSDMonitor.cc#L1018 after
> that all pg fall into inc_osdmap
> I think https://github.com/ceph/ceph/pull/25724 change behavior to
> correct(as was before commit
> https://github.com/ceph/ceph/pull/16530/commits/ea723fbb88c69bd00fefd32a3ee94bf5ce53569c)
> for pg with up == acting && next_up == next_acting
> 
> On Thu, Jan 3, 2019 at 2:13 AM Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> >
> >
> > On Thu, Dec 27, 2018 at 1:20 PM Sergey Dolgov <palza00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> >> We investigated the issue and set debug_mon up to 20 during little change
> >> of osdmap get many messages for all pgs of each pool (for all cluster):
> >>
> >>> 2018-12-25 19:28:42.426776 7f075af7d700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_tempnext_up === next_acting now, clear pg_temp
> >>> 2018-12-25 19:28:42.426776 7f075a77c700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_tempnext_up === next_acting now, clear pg_temp
> >>> 2018-12-25 19:28:42.426777 7f075977a700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_tempnext_up === next_acting now, clear pg_temp
> >>> 2018-12-25 19:28:42.426779 7f075af7d700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_temp 3.1000 [97,812,841]/[] -> [97,812,841]/[97,812,841], priming
> >>> []
> >>> 2018-12-25 19:28:42.426780 7f075a77c700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_temp 3.0 [84,370,847]/[] -> [84,370,847]/[84,370,847], priming []
> >>> 2018-12-25 19:28:42.426781 7f075977a700 20 mon.1@0(leader).osd e1373789
> >>> prime_pg_temp 4.0 [404,857,11]/[] -> [404,857,11]/[404,857,11], priming []
> >>
> >> though no pg_temps are created as result(no single backfill)
> >>
> >> We suppose this behavior changed in commit
> >> https://github.com/ceph/ceph/pull/16530/commits/ea723fbb88c69bd00fefd32a3ee94bf5ce53569c
> >> because earlier function *OSDMonitor::prime_pg_temp* should return in
> >> https://github.com/ceph/ceph/blob/luminous/src/mon/OSDMonitor.cc#L1009
> >> like in jewel
> >> https://github.com/ceph/ceph/blob/jewel/src/mon/OSDMonitor.cc#L1214
> >>
> >> i accept that we may be mistaken
> >>
> >
> > Well those commits made some changes, but I'm not sure what about them
> > you're saying is wrong?
> >
> > What would probably be most helpful is if you can dump out one of those
> > over-large incremental osdmaps and see what's using up all the space. (You
> > may be able to do it through the normal Ceph CLI by querying the monitor?
> > Otherwise if it's something very weird you may need to get the
> > ceph-dencoder tool and look at it with that.)
> > -Greg
> >
> >
> >>
> >>
> >> On Wed, Dec 12, 2018 at 10:53 PM Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >> wrote:
> >>
> >>> Hmm that does seem odd. How are you looking at those sizes?
> >>>
> >>> On Wed, Dec 12, 2018 at 4:38 AM Sergey Dolgov <palza00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>>
> >>>> Greq, for example for our cluster ~1000 osd:
> >>>>
> >>>> size osdmap.1357881__0_F7FE779D__none = 363KB (crush_version 9860,
> >>>> modified 2018-12-12 04:00:17.661731)
> >>>> size osdmap.1357882__0_F7FE772D__none = 363KB
> >>>> size osdmap.1357883__0_F7FE74FD__none = 363KB (crush_version 9861,
> >>>> modified 2018-12-12 04:00:27.385702)
> >>>> size inc_osdmap.1357882__0_B783A4EA__none = 1.2MB
> >>>>
> >>>> difference between epoch 1357881 and 1357883: crush weight one osd was
> >>>> increased by 0.01 so we get 5 new pg_temp in osdmap.1357883 but size
> >>>> inc_osdmap so huge
> >>>>
> >>>> чт, 6 дек. 2018 г. в 06:20, Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:
> >>>> >
> >>>> > On Wed, Dec 5, 2018 at 3:32 PM Sergey Dolgov <palza00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>>> wrote:
> >>>> >>
> >>>> >> Hi guys
> >>>> >>
> >>>> >> I faced strange behavior of crushmap change. When I change crush
> >>>> >> weight osd I sometimes get  increment osdmap(1.2MB) which size is
> >>>> >> significantly bigger than size of osdmap(0.4MB)
> >>>> >
> >>>> >
> >>>> > This is probably because when CRUSH changes, the new primary OSDs for
> >>>> a PG will tend to set a "pg temp" value (in the OSDMap) that temporarily
> >>>> reassigns it to the old acting set, so the data can be accessed while the
> >>>> new OSDs get backfilled. Depending on the size of your cluster, the number
> >>>> of PGs on it, and the size of the CRUSH change, this can easily be larger
> >>>> than the rest of the map because it is data with size linear in the number
> >>>> of PGs affected, instead of being more normally proportional to the number
> >>>> of OSDs.
> >>>> > -Greg
> >>>> >
> >>>> >>
> >>>> >> I use luminois 12.2.8. Cluster was installed a long ago, I suppose
> >>>> >> that initially it was firefly
> >>>> >> How can I view content of increment osdmap or can you give me opinion
> >>>> >> on this problem. I think that spikes of traffic tight after change of
> >>>> >> crushmap relates to this crushmap behavior
> >>>> >> _______________________________________________
> >>>> >> ceph-users mailing list
> >>>> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >>>> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> >>>>
> >>>>
> >>>>
> >>>> --
> >>>> Best regards, Sergey Dolgov
> >>>>
> >>>
> >>
> >> --
> >> Best regards, Sergey Dolgov
> >>
> >
> 
> -- 
> Best regards, Sergey Dolgov
> 
--8323329-157122013-1546484602=:6449
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-157122013-1546484602=:6449--
