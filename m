From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: filename too long (pjd-fstest on centos5 with ceph 0.20.2)
Date: Sat, 5 Jun 2010 07:38:26 +0000 (UTC)
Message-ID: <hucuti$5aa$2@dough.gmane.org>
References: <hu03dh$vgc$1@dough.gmane.org>
	<AANLkTinYa6a6yqnbjBH99seMT4NJgXpQig38mV4rmEkM@mail.gmail.com>
	<hu06m8$vgc$2@dough.gmane.org>
	<Pine.LNX.4.64.1006011250090.14408@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50699 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755249Ab0FEHil (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jun 2010 03:38:41 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OKnxm-0005Ge-Hf
	for ceph-devel@vger.kernel.org; Sat, 05 Jun 2010 09:38:38 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 09:38:38 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 05 Jun 2010 09:38:38 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Tue, 01 Jun 2010 12:51:45 -0700 schrieb Sage Weil:

> On Mon, 31 May 2010, Thomas Mueller wrote:
>> Am Mon, 31 May 2010 03:42:33 -0700 schrieb Gregory Farnum:
>> 
>> > Thomas:
>> > The "file name too long" errors are actually supposed to occur in a
>> > number of places in pjd-fstest -- it's part of the correctness
>> > testing!
>> 
>> I can't see these error messages if I run the test on the local fs.
> 
> Fixed this.  The problem was that we were reporting PATH_MAX instead of
> NAME_MAX as the max file name length in statfs.  The pjd tests actually
> all succeeded, but the script would spit out those errors when trying to
> clean up.
> 
> Thanks for the heads up!
> sage

just tested the ceph-client-standalone/master-backport - the messages* 
are gone. Thanks!

- Thomas

* http://chaschperli.ch/testing/testDetails.php?test=88&build=47

