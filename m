From: WuJaven <javen.wu@icloud.com>
Subject: Re: Question about cephfs MDS journal
Date: Thu, 31 Mar 2016 20:47:34 +0800
Message-ID: <8999D958-3B33-4A86-B5FA-11BA9F1D03CC@icloud.com>
References: <BEBDA66B-72D9-4468-B464-DEB67903EE12@icloud.com>
 <CALe9h7fOqmBSD9yrrzn2n0Zaq0cWdrSm84avW24CkQh_7xWcPA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p04im-asmtp002.me.com ([17.143.181.11]:38197 "EHLO
	pv33p04im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496AbcCaMrm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 08:47:42 -0400
Received: from [192.168.11.58] (unknown [119.57.173.137])
 by pv33p04im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O4W00NZUM7CCU00@pv33p04im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Thu, 31 Mar 2016 12:47:42 +0000 (GMT)
In-reply-to: <CALe9h7fOqmBSD9yrrzn2n0Zaq0cWdrSm84avW24CkQh_7xWcPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "peng.hse" <peng.hse@xtaotech.com>

Thanks John for the answer. 

Javen
 
> 
> However, I have also thought that it would be useful to flush the
> journal on idle systems.  Especially, since our new fsck/recovery
> functionality benefits from having a fully written-back metadata
> store, it would be nice to do this opportunistically if we could
> invent a suitable heuristic for detecting idleness.
> 
> John
> 
>> 
>> Thanks
>> Javen--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

