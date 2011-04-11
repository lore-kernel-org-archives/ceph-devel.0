From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Fw: re-exporting nfs
Date: Mon, 11 Apr 2011 10:50:00 -0700
Message-ID: <20110411175000.GA2099@dreamer>
References: <19ABB379BFC8469C8A53FD5B3E4BD875@PC201010310710>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42487 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab1DKRuA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 13:50:00 -0400
Content-Disposition: inline
In-Reply-To: <19ABB379BFC8469C8A53FD5B3E4BD875@PC201010310710>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuki <chengmao2010@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Apr 10, 2011 at 02:45:19PM +0800, Yuki wrote:
> I was confused by two things during the test on nfs.
> 1. The "dd" command will call mknod to create a file,but mknod will
> creates a FIFO, character special file, or block special file with
> the specified name.(It will call lookup_open to create a file during
> the test on ceph,)

This is pretty much out of topic for Ceph, but I figured I'd just
clarify this: an mknod(2) call with mode specifying S_IFREG creates
regular files.

-- 
:(){ :|:&};:
