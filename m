From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: qemu librbd patches
Date: Mon, 09 May 2011 08:22:34 -0700
Message-ID: <b8e9ad3a8d7059ac8be7592fe18b38c8@hq.newdream.net>
References: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:53294 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381Ab1EIPXR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2011 11:23:17 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 4385217DA10
	for <ceph-devel@vger.kernel.org>; Mon,  9 May 2011 08:23:17 -0700 (PDT)
In-Reply-To: <BANLkTim4jTVJH5y6o5rHq8pm_KfH0Jiz0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Mon, 9 May 2011 10:59:41 +0200, Christian Brunner <chb@muc.de>
wrote:
> Hi,
> 
> after upgrading to qemu with josh's librbd patches I'm triggering the
> following assertion, when I'm running "yum upgrade" inside a guest.
> 
> I suspect there is a race condition somewhere, but I don't have a clue
> at the moment.

This is similar to a race condition Stefan encountered
(http://marc.info/?l=kvm&m=130225223223016&w=2),
although this crash was during a write whereas his test was just
reading the image.

> 
> Regards,
> Christian
> 
> common/Mutex.h: In function 'void Mutex::Lock(bool)', in thread
> '0x7fea16b36700'
> common/Mutex.h: 118: FAILED assert(r == 0)

Usually this assert fails due to a use-after-free. If you've got
a core file, could you print the lock that hit this assert and
the data structure containing it?

Thanks!
Josh
