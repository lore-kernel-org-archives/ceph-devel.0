From: Gregory Farnum <greg@inktank.com>
Subject: Re: btrfs big metadata
Date: Mon, 2 Jul 2012 09:42:56 -0700
Message-ID: <CAPYLRzjDHf7m3BujRPw=BB_XHqrRqshgHjRetSqrb-EPF4GgXg@mail.gmail.com>
References: <4FF1461D.9060304@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61303 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab2GBQm5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 12:42:57 -0400
Received: by lbbgm6 with SMTP id gm6so7879028lbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Jul 2012 09:42:56 -0700 (PDT)
In-Reply-To: <4FF1461D.9060304@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Jul 1, 2012 at 11:56 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hello list,
>
> i found several people who use big metadata -n 64k -l 64k for ceph. But i
> haven't found any ceph doc or info why to use this?
>
> What's the reason to use big metadata feature with ceph?

One of the big problems users have had with Ceph-on-btrfs is that
Ceph's usage patterns cause btrfs to dramatically fragment its
metadata. Big metadata blocks reduce this fragmentation to a level
where some users find it faster than xfs (which it previously wasn't).
-Greg
