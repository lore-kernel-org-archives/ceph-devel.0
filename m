From: Sage Weil <sage@newdream.net>
Subject: Re: rbd
Date: Thu, 12 May 2011 10:01:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105121001160.19492@cobra.newdream.net>
References: <201105121353.44166.ufm@ufm.su> <Pine.LNX.4.64.1105120833410.19492@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:32797 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758080Ab1ELRBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 May 2011 13:01:08 -0400
In-Reply-To: <Pine.LNX.4.64.1105120833410.19492@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, 12 May 2011, Sage Weil wrote:
> equation.  I'm running iozone on ext3 now and not having any problems.

I take it back.. I just reproduced a similar error on ext2:

                                                            random  random    
bkwd   record   stride                                   
              KB  reclen   write rewrite    read    reread    read   write    
read  rewrite     read   fwrite frewrite   fread  freread
         4194304      64    3570    3040    12640    13725

Error in file: Found ?aaaaaaaaaaaaaaaa? Expecting ?3838383838383838? addr 
40a00000
Error in file: Position 2813329408 
Record # 42928 Record size 64 kb 
where 40a00000 loop 0

I opened a tracker issue http://tracker.newdream.net/issues/1086

sage
