From: Sebastien Ponce <sebastien.ponce@cern.ch>
Subject: Re: HSM
Date: Mon, 11 Nov 2013 10:58:58 +0100
Message-ID: <1384163938.31084.4.camel@sebmain.cern.ch>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
	 <5D7F9996EA547448BC6C54C8C5AAF4E5D980ABD2@CERNXCHG02.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:21498 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab3KKKCi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 11 Nov 2013 05:02:38 -0500
In-Reply-To: <5D7F9996EA547448BC6C54C8C5AAF4E5D980ABD2@CERNXCHG02.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Bell <Tim.Bell@cern.ch>
Cc: Sage Weil <sage@inktank.com>, "<ceph-devel@vger.kernel.org>" <ceph-devel@vger.kernel.org>

> - Keeping the tape drives busy js always difficult=85 tape drives are
> now regularly exceeding 250MB/s on a single stream so the storage
> system needs to be able to maintain a high data rate. Tape drive
> performance drops rapidly when the drives have to stop and then
> restart as the buffers fill up again.

This is actually where the striping on top of librados is helping us
(see my other mail). The striping allows to read concurrently from
several ceph nodes concurrently (with some read ahead and using
asynchronous reading) and allows to achieve much more than 250MB/s
(already foreseeing next generation...).

Sebastien


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
