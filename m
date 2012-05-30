From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: poor OSD performance using kernel 3.4
Date: Wed, 30 May 2012 08:33:11 +0200
Message-ID: <4FC5BF27.5060704@profihost.ag>
References: <4FBE415E.8030702@profihost.ag> <4FC54CDB.1000506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:52936 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2E3GdI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 02:33:08 -0400
In-Reply-To: <4FC54CDB.1000506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> 
> I setup some tests today to try to replicate your findings (and also
> check results against some previous ones I've done).  I don't think I'm
> seeing exactly the same results as you, but I definitely see xfs
> performing worse in this specific test than btrfs.  I've included the
> results here.
>
> Full results are available here:
> http://nhm.ceph.com/results/mailinglist-tests/

But these tests shows exactly he same bad behaviour i'm seeing. Instead
of having a constant sequential write ratio you've heavily jumping
values. Are you able to test with XFS and 3.0.32? You'll then probably
see an absolutely constant write ratio.

Greets,
Stefan
