From: Wido den Hollander <wido@42on.com>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 18:34:39 +0100 (CET)
Message-ID: <991785371.9477.1486575279399@ox.pcextreme.nl>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
 <1330200336.9468.1486571050945@ox.pcextreme.nl>
 <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:43840 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbdBHSMN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 13:12:13 -0500
In-Reply-To: <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 8 februari 2017 om 17:59 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> On Wed, 8 Feb 2017, Wido den Hollander wrote:
> > 
> > > Op 7 februari 2017 om 20:33 schreef Ken Dreyer <kdreyer@redhat.com>:
> > > 
> > > 
> > > In ceph-ansible we have to determine whether the user wants to bind to
> > > IPv6 or not, and set "ms bind ipv6 = true".
> > > 
> > 
> > Isn't it possible that this causes troubles when explicitly setting 
> > public and/or cluster network?
> 
> Yeah.  But I think even more importantly, it assumes that the host is 
> using ipv6, which it might not be.  Currently the messenger *either* uses 
> ipv4 or ipv6, but it can't do both.
> 
> It's 2017 and probably time to make that default, but we'll need to 
> document it loudly and figure out how to make the upgrade process as 
> painless as we can.

Isn't there a way where we can default it to IPv4 for the Simple Messenger as that is what everybody is using now and default to IPv6 on AsyncMessenger?

Thinking out loudly here, don't know a way yet to work around it.

As you know I'm a huge fan and promoter of IPv6, so the earlier we do this the better.

Why run the future of storage with the a historic IP protocol? ;)

Wido

> 
> sage
> 
> 
> > 
> > Wido
> > 
> > > Could we make this easier for users and simply have this as the
> > > default option in Ceph? What is the downside to defaulting ms bind
> > > ipv6 to true?
> > > 
> > > - Ken
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
