From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: remove PG
Date: Wed, 23 Feb 2011 08:15:43 -0800
Message-ID: <80D6C20AE5D54E9E88B87ED7D1FF2E67@gmail.com>
References: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62183 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab1BWQPv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 11:15:51 -0500
Received: by yxs7 with SMTP id 7so1321834yxs.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 08:15:51 -0800 (PST)
In-Reply-To: <AANLkTimGyBpOPWKDV6iOHUqkDWvcQ_biSJzvsLuE+=JJ@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: H Chang <heracles@gmail.com>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Wednesday, February 23, 2011 at 7:57 AM, H Chang wrote:
Hi,
> 
> I was browsing PG management code in Ceph, and have one question.
> 
> It appears that an OSD could send a PG removal request to another OSD.
> The recipient OSD would then remove that particular PG from its pg_map.
> 
> I'd like to know under what circumstances an OSD would want to remove PGs.
Looks like at present this is only used when OSDs are hosting a PG that they shouldn't have any more. So if a PG goes down and comes back up, it might be missing some map updates and contain "stray" PGs. 
Though it should eventually figure that out on its own...I'm not at all sure this is necessary; it might just be fallback code. Somebody else might know more! :)

In the future there might be other reasons, of course -- at some point we want to enable pool shrinking, where PGs are consolidated with each other and the number of total PGs is reduced in case a pool shrinks. (PGs do have some maintenance overhead which it's good to eliminate if possible.)
-Greg



