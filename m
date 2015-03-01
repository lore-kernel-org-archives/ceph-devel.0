From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: v0.93 Hammer release candidate released
Date: Sun, 01 Mar 2015 23:04:49 +0100
Message-ID: <54F38D01.6070200@bisect.de>
References: <alpine.DEB.2.00.1502271408230.1577@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:37197 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbbCAWEy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Mar 2015 17:04:54 -0500
In-Reply-To: <alpine.DEB.2.00.1502271408230.1577@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

Am 27.02.2015 um 23:10 schrieb Sage Weil:
> This is the first release candidate for Hammer, and includes all
> of the features that will be present in the final release.  We
> welcome and encourage any and all testing in non-production
> clusters to identify any problems with functionality, stability, or
> performance before the final Hammer release.
> 
> We suggest some caution in one area: librbd.  There is a lot of
> new functionality around object maps and locking that is disabled
> by default but may still affect stability for existing images.  We
> are continuing to shake out those bugs so that the final Hammer
> release (probably v0.94) will be stable.

I've opened bug #10981. This one should get fixed for Hammer GM since
the core code of ceph shouldn't throw any -Wdeprecated-declarations
warnings during compilation.

Danny
