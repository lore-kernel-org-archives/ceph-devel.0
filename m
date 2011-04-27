From: Sage Weil <sage@newdream.net>
Subject: Re: why client change "max_size" when writting?
Date: Wed, 27 Apr 2011 08:42:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104270840190.27415@cobra.newdream.net>
References: <BANLkTin4dUrh0J6TMjTv=w6bjC=dk7Gppw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33329 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231Ab1D0PmH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Apr 2011 11:42:07 -0400
In-Reply-To: <BANLkTin4dUrh0J6TMjTv=w6bjC=dk7Gppw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 27 Apr 2011, huang jun wrote:
> hi,developers
>   when write a file, why did client send a message to mds to change
> the variable "max_size" in inode  ? so, if we don't change the
> "max_size", what  consequence we  will get? and why the client will
> not write if the mds didn't return the changed "max_size" to client?

The max_size sets a bound on the number of data objects the client is 
allowed to write to, which in turn bounds the amount of work probing 
objects that MDS has to do if the client crashes to recover the file size 
and mtime.

Setting it larger will let the client write more data faster, but will 
mean more work if the client crashes.

sage
