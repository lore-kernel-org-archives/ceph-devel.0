From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Disabling journal
Date: Sun, 11 Nov 2012 22:33:50 +0100
Message-ID: <50A019BE.9030002@profihost.ag>
References: <F905E0C9-46B6-4DD7-A57D-072CD4ADDFEE@profihost.ag> <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42349 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab2KKVdv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Nov 2012 16:33:51 -0500
In-Reply-To: <alpine.DEB.2.00.1211110722100.28418@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

> With btrfs, yes, although this isn't something we have tested in a while.
I'm not using btrfs as long as the devs claim it is not ready for prod.

> You'd need to play with 'filestore min sync interval' and 'filestore max
> sync interval' to basically pick your latency range.
Any suggestions? Right now i've 500MB tmpfs journal per SSD.

Stefan
