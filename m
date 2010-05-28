From: Thomas Mueller <thomas@chaschperli.ch>
Subject: Re: ceph.spec for Centos 5
Date: Fri, 28 May 2010 08:13:55 +0000 (UTC)
Message-ID: <htnu03$l6k$2@dough.gmane.org>
References: <htlluv$70g$2@dough.gmane.org>
	<Pine.LNX.4.64.1005271424210.27661@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35226 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684Ab0E1IOI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 28 May 2010 04:14:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1OHuhj-0000Gs-CO
	for ceph-devel@vger.kernel.org; Fri, 28 May 2010 10:14:07 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 10:14:07 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Fri, 28 May 2010 10:14:07 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Thu, 27 May 2010 14:26:38 -0700 schrieb Sage Weil:

> Hi Thomas,
> 
> On Thu, 27 May 2010, Thomas Mueller wrote:
>> hi
>> 
>> i've took the ceph.spec from the 0.20.1 tar.gz and modified it to work
>> with Centos 5.
>> 
>> i've sucessfully built/installed/uninstalled the package (but not tried
>> to use it yet)
>> 
>> get the .spec file here:
>> http://pastebin.com/JBSBWUbB
> 
> Thanks.
> 
> It looks like your changes are all RHEL <= 5, Fedora <= 9 specific, with
> the exception of the build-requires changes, which I've updated in git.

these new files needed to be included as well:

%{_bindir}/dumpjournal
%{_bindir}/dupstore
%{_bindir}/radosacl
%{_bindir}/streamtest
%{_bindir}/test*



