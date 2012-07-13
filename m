From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] ceph: fix potential double free
Date: Fri, 13 Jul 2012 11:53:48 -0500
Message-ID: <5000529C.50202@inktank.com>
References: <20120713142839.23587.58658.stgit@localhost.localdomain> <50003289.5010805@inktank.com> <20120713155610.4638b307@pyramind.ukuu.org.uk> <50004140.8010901@inktank.com> <20120713173722.1786d02f@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:64460 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002Ab2GMQxu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 12:53:50 -0400
Received: by gglu4 with SMTP id u4so3788808ggl.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 09:53:50 -0700 (PDT)
In-Reply-To: <20120713173722.1786d02f@pyramind.ukuu.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ceph-devel@vger.kernel.org

On 07/13/2012 11:37 AM, Alan Cox wrote:
>> Is that clear?  Is there something I'm still missing?
> 
> Basically if they are not invariant I don't see why it can't go around
> the loop, allocate the buffer, free it and then the next time find there
> is nothing there and thus double free.
> 
> Either way if its patched the problem goes away so it's mostly for my own
> understanding.

The key is that xattrs is a local variable I think.

1)  enter the "if" block
2)  spin_unlock()
3)  xattrs = kcalloc()...
4)  spin_lock()
5)  version changes, so:
6)    kfree everything (now xattrs is invalid)
7)    goto start

Then either:
8a) re-enter the "if" block
9a) spin_unlock()
10a) xattrs = kcalloc()... <- now xattrs is valid again
. . .

Or:
8b)  do not enter the "if" block
9b)  return err... <- xattrs is not referenced again

					-Alex


