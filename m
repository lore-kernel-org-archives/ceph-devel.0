From: Wido den Hollander <wido@42on.com>
Subject: Re: Luminous: osd_crush_location_hook renamed to
 crush_location_hook
Date: Thu, 19 Oct 2017 14:48:39 +0200 (CEST)
Message-ID: <1720165360.3364.1508417319544@ox.pcextreme.nl>
References: <1406455169.3092.1508155374117@ox.pcextreme.nl>
 <CALe9h7e3703iRKJo2ZzJs8YXpYz4xy4T_1ZEv-nfhdGpBRzEJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from se02-out.mail.pcextreme.nl ([185.66.251.201]:53669 "EHLO
        se02-out.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753174AbdJSMuB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 08:50:01 -0400
In-Reply-To: <CALe9h7e3703iRKJo2ZzJs8YXpYz4xy4T_1ZEv-nfhdGpBRzEJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 19 oktober 2017 om 14:22 schreef John Spray <jspray@redhat.com>:
> 
> 
> On Mon, Oct 16, 2017 at 1:02 PM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > I completely overread this, but I just found out that osd_crush_location_hook was renamed to crush_location_hook in the new config style.
> >
> > When upgrading from Jewel to Luminous without touching your configuration OSDs will move to the default CRUSH location due to the hook not being executed.
> >
> > Was this an oversight with Luminous or was it intentional?
> 
> Hmm, that setting wasn't part of the existing schema config_opts.h
> schema.  The init script was effectively treating it as a "magic"
> value that ceph-conf would be able to read out of the text ceph.conf.
> Not that that matters from a user POV!
> 
> It looks like the init-ceph.in is still referring to the old magic
> config setting's name as well.

Yes, it was done by *ceph-osd-prestart.sh* which is executed by systemd under Jewel.

> 
> I would vote that we treat this as a bug and change the setting name
> back to osd_crush_location_hook, even if the name isn't quite
> descriptive any more -- Sage?
> 

Can't we alias it somehow? I ran into this with a pre-production cluster before we started the upgrade of two production systems.

Problem is that this setting is usually only touched by large deployments so not very much tested nor used.

Wido

> John
> 
> >
> > Wido
