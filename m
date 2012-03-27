From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: osd heartbeat interval
Date: Tue, 27 Mar 2012 20:27:44 +0100
Message-ID: <20120327202744.4d062721.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:50245 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab2C0T1q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Mar 2012 15:27:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 6B7ED700044D
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 20:27:45 +0100 (WEST)
Received: from smtp2.ist.utl.pt ([127.0.0.1])
	by localhost (smtp2.ist.utl.pt [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id jhjRm5kOXjlM for <ceph-devel@vger.kernel.org>;
	Tue, 27 Mar 2012 20:27:45 +0100 (WEST)
Received: from mail2.ist.utl.pt (mail.ist.utl.pt [IPv6:2001:690:2100:1::8])
	by smtp2.ist.utl.pt (Postfix) with ESMTP id 32E0E7000449
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 20:27:45 +0100 (WEST)
Received: from coyote.ist.utl.pt (unknown [IPv6:2001:690:2100:2:21d:92ff:fea9:c53d])
	(Authenticated sender: ist146506)
	by mail2.ist.utl.pt (Postfix) with ESMTPSA id 217762007061
	for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 20:27:45 +0100 (WEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


 Hi,

 While testing a cluster with 47 OSDs, we noticed that with that many
OSDs there is considerable network traffic (around 2 Mbit/s), most of
it apparently just from the OSD heartbeats alone (measured while no
clients were generating I/O). Also, OSD CPU consumption was very
measurable, constantly around 1~2% on a 3.2GHz Xeon CPU.

 So we experimented by including

 osd heartbeat interval =3D 10

 on ceph.conf on all nodes and, as suspected, network traffic diminishe=
d
and CPU usage from an idle OSD is not measurable on top anymore.

 Since there is a considerable number of OSDs in this cluster, we think
that even with a 10 sec heartbeat, detection of a down OSD by some
other OSDs is likely to be reasonably quick. As a matter of fact we saw
on the mon log that, when we stopped an OSD, it was flagged as "failed"
by other OSDs in just a few seconds.

 So, we would like to know the opinion of the list about increasing the
heartbeat interval on large clusters (and perhaps suggesting that on
the official documentation), namely if you think there might be some
negative consequences that we haven't foreseen.

 Thanks in advance

Best regards

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
