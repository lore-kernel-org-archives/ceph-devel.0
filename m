From: Dan Mick <dan.mick@inktank.com>
Subject: running without cephx
Date: Tue, 23 Oct 2012 13:14:57 -0700
Message-ID: <5086FAC1.3030706@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41477 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179Ab2JWUPA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Oct 2012 16:15:00 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3013904pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 23 Oct 2012 13:15:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

So, I've discovered that to make "no cephx" work, you need to explicitly 
set "none" for the three options (thanks to Yehuda for the tip):

         auth cluster required = none
         auth service required = none
         auth supported = none

Since "blank" is not an error, but leads to a disagreement about 
authentication that's fairly hard to diagnose, should we make it an 
error to specify a blank entry for those items?

I'll also be hacking at vstart.sh to set things this way in the presence 
of -X.

