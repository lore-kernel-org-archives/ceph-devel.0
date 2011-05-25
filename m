From: Fyodor Ustinov <ufm@ufm.su>
Subject: CRUSH again
Date: Wed, 25 May 2011 15:17:57 +0300
Message-ID: <4DDCF375.7010109@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:37223 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756612Ab1EYMSA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 May 2011 08:18:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 7172E600484
	for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 15:17:58 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eLEXWVJQPqKb for <ceph-devel@vger.kernel.org>;
	Wed, 25 May 2011 15:17:58 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id 551DE600447
	for <ceph-devel@vger.kernel.org>; Wed, 25 May 2011 15:17:58 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

Again few questions.

1. What is the difference between "uniform | list | tree | straw" bucket 
type?

2. Replication chunk can not be placed on different devices on the same 
host and on different hosts on the same rack? Or only rack? Or only host?

3. What isthe difference between host and rack except nesting levels?

WBR,
     Fyodor.
