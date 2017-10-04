From: Sage Weil <sage@newdream.net>
Subject: Re: Mimic timeline
Date: Wed, 4 Oct 2017 21:46:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710042110310.28409@piezo.us.to>
References: <alpine.DEB.2.11.1710042054030.27705@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:45871 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdJDVqa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Oct 2017 17:46:30 -0400
In-Reply-To: <alpine.DEB.2.11.1710042054030.27705@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com, ceph-users@ceph.com

On Wed, 4 Oct 2017, Sage Weil wrote:
> Hi everyone,
> 
> After further discussion we are targetting 9 months for Mimic 13.2.0:
> 
>  - Mar 16, 2018 feature freeze
>  - May 1, 2018 release
> 
> Upgrades for Mimic will be from Luminous only (we've already made that a 
> required stop), but we plan to allow Luminous -> Nautilus too (and Mimic 
> -> O).

Also, each release will be stable, with bug fixes for 2 cycles (18 
months).  Here are the proposed changes to the release cycle docs:

	https://github.com/ceph/ceph/pull/18117/files

sage
