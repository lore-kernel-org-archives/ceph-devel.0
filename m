From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: perf counters from a performance discrepancy
Date: Thu, 8 Oct 2015 17:58:09 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F31739FF4@SACMBXIP02.sdcorp.global.sandisk.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9192500992@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1509231116580.13265@cobra.newdream.net>
 <CAJ4mKGavY4ZdutpjnKduQ1AcpCpHDeWST8NyOa_RT19W+DvrNQ@mail.gmail.com>
 <5602F298.7060609@redhat.com>
 <BC97738F8E7C8742BABED7F06FB9DF919250DA8E@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510071944370.8667@cobra.newdream.net>
 <BC97738F8E7C8742BABED7F06FB9DF919250ED6B@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1510080853380.29929@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0053.outbound.protection.outlook.com ([157.56.110.53]:13536
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757555AbbJHR6N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Oct 2015 13:58:13 -0400
In-Reply-To: <alpine.DEB.2.00.1510080853380.29929@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Deneau, Tom" <tom.deneau@amd.com>
Cc: Mark Nelson <mnelson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

If I remember correctly, Nick faced similar issue and we debugged down to the xattr access issue in the find_object_context(). I am not sure if it is resolved though for him or not.

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Thursday, October 08, 2015 8:56 AM
To: Deneau, Tom
Cc: Mark Nelson; Gregory Farnum; ceph-devel@vger.kernel.org
Subject: RE: perf counters from a performance discrepancy

On Thu, 8 Oct 2015, Deneau, Tom wrote:
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Wednesday, October 07, 2015 9:48 PM
> > To: Deneau, Tom
> > Cc: Mark Nelson; Gregory Farnum; ceph-devel@vger.kernel.org
> > Subject: RE: perf counters from a performance discrepancy
> >
> > > I finally got around to looking at the dump_historic_ops output
> > > for the 1-client and 2-client cases.
> > > As you recall these are all read-ops.  so the events in the dump are
> > >    initiated
> > >    reached_pg
> > >    started
> > >    done
> > >
> > > The pattern I see for most of the slow ops recorded in the dump is:
> > >
> > >    * In the 1-client case the typical slow op has duration between
> > > 50-65
> > ms
> > >      and usually most of this is the interval between reached_pg
> > > and
> > started.
> > >
> > >    * In the 2-client case the typical slow op has duration between
> > > 95-
> > 120 ms
> > >      and again usually most of this is the interval between reached_pg
> > >      and started.
> > >
> > > Could someone describe what the interval between reached_pg and
> > > started means?
> >
> > I think the slow part is probably find_object_context() (although to
> > be fair tons of stuff happens here, see do_op()).  You could test
> > this theory or otherwise narrow this down with additional event
> > markers lke
> >
> > diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc index
> > d6f3084..6faccc2 100644
> > --- a/src/osd/ReplicatedPG.cc
> > +++ b/src/osd/ReplicatedPG.cc
> > @@ -1691,10 +1691,12 @@ void ReplicatedPG::do_op(OpRequestRef& op)
> >      return;
> >    }
> >
> > +  op->mark_event("about to find");
> >    int r = find_object_context(
> >      oid, &obc, can_create,
> >      m->has_flag(CEPH_OSD_FLAG_MAP_SNAP_CLONE),
> >      &missing_oid);
> > +  op->mark_event("found");
> >
> >    if (r == -EAGAIN) {
> >      // If we're not the primary of this OSD, and we have
> >
> >
> > sage
>
> Sage --
>
> Is it likely that find_object_context would take longer when there are
> two clients each using their own pool (compared to one client using one pool)?
>
> And would two clients using the same pool spend less time in find_object_context?

Maybe.. find_object_context is where we lookup the file, and if there are caching effects that would be one place where we'd see it.

sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

