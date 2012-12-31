From: Miles Fidelman <mfidelman@meetinghouse.net>
Subject: Re: ceph for small cluster?
Date: Mon, 31 Dec 2012 09:21:50 -0500
Message-ID: <50E19F7E.2000805@meetinghouse.net>
References: <50E19E34.7080005@meetinghouse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from server1.neighborhoods.net ([207.154.13.48]:36562 "EHLO
	server1.neighborhoods.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2LaOVw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 09:21:52 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by server1.neighborhoods.net (Postfix) with ESMTP id E59FECC0EA
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 09:21:51 -0500 (EST)
Received: from server1.neighborhoods.net ([127.0.0.1])
	by localhost (server1.neighborhoods.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id R87lt98kpZu5 for <ceph-devel@vger.kernel.org>;
	Mon, 31 Dec 2012 09:21:50 -0500 (EST)
Received: from new-host-2.home (pool-71-184-234-147.bstnma.fios.verizon.net [71.184.234.147])
	by server1.neighborhoods.net (Postfix) with ESMTPSA id 8BB54CC0DE
	for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 09:21:50 -0500 (EST)
In-Reply-To: <50E19E34.7080005@meetinghouse.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


Wido, Thanks for the comment, a follow-up if I might (below)?

Wido den Hollander wrote:
>
> I build some small Ceph cluster with sometimes just 3 nodes. It works,
> but you have to keep in mind that when one node in a 4 node cluster
> fails you will loose 25% of the capacity.
>
> This will lead to a heavy recovery within the Ceph cluster which will
> but a lot of pressure on that Gbit links and the CPUs and memory of
> the nodes.
>
> With RBD you might want to consider adding an SSD for the journaling
> of the OSDs, that will give you a pretty nice performance boost.
>
Would not journalling alone, say on a separate hard disk volume, help
with recovery?

Thanks,

Miles

-- 
In theory, there is no difference between theory and practice.
In practice, there is.   .... Yogi Berra

