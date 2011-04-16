From: Fyodor Ustinov <ufm@ufm.su>
Subject: raid40?
Date: Sat, 16 Apr 2011 04:10:52 +0300
Message-ID: <4DA8EC9C.8070605@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:38247 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289Ab1DPBKz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2011 21:10:55 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id DDC0C600307
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2011 04:10:52 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T7evr+y61WGs for <ceph-devel@vger.kernel.org>;
	Sat, 16 Apr 2011 04:10:52 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id BD7CA6002EA
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2011 04:10:52 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

Looking the sources I noticed that the "rule" in CRUSH may be type "raid4".

Because of this, I have a question: Is it possible to organize the 20 
OSD servers in the scheme 4 * (4+1)? I.e. like a stripe from 4 of raid4 
sets?

Plain "replication level = 2" is too expensive by "used space".

WBR,
     Fyodor.
