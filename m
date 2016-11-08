From: Sage Weil <sage@newdream.net>
Subject: Re: master branch merges must pass unit tests
Date: Tue, 8 Nov 2016 23:34:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082331480.29278@piezo.us.to>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59201 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcKHXe1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 18:34:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by cobra.newdream.net (Postfix) with ESMTPS id 2B8FA81374
        for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2016 15:34:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Tue, 8 Nov 2016, Sage Weil wrote:
> I enabled the github check that the unit tests pass in order to merge to 
> master.  These tests still aren't completely reliable, but they're close, 
> and we'll make better progress if we start enforcing it now.

I went a bit further and also checked the box requiring a review and 
preventing pushes directly to master branch.  These are already uneforced 
requirements so this shouldn't slow people down *except* that we need to 
start using the new github 'review' feature that lets you explicitly 
approve changes.

Again, the core developers can override these restrictions if necessary.

I haven't done anything to the stable branches, but we might want to do 
the same thing there...

sage
