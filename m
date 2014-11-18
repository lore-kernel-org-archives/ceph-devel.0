From: Sage Weil <sage@newdream.net>
Subject: Re: watch/notify changes ready for review
Date: Mon, 17 Nov 2014 22:28:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411172227160.23009@cobra.newdream.net>
References: <alpine.DEB.2.00.1411131645430.10048@cobra.newdream.net> <alpine.DEB.2.00.1411171635590.23009@cobra.newdream.net> <CA+4uBUbXRoyUZa=n+9kfH4J3-rwXAhgvtw9gj9ckAUAYTx1MLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43885 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaKRG2p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Nov 2014 01:28:45 -0500
In-Reply-To: <CA+4uBUbXRoyUZa=n+9kfH4J3-rwXAhgvtw9gj9ckAUAYTx1MLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 17 Nov 2014, Samuel Just wrote:
> I think I agree that the failed notify api is superfluous.  Also,
> would that not imply that the handle_error callback had already fired
> with an ETIMEDOUT?

It's a little different because the notify timeout is specified on a 
per-notify basis by the caller, while the overall watch disconnect timeout 
is an OSD config option.  One caller may want a notify that times out 
after 2s while another may be willing to wait 10s.

s


> -Sam
> 
> On Mon, Nov 17, 2014 at 4:42 PM, Sage Weil <sage@newdream.net> wrote:
> > On Thu, 13 Nov 2014, Sage Weil wrote:
> >> My pile of watch/notify changes are ready for review:
> >>
> >>       https://github.com/ceph/ceph/pull/2924
> >
> > Okay, I did another round of cleanup (including moving most of the code
> > into Objecter) and it's now way cleaner and passing all the basic tests
> > (hasn't gone through full yet).
> >
> > I still have a big outstanding question:
> >
> > Does the failed notify API make sense?  I'm leaning no, but want another
> > opinion before I go rip it back out.  To summarize: it notifies a watcher
> > if it was slow to respond to an earlier notify and caused the notifier to
> > time out.  Counterargument: if the notifier wants to tell everyone they
> > saw a timeout, they could send another notify; at least then they would
> > know if the second piece of information was delivered (quickly).  I don't
> > think that librbd or rgw will make use of it.
> >
> > The last bit of work remaining is to migrate RGW over to the new API and
> > make it use watch_check().  Will work with Yehuda on that, but in the
> > meantime, this is ready for review!
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
