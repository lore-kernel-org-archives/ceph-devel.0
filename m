From: Sage Weil <sage@newdream.net>
Subject: Re: Complete failure
Date: Wed, 1 Feb 2017 16:59:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702011658540.3660@piezo.novalocal>
References: <00714C12C9081745920784D8E0927CCF03B87890E130@E2K7CCR.cewit.stonybrook.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52745 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbdBAQ7Q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 11:59:16 -0500
In-Reply-To: <00714C12C9081745920784D8E0927CCF03B87890E130@E2K7CCR.cewit.stonybrook.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Boris Yakovich <Boris.Yakovich@cewit.stonybrook.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 1 Feb 2017, Boris Yakovich wrote:
> Hi Guys,
> 
> I have a three node test environment I have been playing with. 
> Each node has two hard drives one runs the OS, the second ceph data.
> One node had a hard disk failure on the OS disk. I reinstalled the OS (Ubuntu 14),
> And tried to add it back into the cluster. Now the entire cluster is failing.
> I'm pretty new to this and completely lost how to get it back up.
> Ceph -s just shows lines and lines of fault errors. It seems all the monitors are down. 

If you reinstalled the OS you are probably everything in /etc/ceph 
(ceph.conf and the keyring files).

s
