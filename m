From: Sage Weil <sweil@redhat.com>
Subject: Re: Fwd: S3 API Compatibility support
Date: Fri, 25 Jul 2014 08:49:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407250848060.22752@cobra.newdream.net>
References: <CANA9Uk55UZXtKzS=urk3Q+KY=DoWoTaCRf=rKiEtjt9y7FYw7A@mail.gmail.com> <CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57353 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760711AbaGYPt0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 11:49:26 -0400
In-Reply-To: <CANA9Uk6E9t30Ve3pKhZa1cW4g6N7JjzG8JgiwOoDa9TWdNEagQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 25 Jul 2014, M Ranga Swami Reddy wrote:
> Hi Team: As per the ceph document a few S3 APIs compatibility not supported.
> 
> Link: http://ceph.com/docs/master/radosgw/s3/
> 
> Is there plan to support the ?n supported item in the above table?
> or
> Any working on this?

Yes.  Unfortunately this table isn't particularly detailed or accurate or 
up to date.   The main gap, I think, is versioned objects.

Are there specfiic parts of the S3 API that are missing that you need?  
That sort of info is very helpful for prioritizing effort...

sage
