From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH] Expose Ceph data location information to Hadoop
Date: Tue, 30 Nov 2010 09:28:11 -0800
Message-ID: <AANLkTinsFU_FeqYQVEcy434GJKzkEs0n60=pvgmtEMpA@mail.gmail.com>
References: <EEFC0BFD-BF42-4E7E-A905-AB7F53ECE77A@cs.ucsc.edu>
	<Pine.LNX.4.64.1011300852460.4337@cobra.newdream.net>
	<3F84686D-FB7B-4D7E-A893-8FA35FF5080D@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61806 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754986Ab0K3R2N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 12:28:13 -0500
Received: by eye27 with SMTP id 27so2897651eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Nov 2010 09:28:12 -0800 (PST)
In-Reply-To: <3F84686D-FB7B-4D7E-A893-8FA35FF5080D@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, Joe Buck <buck@soe.ucsc.edu>, Carlos Maltzahn <carlosm@soe.ucsc.edu>

On Tue, Nov 30, 2010 at 9:17 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Whether or not this is an IOCTL that expands the ABI, or a user-level library that contains the striping strategy logic seems to be a decision for someone else, but the important thing is that striping strategy logic doesn't get distributed into arbitrary code bases such as Hadoop, requiring synchronization.
Based on my (unmerged) work writing a userspace client-based
FileSystem for Hadoop, I don't think any JNI code is going to go into
the Hadoop tree. So the striping strategy could easily go into the JNI
code and be maintained separately from the Java code. :)
-Greg
