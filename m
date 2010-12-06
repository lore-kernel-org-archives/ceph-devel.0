From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: ioctl compatibility
Date: Mon, 6 Dec 2010 09:46:22 -0800
Message-ID: <AANLkTikq8reF0zk_47LW1Q6nM3pPfv+JG-Hk7P_fi4+K@mail.gmail.com>
References: <FB06A065-2077-41B8-9C55-74C5234DDFAC@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:60311 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0LFRqY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Dec 2010 12:46:24 -0500
Received: by ewy10 with SMTP id 10so7250267ewy.4
        for <ceph-devel@vger.kernel.org>; Mon, 06 Dec 2010 09:46:22 -0800 (PST)
In-Reply-To: <FB06A065-2077-41B8-9C55-74C5234DDFAC@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Sat, Dec 4, 2010 at 3:17 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Hi Greg,
>
> I noticed this patch changed the CEPH_IOCTL_MAGIC to 0x98, and is also synchronized with the user space Ceph tree, but the Ceph client that ships with Ubuntu 10.10 uses 0x97. There wasn't a change made by this patch to Documentation/ioctl/ioctl-numbers.txt, so I was curious if this was an oversight, and if not, how the userspace code could be made to adapt for the kernel shipping with 10.10.
Oh, wow. This was an inappropriate change which we're reverting now
and will make sure gets pushed upstream.
Thanks for noticing! :)
-Greg
