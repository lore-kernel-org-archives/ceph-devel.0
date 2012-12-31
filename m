From: Miles Fidelman <mfidelman@meetinghouse.net>
Subject: Re: ceph for small cluster?
Date: Mon, 31 Dec 2012 09:14:29 -0500
Message-ID: <50E19DC5.303@meetinghouse.net>
References: <50E0B457.70200@meetinghouse.net> <CADXA5U1ATB+1baCfBSHmzozRe3m-HhLxHQr3be1-dASgABPQYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from server1.neighborhoods.net ([207.154.13.48]:40564 "EHLO
	server1.neighborhoods.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2LaOOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 09:14:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by server1.neighborhoods.net (Postfix) with ESMTP id BB958CC0C3
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 09:14:30 -0500 (EST)
Received: from server1.neighborhoods.net ([127.0.0.1])
	by localhost (server1.neighborhoods.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gQyZa+WnlGct for <ceph-devel@vger.kernel.org>;
	Mon, 31 Dec 2012 09:14:29 -0500 (EST)
Received: from new-host-2.home (pool-71-184-234-147.bstnma.fios.verizon.net [71.184.234.147])
	by server1.neighborhoods.net (Postfix) with ESMTPSA id 9C462CC03C
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 09:14:29 -0500 (EST)
In-Reply-To: <CADXA5U1ATB+1baCfBSHmzozRe3m-HhLxHQr3be1-dASgABPQYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Matt, Thanks for the comments.  A follow-up if I might (inline):

Matthew Roy wrote:
> What I'm not doing that you'd need to test is running VMs on the same 
> servers as storage. I'd be careful about mounting RBD volumes on the 
> OSDs, you can run into kernel deadlock trying to write out things to 
> physical disk when trying to write to the mounted volume. Mounts 
> inside VMs should be okay. 

I was thinking of running pinning one CPU to DomO and running the OSD 
from there, and mounting RBD volumes only in DomUs.  And leaving a bit 
of disk space outside the OSD for booting and Dom0.

Which raises another question: how are you combining drives within each 
OSD (raid, lvm, ?).

Thanks again,

Miles


-- 
In theory, there is no difference between theory and practice.
In practice, there is.   .... Yogi Berra

