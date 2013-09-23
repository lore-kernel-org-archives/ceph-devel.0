From: Sage Weil <sage@inktank.com>
Subject: Re: Object Write Latency
Date: Mon, 23 Sep 2013 11:18:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309231115520.7394@cobra.newdream.net>
References: <3472A07E6605974CBC9BC573F1BC02E4A52724A9@PLOXCHG03.cern.ch> <CAPYLRziY9YVXp+zW8dS9+dN-r24AXXG84wx0ZgQFtpX2C1Pnfg@mail.gmail.com> <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60461 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab3IWSSW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 14:18:22 -0400
In-Reply-To: <CABZ+qqnHf9NG5JirYNtT6LUEbzo52U43Arooo5-CNXR2SPPKaA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Gregory Farnum <greg@inktank.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 23 Sep 2013, Dan van der Ster wrote:
> The journals are on the same spinning disk & partition as the OSD
> data. Each spinning disk is 1 OSD.

Quick clarification: do you mean that the journal is a file on the same fs 
as osd_data?  If so, moving it to a separate partition on the same disk 
usually helps quite a bit.  The overhead of a write+fsync inside the fs 
tends to be much higher than an direct-io write to another partition. You 
might try measuring that directly and comparing it to the 33ms 
append+fsync that you previously saw.

sage
