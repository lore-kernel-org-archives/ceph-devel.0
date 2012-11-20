From: Sage Weil <sage@inktank.com>
Subject: Re: does still not recommended place rbd device on nodes, where osd
 daemon located?
Date: Tue, 20 Nov 2012 08:50:20 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211200849080.7369@cobra.newdream.net>
References: <CAHULbCmY6j3GbRFs_fyO1VP5_-BG5Cg1H_Kvfg1nN3jMMpyvHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45572 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab2KTQuV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 11:50:21 -0500
In-Reply-To: <CAHULbCmY6j3GbRFs_fyO1VP5_-BG5Cg1H_Kvfg1nN3jMMpyvHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 20 Nov 2012, ruslan usifov wrote:
> Hello
> 
> Now i can't find link where i read this info (this was old ceph wiki)
> but there was written that rbd on osd can prevent hung. Does this
> situation actual for present days?

This is still the case when using the kernel RBD or cephfs drivers.

Workarounds include using librbd+qemu, or kernel RBD from within a VM. 

sage
