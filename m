From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: pdj-fstest mkdir/rm error messages  again
Date: Thu, 17 Jun 2010 19:26:11 +0000 (UTC)
Message-ID: <hvdssj$mc9$1@dough.gmane.org>
References: <hvdd15$r1o$1@dough.gmane.org>
	<Pine.LNX.4.64.1006170913550.6914@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:58041 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757151Ab0FQT0Z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jun 2010 15:26:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OPKjH-000164-Ge
	for ceph-devel@vger.kernel.org; Thu, 17 Jun 2010 21:26:23 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 21:26:23 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jun 2010 21:26:23 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 17 Jun 2010 09:15:02 -0700 schrieb Sage Weil:

> Hi Thomas,
> 
> On Thu, 17 Jun 2010, Thomas Mueller wrote:
>> for a while the pdj-fstest worked without error messages.
>> 
>> now the pdj-fstest says again "successfull" but prints these:
>> 
>> /home/tmu//home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/
chmod/02.t
>> ..... ok mkdir: cannot create directory
>> `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long rm: cannot
>> remove `_xxveryveryveryverylongxxxxxx': File name too long
>> /home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t
>> ..... oksrc/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/02.t
>> ..... ok mkdir: cannot create directory
>> `_xxxxveryveryveryverylongxxxxxxxxxxx': File name too long rm: cannot
>> remove `_xxveryveryveryverylongxxxxxx': File name too long
>> /home/tmu/src/ceph-testsuite/tools/pjd-fstest-20080816/tests/chmod/03.t
>> ..... ok
> 
> This is a kernel client thing that was fixed by
> 558d3499bd059d4534b1f2b69dc1c562acc733fe (merged into 2.6.35-rc3).  Can
> you confirm that you saw this with something older than that?
> 
> Thanks-
> sage

this is on ceph-client-standalone/unstable-backport ref 
fe5b9c28ed9cfeb450233d7fedced4203f7a1d64 

compiled and loaded the module again. the messages are reproducable.


- Thomas

