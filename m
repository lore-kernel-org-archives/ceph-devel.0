From: Sage Weil <sage@inktank.com>
Subject: Re: OSD daemon changes port no
Date: Tue, 20 Nov 2012 22:20:00 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211202217320.1082@cobra.newdream.net>
References: <CAGfy=6kVyt-a+j8mKYqXYVErRWEUK8ko1ydJuBxY5dr849OD0A@mail.gmail.com> <alpine.DEB.2.00.1211200844240.7369@cobra.newdream.net> <CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54175 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2KUGUC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 01:20:02 -0500
In-Reply-To: <CAGfy=6k3xh_dKJRNiNL_ecKOOXnGWaQT5i2K0Gpz9wW0=C7mWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 21 Nov 2012, hemant surale wrote:
> >>    and one more thing how can it be possible to read from one osd and
> >> then simultaneous write to direct on other osd with less/no traffic?
> >
> > I'm not sure I understand the question...
> 
> Scenario :
>        I have written file X.txt on some osd which is primary for filr
> X.txt ( direct write operation using rados cmd) .
>        Now while read on file X.txt is in progress, Can I make sure
> the simultaneous write request must be directed to other osd using
> crushmaps/other way?

Nope.  The object location is based on the name.  Reads and writes go to 
the same location so that a single OSD can serialize request.  That means, 
for example, that a read that follows a write returns the just-written 
data.

sage


> Goal of task :
>        Trying to avoid read - write clashes as much as possible to
> achieve faster operations (I/O) . Although CRUSH selects osd for data
> placement based on pseudo random function.  is it possible ?
> 
> 
> 
> -
> Hemant Surale.
> 
> 
> 
> On Tue, Nov 20, 2012 at 10:15 PM, Sage Weil <sage@inktank.com> wrote:
> > On Tue, 20 Nov 2012, hemant surale wrote:
> >> Hi Community,
> >>    I have question about port number used by ceph-osd daemon . I
> >> observed traffic (inter -osd communication while data ingest happened)
> >> on port 6802 and then after some time when I ingested second file
> >> after some delay port no 6804 was used . Is there any specific reason
> >> to change port no here?
> >
> > The ports are dynamic.  Daemons bind to a random (6800-6900) port on
> > startup and communicate on that.  They discover each other via the
> > addresses published in the osdmap when the daemon starts.
> >
> >>    and one more thing how can it be possible to read from one osd and
> >> then simultaneous write to direct on other osd with less/no traffic?
> >
> > I'm not sure I understand the question...
> >
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
