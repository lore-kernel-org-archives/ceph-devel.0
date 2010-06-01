From: Sage Weil <sage@newdream.net>
Subject: Re: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Tue, 1 Jun 2010 12:51:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006011250090.14408@cobra.newdream.net>
References: <hu03dh$vgc$1@dough.gmane.org> <AANLkTinYa6a6yqnbjBH99seMT4NJgXpQig38mV4rmEkM@mail.gmail.com>
 <hu06m8$vgc$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55275 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0FATvb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jun 2010 15:51:31 -0400
In-Reply-To: <hu06m8$vgc$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Mon, 31 May 2010, Thomas Mueller wrote:
> Am Mon, 31 May 2010 03:42:33 -0700 schrieb Gregory Farnum:
> 
> > Thomas:
> > The "file name too long" errors are actually supposed to occur in a
> > number of places in pjd-fstest -- it's part of the correctness testing!
> 
> I can't see these error messages if I run the test on the local fs. 

Fixed this.  The problem was that we were reporting PATH_MAX instead of 
NAME_MAX as the max file name length in statfs.  The pjd tests actually 
all succeeded, but the script would spit out those errors when trying to 
clean up.

Thanks for the heads up!
sage

