From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 22:22:33 -0700
Message-ID: <50862999.6060208@inktank.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net> <508562A1.2040106@gmail.com> <50856F74.8020001@inktank.com> <508575C0.9080700@gmail.com> <alpine.DEB.2.00.1210220940020.31573@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47017 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab2JWFWg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 01:22:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2483066pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 22:22:36 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210220940020.31573@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Joe Buck <jbbuck@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> Possibly related: I just pushed a patch to master that enables cephx auth
> by default.  For the -X case we need to put in ceph.conf:
>
> 	auth cluster required =
> 	auth service required =

This was not added, and thus vstart.sh -X is currently broken.
