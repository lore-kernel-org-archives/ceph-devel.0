From: Sage Weil <sage@inktank.com>
Subject: Re: Writing to RBD image while it's snapshot is being created causes
 I/O errors
Date: Fri, 14 Jun 2013 08:56:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306140855170.26467@cobra.newdream.net>
References: <1881883.Fj0UjQGoA9@karol-esprimo-p5925>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50673 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930Ab3FNP44 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 11:56:56 -0400
In-Reply-To: <1881883.Fj0UjQGoA9@karol-esprimo-p5925>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Karol Jurak <karol.jurak@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 14 Jun 2013, Karol Jurak wrote:
> Hi,
> 
> I noticed that writing to RBD image using kernel driver while it's snapshot 
> is being created causes I/O errors and the filesystem (reiserfs) eventually 
> aborts and remounts itself in read-only mode:
> 
> [192507.327359] end_request: I/O error, dev rbd7, sector 818528
> [192507.331510] end_request: I/O error, dev rbd7, sector 819200
> [192507.348478] end_request: I/O error, dev rbd7, sector 408
> [192507.352647] REISERFS abort (device rbd7): Journal write error in 
> flush_commit_list
> 
> Is this happening by design or is it a bug? I know that I should freeze the 
> filesystem before attempting to create a snapshot but these I/O errors seem 
> unnecessary to me. If it's really impossible to write to an image while it's 
> snapshot is being created couldn't write requests be blocked until 
> snapshotting completes?
> 
> I'm using ceph 0.56.6 and kernel 3.4.48.

This is definitely a bug; you should be able to create a snapshot at any 
time.  After a rollback, it should look (to the fs) like a crash or power 
cycle.

How easy is this to reproduce?  Does it happen every time?

sage



> 
> -- 
> Karol Jurak
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
