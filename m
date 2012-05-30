From: Gregory Farnum <greg@inktank.com>
Subject: Re: NFS re-exporting CEPH cluster
Date: Wed, 30 May 2012 08:30:43 -0700
Message-ID: <E35ED251461442369738071603FE936C@inktank.com>
References: <loom.20120524T071113-43@post.gmane.org>
 <EAA87E18111B4AFFB0F9758A2C6F2C67@inktank.com>
 <loom.20120529T161529-853@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48491 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab2E3PaZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 11:30:25 -0400
Received: by dady13 with SMTP id y13so7071783dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 30 May 2012 08:30:25 -0700 (PDT)
In-Reply-To: <loom.20120529T161529-853@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>



On Tuesday, May 29, 2012 at 7:18 AM, madhusudhana U wrote:

> Greg Farnum <greg <at> inktank.com (http://inktank.com)> writes:
> 
> > 
> > Have you tried something and it failed? Or are you looking for suggestions?
> > If the former, please report the failure. :)
> > If the latter: http://ceph.com/wiki/Re-exporting_NFS
> > -Greg
> 
> 
> 
> Greg,
> I have tried the link. But, my production build (t_make) is failing on the
> NFS exported ceph_cluster where as it runs fine over another NFS directory
> coming from a NFS server.

How is it failing?

> Is CEPH is 100% compatible with NFS ?
It ought to work, although I've heard of a few bugs which I believe are generally related to inode size. Are you running a 32- or 64-bit system?

