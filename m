From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: inconsistent snapcolls
Date: Tue, 19 Mar 2013 15:14:56 +0100
Message-ID: <514872E0.3070708@profihost.ag>
References: <514821B0.3090706@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:39107 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab3CSOPC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Mar 2013 10:15:02 -0400
In-Reply-To: <514821B0.3090706@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

Hi Sage,

could it be that this one needs to be backported to bobtail?

http://tracker.ceph.com/issues/4071

Is this hte error i'm seeing? I can't find that commit in the bobtail
branch.
Am 19.03.2013 09:28, schrieb Stefan Priebe - Profihost AG:
> Hello,
> 
> for testing purposes i've upgrade bobtail 0.56.3 to latest bobtail branch.
> 
> Since then i'm seeing a lot of messages like these:
> 
> 2013-03-19 09:27:06.089820 osd.32 [ERR] 4.ac6 osd.41 inconsistent
> snapcolls on 34762ac6/rbd_data.26c8856b8b4567.0000000000000025/df3//4
> found be1 expected be1,df1
> 
> What do they mean?
> Does ceph fix them automatically?

Stefan
