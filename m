From: Greg Farnum <greg@inktank.com>
Subject: Re: NFS re-exporting CEPH cluster
Date: Thu, 24 May 2012 11:00:50 -0700
Message-ID: <EAA87E18111B4AFFB0F9758A2C6F2C67@inktank.com>
References: <loom.20120524T071113-43@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56928 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab2EXSAy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:00:54 -0400
Received: by dady13 with SMTP id y13so71707dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:00:53 -0700 (PDT)
In-Reply-To: <loom.20120524T071113-43@post.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Madhusudhana U <madhusudhana.u.acharya@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, May 23, 2012 at 10:14 PM, Madhusudhana U wrote:
> Hi all,
> Can anyone tried re-exporting CEPH cluster via NFS with success (I mean to 
> say, mount the CEPH cluster in one of the machine and then export that via 
> NFS to clients)? I need to do this bcz of my client kernel version and some
> EDA tools compatibility.Can someone suggest me how I can successfully 
> re-export CEPH over NFS ?

Have you tried something and it failed? Or are you looking for suggestions?
If the former, please report the failure. :)
If the latter: http://ceph.com/wiki/Re-exporting_NFS
-Greg


