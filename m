From: Sage Weil <sage@newdream.net>
Subject: Re: pdj-fstest mkdir/rm error messages  again
Date: Thu, 17 Jun 2010 09:15:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006170913550.6914@cobra.newdream.net>
References: <hvdd15$r1o$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58626 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990Ab0FQQOL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jun 2010 12:14:11 -0400
In-Reply-To: <hvdd15$r1o$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Hi Thomas,

On Thu, 17 Jun 2010, Thomas Mueller wrote:
> for a while the pdj-fstest worked without error messages. 
> 
> now the pdj-fstest says again "successfull" but prints these:
> 
> /home/tmu//home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/02.t ..... ok
> mkdir: cannot create directory `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long
> rm: cannot remove `_xxveryveryveryverylongxxxxxx': File name too long
> /home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t ..... oksrc/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/02.t ..... ok
> mkdir: cannot create directory `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long
> rm: cannot remove `_xxveryveryveryverylongxxxxxx': File name too long
> /home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t ..... ok

This is a kernel client thing that was fixed by 
558d3499bd059d4534b1f2b69dc1c562acc733fe (merged into 2.6.35-rc3).  Can 
you confirm that you saw this with something older than that?

Thanks-
sage
