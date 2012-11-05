From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: chaning pg_num / pgp_num after adding more osds
Date: Mon, 05 Nov 2012 15:45:06 -0800
Message-ID: <50984F82.3010706@inktank.com>
References: <5097C9DD.3030600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42508 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2KEXp0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 18:45:26 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2901887dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 15:45:26 -0800 (PST)
In-Reply-To: <5097C9DD.3030600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/05/2012 06:14 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> Is there a way to change the number of pg_num / pgp_num after adding
> more osds?

The pg_num/pgp_num settings are only used by mkcephfs at install time.

> I mean i would like to start with 16 OSDs but i think i'll expand over
> time to up to 100 OSDs. So i think i need to tune pg_num / pgp_num.

You can specify pg_num when creating a pool:

ceph osd pool create <name> <pgnum>

But you don't want to have too many (thousands per osd). Being able
to change the number of pgs in a pool (pg splitting/merging) is in
the works, but in the mean time you can create more pools after you add
a bunch of osds to keep your pg/osd ratio around 100.

Josh
