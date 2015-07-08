From: Sage Weil <sage@newdream.net>
Subject: Re: librados clone_range
Date: Wed, 8 Jul 2015 06:22:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507080622380.27973@cobra.newdream.net>
References: <14671826.29748867.1435083472672.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44208 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbGHNWw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jul 2015 09:22:52 -0400
In-Reply-To: <14671826.29748867.1435083472672.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

On Tue, 23 Jun 2015, Samuel Just wrote:
> ObjectWriteOperations currently allow you to perform a clone_range from 
> another object with the same object locator.  Years ago, rgw used this 
> as part of multipart upload.  Today, the implementation complicates the 
> OSD considerably, and it doesn't appear to have any users left.  Is 
> there anyone who would be sad to see it removed from the librados 
> interface?

I won't miss it.

sage
