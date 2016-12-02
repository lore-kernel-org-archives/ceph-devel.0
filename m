From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: disk enclosure LEDs
Date: Fri, 2 Dec 2016 15:27:40 +0100
Message-ID: <20161202142740.pyycxyacdmn5dgc3@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
 <20161202092301.f65vgyjrssujfyrj@suse.de>
 <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934417AbcLBO2P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 09:28:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612021417080.22800@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-12-02T14:23:39, Sage Weil <sage@newdream.net> wrote:

> On the other hand, if we simply make an opinionated choice about some 
> other per-host agent service, like we did in the original Calamari (which 
> used salt and zeromq, IIRC), we'll probably end up offending more users 
> than we please.

> Perhaps the way forward is to pick *some* external host agent and service 
> to start with and ensure that it is integrated into ceph-mgr in a 
> pluggable way such that we have (1) the osd:device mappings available, (2) 
> a standard API for working with LEDs etc, and (3) a working plugin for 
> twiddling the LEDs, but ensure that other "disk services" backends can 
> also be used?

Yes, that makes sense. Making an opinionated choice about the API the
ceph-mgr plugin has and then we can patch in whatever transport we want.




-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

