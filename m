From: Sage Weil <sage@newdream.net>
Subject: Re: corrupt pg logs
Date: Thu, 23 Sep 2010 22:08:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009232204160.2831@cobra.newdream.net>
References: <Pine.LNX.4.64.1009230757330.16100@cobra.newdream.net>
 <AANLkTimU5s3Ti32BZGjMo4japLVJ0=aDLy7DV6BnN=sX@mail.gmail.com>
 <Pine.LNX.4.64.1009230858530.16100@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53820 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0IXFGZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Sep 2010 01:06:25 -0400
In-Reply-To: <Pine.LNX.4.64.1009230858530.16100@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org, henry_c_chang@tcloudcomputing.com

> > I am thinking to have a checksum for each log entry, when osd restart
> > and parse the log it will be able to detect if the data is corrupt.
> 
> Ah, yeah, that would be better.  The encoding format will have to change a 
> bit so that there is an entry length preceeding the entry, probably.  
> Something like
> 
>  <length><entry payload><crc32c>
> 
> so that we can validate before trying to decode the entry itself.

I created an osd_pglog_checksums branch that implements just the 
checksumming portion, and should transparently roll the disk format 
forward.  There should probably be a osd_compat CompatSet feature bit to 
reflect the ondisk format change.

It doesn't do anything intelligent yet, though.  The bufferlist and 
checksum decode in PG::read_log() should be in a try/catch block, and do 
something useful in the error case...

sage
