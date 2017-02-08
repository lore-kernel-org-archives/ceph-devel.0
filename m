From: Sage Weil <sweil@redhat.com>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 16:59:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702081658100.7782@piezo.novalocal>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com> <1330200336.9468.1486571050945@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33883 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbdBHRSc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Feb 2017 12:18:32 -0500
In-Reply-To: <1330200336.9468.1486571050945@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 8 Feb 2017, Wido den Hollander wrote:
> 
> > Op 7 februari 2017 om 20:33 schreef Ken Dreyer <kdreyer@redhat.com>:
> > 
> > 
> > In ceph-ansible we have to determine whether the user wants to bind to
> > IPv6 or not, and set "ms bind ipv6 = true".
> > 
> 
> Isn't it possible that this causes troubles when explicitly setting 
> public and/or cluster network?

Yeah.  But I think even more importantly, it assumes that the host is 
using ipv6, which it might not be.  Currently the messenger *either* uses 
ipv4 or ipv6, but it can't do both.

It's 2017 and probably time to make that default, but we'll need to 
document it loudly and figure out how to make the upgrade process as 
painless as we can.

sage


> 
> Wido
> 
> > Could we make this easier for users and simply have this as the
> > default option in Ceph? What is the downside to defaulting ms bind
> > ipv6 to true?
> > 
> > - Ken
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
