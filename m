From: Sage Weil <sage@newdream.net>
Subject: Re: Drop upgrade/jewel-x/point-to-point-x in luminous and master
Date: Thu, 1 Feb 2018 13:13:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1802011313060.22550@piezo.novalocal>
References: <910ece94-b940-23ed-e2ba-a1204796dfa9@suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:54300 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752574AbeBANNO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Feb 2018 08:13:14 -0500
In-Reply-To: <910ece94-b940-23ed-e2ba-a1204796dfa9@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 1 Feb 2018, Nathan Cutler wrote:
> Hi ceph devs and testers:
> 
> AIUI the purpose of the point-to-point-x upgrade subsuites is to test upgrades
> from one point release to another. That would seem to imply that these tests
> would be expected to produce meaningful results only when testing upgrades
> within a major release. Correct?
> 
> If so, then we could drop the entire upgrade/jewel-x/point-to-point-x subsuite
> in the luminous and master branches?

Yep!
sage
