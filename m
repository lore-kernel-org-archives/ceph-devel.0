From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph nagios plugins
Date: Wed, 2 Aug 2017 14:13:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708021404130.20435@piezo.novalocal>
References: <alpine.DEB.2.11.1708011414210.20435@piezo.novalocal> <CALqRxCw2EWH4cHuogSgYSFrqZa0F-nfdgbgG_R1PUbkJekcheg@mail.gmail.com> <80e8e181-3c8a-7932-f1ac-a78fb4358153@switch.ch>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-362150942-1501683237=:20435"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbdHBON5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 2 Aug 2017 10:13:57 -0400
In-Reply-To: <80e8e181-3c8a-7932-f1ac-a78fb4358153@switch.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Valery Tschopp <valery.tschopp@switch.ch>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-362150942-1501683237=:20435
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Valery,

On Wed, 2 Aug 2017, Valery Tschopp wrote:
> Hi Ken and Sage,
> 
> Thanks a lot for your interest in my
> https://github.com/valerytschopp/ceph-nagios-plugins.
> 
> I'm not against transferring my personal repository to the
> https://github.com/ceph organization, but I still have some questions:
> 
> - Will I still be able to commit to the repo if I transfer the ownership of my
> repository to the https://github.com/ceph org?
> - Will I become member of the https://github.com/ceph organization?

Yes and yes.  We can set up a team of folks with commit access to the 
nagios repo, or use an existing one.  We can also either just fork your 
repo into the ceph org and start sending pull requests there, or we can 
transfer your repo over.  (I'm not sure it matters?)

sage





> 
> Cheers,
> Valery
> 
> On 01/08/17 18:12 , Ken Dreyer wrote:
> > Hi Valery,
> > 
> > We discussed this a bit more in #ceph-devel today. Would you be ok
> > with moving the Git repo into the https://github.com/ceph org? Then
> > we'd preserve Git history, make it easier to package and distribute,
> > etc.
> > 
> > - Ken
> > 
> > 
> > On Tue, Aug 1, 2017 at 8:30 AM, Sage Weil <sweil@redhat.com> wrote:
> > > Hi Valery,
> > > 
> > > We're thinking about bringing the nagios plugins into the ceph tree to
> > > make them easier to find for users (e.g., making ceph-nagios-plugins
> > > available in the upstream ceph.com repos).  It looks like these are the
> > > most complete (and most commonly used) plugins out there.
> > > 
> > > Would you object to pulling
> > > 
> > >          https://github.com/valerytschopp/ceph-nagios-plugins
> > > 
> > > into ceph.git (into, say, contrib/nagios)?
> > > 
> > > Thanks!
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> SWITCH
> Valéry Tschopp, Software Engineer
> Werdstrasse 2, P.O. Box, 8021 Zurich, Switzerland
> email: valery.tschopp@switch.ch phone: +41 44 268 1544
> 
> 30 years of pioneering the Swiss Internet.
> Celebrate with us at https://swit.ch/30years
> 
> 
> 
--8323329-362150942-1501683237=:20435--
