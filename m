From: Sage Weil <sage@newdream.net>
Subject: Re: osd dm-crypt key management, seconde partie
Date: Wed, 24 Feb 2016 17:35:28 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602241733260.7555@cpach.fuggernut.com>
References: <56CD9E7A.2050901@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57017 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbcBXWf6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 17:35:58 -0500
In-Reply-To: <56CD9E7A.2050901@dachary.org>
Content-ID: <alpine.DEB.2.11.1602241734381.7555@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, jschmid@suse.de
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 24 Feb 2016, Loic Dachary wrote:
> Hi,
> 
> A first implementation[1] of the key management scheme[2] was completed 
> today (it passes tests, integration and make check). While work is done 
> to add tests to verify legacy key storage support, it would be great to 
> get reviews and feedback. There is little time before the jewel merge 
> window closes: now would be a perfect time to catch blockers :-)

Great!  I skimmed the patchset (on my phone) and it looked clean and sane 
to me.  Joshua, maybe you can take a look at make sure this approach meets 
your needs as well?

Thanks!
sage
