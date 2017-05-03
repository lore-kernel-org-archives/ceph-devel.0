From: Loic Dachary <loic@dachary.org>
Subject: Re: crush luminous endgame
Date: Wed, 3 May 2017 18:08:39 +0200
Message-ID: <285e770a-6627-1c70-8433-d936278b4885@dachary.org>
References: <alpine.DEB.2.11.1705031458310.32730@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53115 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdECQIs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 12:08:48 -0400
In-Reply-To: <alpine.DEB.2.11.1705031458310.32730@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 05/03/2017 05:09 PM, Sage Weil wrote:
> Hey,
> 
> My current thinking is that it would be great to get the following working 
> for luminous (roughly in order of priority):
> 
> 1/ add a mon setting for the oldest client version we want to support.  
> this would replace the various mon_allow_* settings that control whenter 
> we user primary-affinity, osd upmap, and gate the crush tunables changes 
> (i.e. you can't set jewel untables if the oldest compat client is 
> firefly).
> 
> 2/ make sure the above gates the new crush weight sets.
> 
> 3/ make crushwrapper encode a "legacy" crushmap if (1) we're using weight 
> sets, (2) the client is lacking features for the weight set, but (3) the 
> weight set has a single position and no id remapping.  Since these maps 
> are *only* used by clients (not humans), then i don't think there's any 
> need to preserve the original crush weights in a shadow hierarchy; we can 
> just swpa them for the real weights and the legacy clients wll behave as 
> expected.  a helper can tell us whether this is possible so that we gate 
> any commands that inject crush map on the compat option in #1.

Good idea ! I created http://tracker.ceph.com/issues/19836 and will work on that.

> 4/ I would *love love love* it if we could have a mgr task that optimizes 
> the crush weights in a way that Just Works.  If we remove any need for the 
> admin to worry about reweighting in luminous I would call it a bit 
> usability win.  I think depends on your ongonig investigation in which 
> optimization methods work, and then eventually some mgr work so that it is 
> done automatically.
> 
> I can work on #1; #2 is something we need to sort before luminous releases 
> to make sure users to shoot themselves in the foot.  #3 would be awesome 
> (it will still allow offline optimization tools and maintain compat with 
> clients) and #4 would be the big win IMO.
> 
> What do you think?

If the optimization algorithm proposed in "revisiting uneven CRUSH distributions" actually works, it seems possible to have something automated and transparent to the user. I doubt this can happen before Luminous though.

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
