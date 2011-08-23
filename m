From: Sage Weil <sage@newdream.net>
Subject: Re: mount errors
Date: Mon, 22 Aug 2011 21:43:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108222142490.9949@cobra.newdream.net>
References: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59971 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1HWEif (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Aug 2011 00:38:35 -0400
In-Reply-To: <CAJD3hpWa7VXDNcEc7sOCZWUfm84Uo4vDxZ4OceNf+6OKt7RFGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jojy Varghese <jojy.varghese@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 22 Aug 2011, Jojy Varghese wrote:
> Hi
>  I am getting "libceph: bad fsid, had
> e49ae577-0f7b-24e0-1c75-10ae17d9f86b got
> 3c9b15ef-c2d0-1318-4d12-3508025ccd97" on attempting to mount the fs.
> Any quick fixes?

This means the client is getting data from a different file system than it 
originally mounted.  Probably you had the client mounted, rebuilt the fs 
and restarted the monitors, and now the client is confused because the 
servers were changed out from underneath it.

sage
