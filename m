From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: The max single write IOPS on single RBD
Date: Mon, 14 Dec 2015 10:39:43 -0500 (EST)
Message-ID: <467966684.33265514.1450107583480.JavaMail.zimbra@redhat.com>
References: <CAGkCoN+fT_9fqmUzc0HYkpder_qis-tB9jR-nCwvtJZPD=QGKQ@mail.gmail.com> <alpine.DEB.2.00.1512110512560.10312@cobra.newdream.net> <CAGkCoNJcwWQ77BXGhsPXS0Gg-HJuxumiSDicUBhv9K9HHEDmSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:49996 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbLNPjs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 10:39:48 -0500
In-Reply-To: <CAGkCoNJcwWQ77BXGhsPXS0Gg-HJuxumiSDicUBhv9K9HHEDmSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhi Zhang <zhang.david2011@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

If you are testing with "iodepth=1", I'd recommend testing with "rbd non blocking aio = false" in your Ceph config file to see if that improves your single-threaded IO performance.

-- 

Jason Dillaman 


----- Original Message -----
> From: "Zhi Zhang" <zhang.david2011@gmail.com>
> To: "Sage Weil" <sage@newdream.net>
> Cc: ceph-devel@vger.kernel.org
> Sent: Sunday, December 13, 2015 10:10:58 PM
> Subject: Re: The max single write IOPS on single RBD
> 
> On Fri, Dec 11, 2015 at 9:15 PM, Sage Weil <sage@newdream.net> wrote:
> > On Fri, 11 Dec 2015, Zhi Zhang wrote:
> >> Hi Guys,
> >>
> >> We have a small 4 nodes cluster. Here is the hardware configuration.
> >>
> >> 11 x 300GB SSD, 24 cores, 32GB memory per one node.
> >> all the nodes connected within one 1Gb/s network.
> >>
> >> So we have one Monitor and 44 OSDs for testing kernel RBD IOPS using
> >> fio. Here are the major fio options.
> >>
> >> -direct=1
> >> -rw=randwrite
> >> -ioengine=psync
> >> -size=1000M
> >> -bs=4k
> >> -numjobs=1
> >>
> >> The max IOPS we can achieve for single write (numjobs=1) is close to
> >> 1000. This means each IO from RBD takes 1.x ms.
> >>
> >> >From osd logs, we can also observe most of osd_ops will take 1.x ms,
> >> including op processing, journal writing, replication, etc, before
> >> sending commit back to client.
> >>
> >> The network RTT is around 0.04 ms;
> >> Most osd_ops on primary OSD take around 0.5~0.7 ms, journal write takes
> >> 0.3 ms;
> >> Most osd_repops including writing journal on peer OSD take around 0.5 ms.
> >>
> >> We even tried to modify journal to write page cache only, but didn't
> >> get very significant improvement. Does it mean this is the best result
> >> we can get for single write on single RBD?
> >
> > What version is this?  There have been a few recent changes that will
> > reduce the wall clock time spent preparing/processing a request.  There is
> > still a fair bit of work to do here, though--the theoretical lower bound
> > is the SSD write time + 2x RTT (client <-> primary osd <-> replica osd <->
> > replica ssd).
> >
> 
> Ceph version is 0.94.1 with few backports.
> 
> I already saw some related changes. I will try a newer version and
> keep your guys on the updates.
> 
> Thanks.
> 
> > sage
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
