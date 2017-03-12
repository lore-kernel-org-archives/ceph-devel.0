From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.9: libceph: use BUG() instead of BUG_ON(1)
Date: Sun, 12 Mar 2017 20:48:42 +0100
Message-ID: <20170312194842.GA9122@kroah.com>
References: <74bce114-8471-cdec-8fae-2108930648e9@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935269AbdCLTxS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Mar 2017 15:53:18 -0400
Content-Disposition: inline
In-Reply-To: <74bce114-8471-cdec-8fae-2108930648e9@gmx.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sun, Mar 12, 2017 at 08:38:24PM +0100, Heinrich Schuchardt wrote:
> Dear Greg,
> 
> could you, please, consider the following patch for the next Linux 4.9
> release to avoid a build failure with gcc 4.9:
> 
> d24cdcd3e40a6825135498e11c20c7976b9bf545
> libceph: use BUG() instead of BUG_ON(1)

What about for 4.10-stable as well?  It would need it too?

And ugh, you really should update your version of gcc...

thanks,

greg k-h
