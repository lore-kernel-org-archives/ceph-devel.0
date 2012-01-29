From: Sage Weil <sage@newdream.net>
Subject: Re: Files under ceph-mon's auth directory
Date: Sun, 29 Jan 2012 09:47:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1201290947120.28466@cobra.newdream.net>
References: <CANExM-N2yrdFwzv4tr7wYZ_mEh_-kSn9OrOyzqwcB2sTJh0G8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55088 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232Ab2A2Rrc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jan 2012 12:47:32 -0500
In-Reply-To: <CANExM-N2yrdFwzv4tr7wYZ_mEh_-kSn9OrOyzqwcB2sTJh0G8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 30 Jan 2012, Henry C Chang wrote:
> After running ceph for months, the ceph-mon's auth directory contains
> 117729 files, around 473MB. Unlike pgmap or logm, the files under auth
> directory seems never been trimmed. It causes that adding a mon takes
> a long long time. Is there a way to avoid it?

None of the auth data is exposed outside of the monitor, so it should be 
trivial to trim it. I'll stick it in the tracker.

Thanks!
sage
