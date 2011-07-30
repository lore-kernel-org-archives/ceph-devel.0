From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Kernel 3.0.0 + ext4 + ceph == ...
Date: Sat, 30 Jul 2011 11:34:35 -0400
Message-ID: <9BF9E529-C532-4A94-8362-93C2D1B778DB@mit.edu>
References: <4E33D101.1050504@ufm.su>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-2.MIT.EDU ([18.9.25.13]:56399 "EHLO
	dmz-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751419Ab1G3Pei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Sat, 30 Jul 2011 11:34:38 -0400
In-Reply-To: <4E33D101.1050504@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org


On Jul 30, 2011, at 5:38 AM, Fyodor Ustinov wrote:

> fail. Epic fail
> 
> Inode 238551053, i_blocks is 24, should be 32.  Fix? yes
> 
> Inode 238551054, i_blocks is 40, should be 32.  Fix? yes
> ...

Fyodor, what kernel were you using?  Was it a RHEL 6.x
kernel, like Christian?

I haven't had an opportunity to play with Ceph in about six
months, but when I did I was using a much more recent
ext4 code base (backported onto 2.6.34, where as RHEL
was based on 2.6.32, but more importantly we were much
more aggressive at backporting fixes onto our kernel).

I didn't see anything like what you're reporting.

If this is with a much more recent kernel, I'd definitely be
interested.  Since the Ceph server is a pure userspace
application, if you can cause file system corruption which
e2fsck has to fix, that's definitely an ext4 bug.

Regards,

-- Ted

P.S  Ext4 in the RHEL 6.x kernel is I believe a technology
preview, which means it might not get full support from
Red Hat.  Still, if you do see those sorts of problems with
ext4 on a RHEL kernel, and you have a valid Red Hat 
support contract, I'd definitely encourage you to file a
bug with the distro.

