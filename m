From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: bonnie++ issue with Ceph
Date: Thu, 8 Jul 2010 15:14:45 +0200
Message-ID: <201007081514.45970.cray@unix-ag.uni-kl.de>
References: <201007081449.38981.cray@unix-ag.uni-kl.de> <i14i3l$hn$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:49636 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757237Ab0GHNOv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jul 2010 09:14:51 -0400
In-Reply-To: <i14i3l$hn$2@dough.gmane.org>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

I use ceph-kclient-0.20 with ceph-0.20

Should I try a newer version?

Best Regards,
   Christian 




Am Donnerstag, 8. Juli 2010 schrieb Thomas Mueller:
> Am Thu, 08 Jul 2010 14:49:38 +0200 schrieb Christian Baun:
> 
> > Hi,
> > When I try to test the performance of a Ceph installation with bonnie++,
> > I get this error message:
> > 
> > Bonnie: drastic I/O error (rmdir): Directory not empty Cleaning up test
> > directory after error.
> > 
> > Is this a known problem?
> 
> what version are you using? fuse oder kernel client?
> 
> there solved issues in the unstable tree. my bonnie++ tests run fine. 
> 
> - Thomas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


