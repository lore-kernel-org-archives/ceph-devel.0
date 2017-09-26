From: Sage Weil <sage@newdream.net>
Subject: Re: lingering caps outstanding after client shutdown?
Date: Tue, 26 Sep 2017 13:31:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709261330380.27895@piezo.novalocal>
References: <1506432289.3182.16.camel@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:46161 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966986AbdIZNbm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 09:31:42 -0400
In-Reply-To: <1506432289.3182.16.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>

On Tue, 26 Sep 2017, Jeff Layton wrote:
> In order to get the correct semantics for a delegation or oplock, we
> need to be able to break delegations on open.

Can you explain this part?  How do the delegation/oplock semantics relate 
to open(2)?  I would assume they are related to reads and writes (and data 
consistency).  Unless it's a CIFS thing?

sage
