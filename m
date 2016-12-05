From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: disk enclosure LEDs
Date: Mon, 5 Dec 2016 13:58:36 +0100
Message-ID: <20161205125836.lxcbv5ai5qdavitr@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <be5f1672179b4d41b2692a02fe71a7cd@Ex2013-MBX2.supermicro.com>
 <BLUPR0201MB1524F8910A0625ECACC4B29AE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751592AbcLEM7C (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 5 Dec 2016 07:59:02 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78CF7AD35
        for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2016 12:58:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7fJOM2vrxAoi+=xdc01z0kkjpH8048bFe1wF1pBw1yVsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-12-05T12:44:51, John Spray <jspray@redhat.com> wrote:

> Question to the OpenAttic folks, who afaik are the only ones on the
> thread actively building tools like this: if ceph-mgr modules could do
> arbitrary command remote execution on OSD nodes, is that what you
> would use for blinking LEDs?  How would you wire that up to the rest
> of your stack?

So, in "our" world, we have Salt minions for remote execution
everywhere.

If Ceph requires an additional remote execution channel, aren't we
rebuilding work that's part of both Salt, Ansible, Puppet, ...?

The advantage of having a ceph remote agent is most prominent if you
view ceph as an isolated distributed system.


Regards,
    Lars

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

