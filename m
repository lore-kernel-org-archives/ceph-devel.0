From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: vstart problem in master branch
Date: Thu, 31 Mar 2011 11:06:52 -0700
Message-ID: <20110331180652.GA12850@dreamer>
References: <B6DAFB0C-A321-499A-A21E-7CA59EFCDA5B@cs.ucsc.edu>
 <054B710EFF18497CB0B964DC9819B556@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33634 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454Ab1CaSGy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2011 14:06:54 -0400
Content-Disposition: inline
In-Reply-To: <054B710EFF18497CB0B964DC9819B556@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel@vger.kernel.org

On Thu, Mar 31, 2011 at 11:04:36AM -0700, Gregory Farnum wrote:
> I think that's the user_xattr error (if you don't have user xattrs enabled on the mount).

Yup, I agree with this diagnosis.

We should make that error more obvious: http://tracker.newdream.net/issues/952

-- 
:(){ :|:&};:
