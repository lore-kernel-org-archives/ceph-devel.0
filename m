From: Fyodor Ustinov <ufm@ufm.su>
Subject: ceph and network
Date: Tue, 24 May 2011 13:05:51 +0300
Message-ID: <4DDB82FF.4070100@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:55090 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab1EXKFx (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 May 2011 06:05:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.ufm.su (Postfix) with ESMTP id 02DD660048A
	for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 13:05:52 +0300 (EEST)
Received: from mail.ufm.su ([127.0.0.1])
	by localhost (mail.ufm.su [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ncKjzSmLCV6u for <ceph-devel@vger.kernel.org>;
	Tue, 24 May 2011 13:05:51 +0300 (EEST)
Received: from [192.168.2.22] (unknown [94.232.181.14])
	by mail.ufm.su (Postfix) with ESMTPSA id D62A6600484
	for <ceph-devel@vger.kernel.org>; Tue, 24 May 2011 13:05:51 +0300 (EEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I need to implement this scheme of servers connections:

All servers of ceph cluster have 2 network addresses in different nets.
One net - for ceph interconnect. I.e. for traffic between ceph servers 
(Suppose called "internal").
One - for traffic between clients and cluster ("external").

As I understand it - the client receives the address of the ceph servers 
frommon. And mon server needs to know about that it is necessary give 
out "external" address, not "internal".

How can I do?

WBR,
    Fyodor.

