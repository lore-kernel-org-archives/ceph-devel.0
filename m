From: tsuna <tsunanet@gmail.com>
Subject: Re: remove PG
Date: Wed, 23 Feb 2011 08:32:39 -0800
Message-ID: <AANLkTi=EaGCrLCPEAK2wTzrg3kfbLDK5==Gmxk7kvDNN@mail.gmail.com>
References: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com> <80D6C20AE5D54E9E88B87ED7D1FF2E67@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64415 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1BWQdC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 11:33:02 -0500
Received: by wyg36 with SMTP id 36so1016830wyg.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 08:33:00 -0800 (PST)
In-Reply-To: <80D6C20AE5D54E9E88B87ED7D1FF2E67@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: H Chang <heracles@gmail.com>, ceph-devel@vger.kernel.org

On Wed, Feb 23, 2011 at 8:15 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> Looks like at present this is only used when OSDs are hosting a PG that they shouldn't have any more. So if a PG goes down and comes back up, it might be missing some map updates and contain "stray" PGs.

Did you mean "if an OSD goes down"?  Or are PGs keeping track of map
updates for whatever reason?

-- 
Benoit "tsuna" Sigoure
Software Engineer @ www.StumbleUpon.com
