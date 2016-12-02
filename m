From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: disk enclosure LEDs
Date: Fri, 2 Dec 2016 10:23:01 +0100
Message-ID: <20161202092301.f65vgyjrssujfyrj@suse.de>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <eb52d1a8-8058-b57b-1585-828385953919@suse.de>
 <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40035 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758611AbcLBJXV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 2 Dec 2016 04:23:21 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4ECB1ACF2
        for <ceph-devel@vger.kernel.org>; Fri,  2 Dec 2016 09:23:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALe9h7d3Lv5Hwxh0sdtkSXQrPZqXG2UdVc2nvSN9ra2Gu6eM5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2016-12-01T00:15:25, John Spray <jspray@redhat.com> wrote:

> Put another way, I'd like it to be the case that people who want to
> twiddle LEDs can write a ceph-mgr module that does that, rather than
> having to push out a libstoragemgmt-enabled agent to the Ceph servers.

I'm not sure I agree.

I understand some of the motivation, but the key use cases where I'd
want to "twiddle LEDs" involve enclosures that either don't yet have an
OSD deployed (e.g., where to plug in the new disk), or where the OSD has
failed (and may not even be able to start).

And I don't want to have to maintain multiple paths for interacting with
the enclosures.


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

