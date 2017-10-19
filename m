From: Sage Weil <sweil@redhat.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to
 crush_location_hook
Date: Thu, 19 Oct 2017 13:44:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710191344320.24806@piezo.us.to>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl> <CALe9h7e3703iRKJo2ZzJs8YXpYz4xy4T_1ZEv-nfhdGpBRzEJg@mail.gmail.com> <1720165360.3364.1508417319544@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbdJSNol (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 09:44:41 -0400
In-Reply-To: <1720165360.3364.1508417319544@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 19 Oct 2017, Wido den Hollander wrote:
> > Op 19 oktober 2017 om 14:22 schreef John Spray <jspray@redhat.com>:
> > I would vote that we treat this as a bug and change the setting name
> > back to osd_crush_location_hook, even if the name isn't quite
> > descriptive any more -- Sage?
> > 
> 
> Can't we alias it somehow? I ran into this with a pre-production cluster 
> before we started the upgrade of two production systems.
> 
> Problem is that this setting is usually only touched by large 
> deployments so not very much tested nor used.

Yeah, it is probably easiest and the least painful to make both option 
names work (with crush_location_hook taking precedence).  Ideally we'd 
also issue a health warning after upgrade so they know to update it after 
so we can remove the osd_ option name later...  although until we 
centralize config there isn't a great way to do that.

sage



