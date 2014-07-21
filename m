From: Zhongliang Zhao <zhaozhongliang@gmail.com>
Subject: radosgw-admin: symbol lookup error
Date: Mon, 21 Jul 2014 15:52:58 +0200
Message-ID: <53CD1B3A.7060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:42126 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbaGUNxS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jul 2014 09:53:18 -0400
Received: by mail-we0-f180.google.com with SMTP id w61so7621985wes.39
        for <ceph-devel@vger.kernel.org>; Mon, 21 Jul 2014 06:53:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: yehuda@inktank.com

Dear all,

I am trying to test the feature of geo-replication, which is suported 
via radosgw service.
After following 
http://ceph.com/docs/master/radosgw/config/#adjust-path-ownership-permissions,
$sudo /etc/init.d/radosgw start (start the gateway)
returns
$Starting client.radosgw.instance-1...
$/usr/bin/radosgw is running

However, when I want to use the radosgw-admin command, it gives error like:

radosgw-admin: symbol lookup error: radosgw-admin: undefined symbol: 
_ZTVN4ceph6crypto8HMACSHA1E

Can anyone indicate what's happen and how to process?

Thanks in advance.
Giovanni
