From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Unsafe TCP connection close handling
Date: Thu, 08 Dec 2011 12:58:34 -0800
Message-ID: <4EE124FA.20902@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45817 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab1LHU6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 15:58:35 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0A35BC063
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 13:08:19 -0800 (PST)
Received: from [192.168.107.213] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 06AD6C062
	for <ceph-devel@vger.kernel.org>; Thu,  8 Dec 2011 13:08:19 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Yesterday during an ffsb run on the ceph kernel client, both
the client and the osd processes hit the max open fds limit
(there was only one osd up at the time). There were 1006 sockets
in the CLOSING state on the client, and 1006 in the FIN_WAIT2
state on the osd.

 From the tcp state machine [1], it seems that the
sequence of events was something like this, with both sides
initially in the ESTABLISHED state:

       Kernel Client            OSD
            |                    |
            |                   /| Send FIN, go to FIN_WAIT1
Send FIN,  |\                 / |
go to      | \               /  |
FIN_WAIT1  |  \             /   |
            |   \           /    |
Recv FIN   |<--------------     |
            |     \              |
Send ACK,  |------\------------>| Recv ACK, go to FIN_WAIT2
go to      |       \            |
CLOSING    |        -----------x| FIN not read

That is, after closing its half of the connection, the osd isn't
reading anything from the socket anymore, and thus ignores the
FIN from the client. We have bug #1803 to track this, but we
should make sure libceph in the kernel handles simultaneous
TCP connection close correctly as well.

[1] http://www.tcpipguide.com/free/diagrams/tcpfsm.png
