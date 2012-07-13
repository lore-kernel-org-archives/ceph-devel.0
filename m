From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 17:37:22 +0100
Message-ID: <20120713173722.1786d02f@pyramind.ukuu.org.uk>
References: <20120713142839.23587.58658.stgit@localhost.localdomain>
	<50003289.5010805@inktank.com>
	<20120713155610.4638b307@pyramind.ukuu.org.uk>
	<50004140.8010901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:33492 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030182Ab2GMQdl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 12:33:41 -0400
In-Reply-To: <50004140.8010901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

> Is that clear?  Is there something I'm still missing?

Basically if they are not invariant I don't see why it can't go around
the loop, allocate the buffer, free it and then the next time find there
is nothing there and thus double free.

Either way if its patched the problem goes away so it's mostly for my own
understanding.


