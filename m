From: Sage Weil <sweil@redhat.com>
Subject: Re: should we remove autotools from master?
Date: Wed, 7 Sep 2016 15:51:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609071550470.32742@piezo.us.to>
References: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to> <856563CD-6D2D-4248-B688-4A146A6F9C4B@Teradata.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbcIGPvX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Sep 2016 11:51:23 -0400
In-Reply-To: <856563CD-6D2D-4248-B688-4A146A6F9C4B@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@Teradata.com>
Cc: Nathan Cutler <ncutler@suse.cz>, Brad Hubbard <bhubbard@redhat.com>, Avner Ben Hanoch <avnerb@mellanox.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Here's a PR:

	https://github.com/ceph/ceph/pull/11007

I suggest we merge this, and then do an upstream dev release to shake 
out any lingering toolchain dependencies on autotools.

sage
