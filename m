From: WuJaven <javen.wu@icloud.com>
Subject: Question about cephfs MDS journal
Date: Thu, 31 Mar 2016 11:20:06 +0800
Message-ID: <BEBDA66B-72D9-4468-B464-DEB67903EE12@icloud.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p04im-asmtp002.me.com ([17.143.181.11]:55886 "EHLO
	pv33p04im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcCaEUS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 00:20:18 -0400
Received: from [192.168.11.58] (unknown [119.57.173.137])
 by pv33p04im-asmtp002.me.com
 (Oracle Communications Messaging Server 7.0.5.36.0 64bit (built Sep  8 2015))
 with ESMTPSA id <0O4V002EBVXI4O40@pv33p04im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Thu, 31 Mar 2016 03:20:11 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "peng.hse" <peng.hse@xtaotech.com>

Hi Team,

I have a question about MDS journal trim policy.
I found the MDS journal would be flushed when the segment number is ove=
r the predefined value (default 30) only in tick thread context.
If the journal is not over the predefined value, the segments would not=
 be flushed to the OMAP even eventhrough  the system is not busy.=20
My question is what=E2=80=99s the intention for the design?=20
I can understand that journal replay is able to restore metadata into m=
emory, there is no negative impact even though the journal is committed=
 to the backend OMAP.=20
Is there any more concern?
What if we flush the journal segments in the every tick period as along=
 as journal is not empty?


Thanks
Javen--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
