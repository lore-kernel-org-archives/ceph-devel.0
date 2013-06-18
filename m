From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Writing to RBD image while it's snapshot is being created causes I/O errors
Date: Tue, 18 Jun 2013 13:35:55 +0200
Message-ID: <10409403.4UItZS4bTH@karol-esprimo-p5925>
References: <1881883.Fj0UjQGoA9@karol-esprimo-p5925> <2147065.fKZgxGNGTf@karol-esprimo-p5925> <alpine.DEB.2.00.1306172125170.27409@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:46798 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab3FRLfQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 07:35:16 -0400
Received: by mail-ea0-f178.google.com with SMTP id l15so2411258eak.23
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jun 2013 04:35:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1306172125170.27409@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Monday 17 of June 2013 21:25:49 Sage Weil wrote:
> What kernel version are you using?  I'm not able to reproduce this with
> ext4 or reiserfs and many snapshots over several minutes of write
> workload.

I'm using vanilla 3.4.48. However, this bug must already have been fixed in 
3.6.11 because everything worked fine when I tested this version today.

-- 
Karol Jurak
