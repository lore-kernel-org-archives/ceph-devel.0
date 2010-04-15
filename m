From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch won't come online
Date: Thu, 15 Apr 2010 11:02:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004151101460.15369@cobra.newdream.net>
References: <1271345141.4713.25.camel@wido-desktop>
 <Pine.LNX.4.64.1004151018580.15369@cobra.newdream.net>
 <1271354193.3520.6.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab0DOSAV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 14:00:21 -0400
In-Reply-To: <1271354193.3520.6.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

On Thu, 15 Apr 2010, Wido den Hollander wrote:
> I've placed "debug osd = 20" in [global], [osd] and [osd1], but it
> didn't seem to change much to the log itself.
> 
> Attached you'll find the log of "osd1"

My bad, you actually need 'debug filestore = 20' to get the error message 
I'm after!

sage
