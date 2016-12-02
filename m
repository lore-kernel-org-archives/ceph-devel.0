From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: disk enclosure LEDs
Date: Fri, 2 Dec 2016 18:17:20 +0100
Message-ID: <20161202171720.xb6dr2euayzh6idn@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
 <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbcLBRRm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 12:17:42 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5728FABDA
        for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2016 17:17:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <BLUPR0201MB1524A241C45983E2CEF8844DE88E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-12-02T16:57:22, Allen Samuels <Allen.Samuels@sandisk.com> wrote:

> So, I'd vote for having an API termination in ceph-mgr. Have the mgr contact the destination system (the OSD is *NOT* the right path) to perform the action. Then do something like invoke a configurable shell script (something that's configurable) to perform the actual operation. 

+1


