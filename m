From: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Subject: Re: [PATCH 2/2] ceph: mark user pages dirty on direct-io reads
Date: Thu, 16 Dec 2010 13:50:40 +0800
Message-ID: <AANLkTim3vynUFKPFtciL7zqAmiefR5GVHfR-U9tBEjdh@mail.gmail.com>
References: <1292474959-2834-1-git-send-email-sage@newdream.net>
	<1292474959-2834-2-git-send-email-sage@newdream.net>
	<Pine.LNX.4.64.1012152115140.13669@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58861 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0LPFul convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Dec 2010 00:50:41 -0500
Received: by qyk12 with SMTP id 12so2954565qyk.19
        for <ceph-devel@vger.kernel.org>; Wed, 15 Dec 2010 21:50:40 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1012152115140.13669@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

> That aside, I have no idea if this patch is the right thing to do. =C2=
=A0I
> thought the page bits were mainly important for the page cache... wha=
t do
> we accomplish by marking user pages dirty this way?

Hmm.... It's just because I read this:
http://www.makelinux.net/ldd3/chp-15-sect-3.shtml

It says:
"Once your direct I/O operation is complete, you must release the user
pages. Before doing so, however, you must inform the kernel if you
changed the contents of those pages. Otherwise, the kernel may think
that the pages are "clean," meaning that they match a copy found on
the swap device, and free them without writing them out to backing
store. So, if you have changed the pages (in response to a user-space
read request), you must mark each affected page dirty with a call to:
void SetPageDirty(struct page *page);"

Maybe you are right. Without marking user pages dirty, my test program
also works fine.

Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
