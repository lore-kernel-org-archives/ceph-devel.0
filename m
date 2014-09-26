From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: Weekly performance meeting
Date: Thu, 25 Sep 2014 23:39:33 -0400 (EDT)
Message-ID: <1072637833.382.1411702773045.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <549524118.380.1411702754627.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1752 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbaIZDkM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Sep 2014 23:40:12 -0400
In-Reply-To: <549524118.380.1411702754627.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Somnath Roy <Somnath.Roy@sandisk.com>, Allen Samuels <Allen.Samuels@sandisk.com>, dieter kasper <dieter.kasper@ts.fujitsu.com>, PVonStamwitz@us.fujitsu.com, Xinxin Shu <xinxin.shu@intel.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, xiaoxi chen <xiaoxi.chen@intel.com>, Milosz Tanski <milosz@adfin.com>, zhiqiang wang <zhiqiang.wang@intel.com>, jianpeng ma <jianpeng.ma@intel.com>, gdror@mellanox.com, vuhuong@mellanox.com, Mark Nelson <mark.nelson@inktank.com>, Sage Weil <sweil@redhat.com>

Hi,

1. Agree (our item in the pad).  We have prototyped something that works for us, but some work might be needed to make it useful upstream.

2. Accelio/XioMessenger does well on the front side.  It will be interesting to compare notes.  

Matt

----- "Haomai Wang" <haomaiwang@gmail.com> wrote:

> Thanks for sage!
> 
> I'm on the flight at Oct 1. :-(
> 
> Now my team is mainly worked on the performance of ceph, we have
> observed these points:
> 
> 1. encode/decode plays remarkable latency, especially in
> ObjectStore::Transaction. I'm urgen in refactor ObjectStore API to
> avoid encode/decode codes. It seemed has be signed in note(- remove
> serialization from ObjectStore::Transaction (ymmv))
> 2. obvious latency for threadpool/workqueue model. Do we consider to
> impl performance optimization workqueue to replace existing critical
> workqueue such as op_wq in OSD.h and op_wq in FileStore.h. Now in my
> AsyncMessenger impl, I will try to use custom and simple workqueue
> impl to improve performance.
> 3. Large lock in client library such as ObjectCacher
> 
> 
> On Fri, Sep 26, 2014 at 2:27 AM, Sage Weil <sweil@redhat.com> wrote:
> > Hi everyone,
> >
> > A number of people have approached me about how to get more involved
> with
> > the current work on improving performance and how to better
> coordinate
> > with other interested parties.  A few meetings have taken place
> offline
> > with good results but only a few interested parties were involved.
> >
> > Ideally, we'd like to move as much of this dicussion into the
> public
> > forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't
> always
> > sufficient, however.  I'd like to also set up a regular weekly
> meeting
> > using google hangouts or bluejeans so that all interested parties
> can
> > share progress.  There are a lot of things we can do during the
> Hammer
> > cycle to improve things but it will require some coordination of
> effort.
> >
> > Among other things, we can discuss:
> >
> >  - observed performance limitations
> >  - high level strategies for addressing them
> >  - proposed patch sets and their performance impact
> >  - anything else that will move us forward
> >
> > One challenge is timezones: there are developers in the US, China,
> Europe,
> > and Israel who may want to join.  As a starting point, how about
> next
> > Wednesday, 15:00 UTC?  If I didn't do my tz math wrong, that's
> >
> >   8:00 (PDT, California)
> >  15:00 (UTC)
> >  18:00 (IDT, Israel)
> >  23:00 (CST, China)
> >
> > That is surely not the ideal time for everyone but it can hopefully
> be a
> > starting point.
> >
> > I've also created an etherpad for collecting discussion/agenda items
> at
> >
> >         http://pad.ceph.com/p/performance_weekly
> >
> > Is there interest here?  Please let everyone know if you are
> actively
> > working in this area and/or would like to join, and update the pad
> above
> > with the topics you would like to discuss.
> >
> > Thanks!
> > sage
> 
> 
> 
> -- 
> Best Regards,
> 
> Wheat
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
