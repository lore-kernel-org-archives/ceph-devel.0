From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 16:27:34 +0200
Message-ID: <20170714142734.5aqzae7x7fmsqmmz@suse.com>
References: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
 <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:41460 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdGNO1n (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 14 Jul 2017 10:27:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1707141407300.27271@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Joao Eduardo Luis <joao@suse.de>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On 2017-07-14T14:12:08, Sage Weil <sage@newdream.net> wrote:

> > Any thoughts on how to mitigate this, or on whether I got this all wrong and
> > am missing a crucial detail that blows this wall of text away, please let me
> > know.
> I don't know; the requirement that mons be upgraded before OSDs doesn't 
> seem that unreasonable to me.  That might be slightly more painful in a 
> hyperconverged scenario (osds and mons on the same host), but it should 
> just require some admin TLC (restart mon daemons instead of 
> rebooting).

I think it's quite unreasonable, to be quite honest. Collocated MONs
with OSDs is very typical for smaller cluster environments.

> Is there something in some distros that *requires* a reboot in order to 
> upgrade packages?

Not necessarily.

*But* once we've upgraded the packages, a failure or reboot might
trigger this.

And customers don't always upgrade all nodes at once in a short period
(the benefit of a supposed rolling upgrade cycle), increasing the risk.

I wish we'd already be fully containerized so indeed the MONs were truly
independent of everything else going on on the cluster, but ...

> Also, this only seems like it will affect users that are getting their 
> ceph packages from the distro itself and not from a ceph.com channel or a 
> special subscription/product channel (this is how the RHEL stuff works, I 
> think).

Even there, upgrading only the MON daemons and not the OSDs is tricky?




-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde

