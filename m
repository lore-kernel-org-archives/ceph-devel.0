From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 09:31:09 -0800
Message-ID: <559027F2-E44B-40AE-AC8C-64B6B5CFD873@cs.ucsc.edu>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu> <Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net> <3F84686D-FB7B-4D7E-A893-8FA35FF5080D@cs.ucsc.edu> <AANLkTinsFU_FeqYQVEcy434GJKzkEs0n60=pvgmtEMpA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:39767 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab0K3RbK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:31:10 -0500
In-Reply-To: <AANLkTinsFU_FeqYQVEcy434GJKzkEs0n60=pvgmtEMpA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

> Based on my (unmerged) work writing a userspace client-based
> FileSystem for Hadoop, I don't think any JNI code is going to go into
> the Hadoop tree. So the striping strategy could easily go into the JNI
> code and be maintained separately from the Java code. :)

Ahh, excellent. That seems to resolve the issue :)

Thanks,
Noah
