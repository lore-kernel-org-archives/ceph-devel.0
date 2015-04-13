From: Paolo Viotti <paolo.viotti@eurecom.fr>
Subject: Report about Paxos in Ceph Monitor.
Date: Mon, 13 Apr 2015 13:42:39 +0200
Message-ID: <552BABAF.1050200@eurecom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp3.eurecom.fr ([193.55.113.213]:19374 "EHLO smtp2.eurecom.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750894AbbDMLml (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 07:42:41 -0400
Received: from [192.168.21.29] (unknown [192.168.21.29])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id A5F82EDD
	for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2015 13:42:40 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

as part of my research on coordination techniques for distributed 
systems and real-life case studies thereof, I drafted a brief report 
about the Paxos implementation in Ceph Monitor.
In case it is of any interest, you can find it here: http://bit.ly/1O6os90

Regards,
Paolo
