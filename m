From: Sage Weil <sage@inktank.com>
Subject: Re: Handle bad file descriptors with EBADF
Date: Sun, 4 Nov 2012 04:17:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211040412570.30792@cobra.newdream.net>
References: <CAPrxi5-9xAaUnJp5dhyvGpZ4rZ0cM=F6TcvtdBNi53EhSzU_NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42120 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab2KDMRM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Nov 2012 07:17:12 -0500
In-Reply-To: <CAPrxi5-9xAaUnJp5dhyvGpZ4rZ0cM=F6TcvtdBNi53EhSzU_NA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 3 Nov 2012, Noah Watkins wrote:
> The libcephfs interface asserts valid file descriptors, so clients are
> forced to manage this or risk crashes. Pushed to wip-bad-fd is changes
> that handle this case by returning -EBADF. Review welcome :)

This looks good to me.  The one thing I'd change before merging is to use 
an iterator and find() in the get_filehandle() helper.  Most existing code 
does something like

	if (container.count(key))
		return container[key];

but this is actually doing the lookup twice.  A better pattern:

	map<foo, bar>::iterator p = container.find(key);
	if (p == container.end())
		return NULL;
	return p->second;

Hopefully someday a motivated person with OCD will go through and convert 
existing code to do this.

	http://tracker.newdream.net/issues/432

sage
