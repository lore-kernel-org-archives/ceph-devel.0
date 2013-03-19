From: Greg Farnum <greg@inktank.com>
Subject: Re: deb/rpm package purge
Date: Tue, 19 Mar 2013 12:59:28 -0700
Message-ID: <EFBA35D4FD5F4049BAACE86A9D42D737@inktank.com>
References: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:56628 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab3CST7b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 15:59:31 -0400
Received: by mail-da0-f44.google.com with SMTP id z20so515099dae.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 Mar 2013 12:59:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303191246330.4850@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, james.page@ubuntu.com, gcs@debian.hu

On Tuesday, March 19, 2013 at 12:48 PM, Sage Weil wrote:
> Should the package purge remove /var/lib/ceph/* (potential mon data, osd 
> data) and/or /var/log/ceph/* (logs)? Right now it does, but mysql, for 
> example, leaves /var/lib/mysql where it is (not sure about logs).
> 


I'm with Mark's ticket on this (http://tracker.ceph.com/issues/4505). Config data in /etc/ceph and logs in var/log/ceph is fine to remove, but storage data isn't. That's essentially user-generated and not something that can be recovered or rebuilt following the purge. Keyrings might not be unreasonable to delete, but I don't think they're necessary and certainly aren't worth putting in the work to separate from the other user data in var/lib/ceph.

-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


