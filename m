From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 0/5] libceph: page mapping in the messenger
Date: Mon, 12 Mar 2012 17:33:42 -0500
Message-ID: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52319 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866Ab2CLWdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:33:39 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 3DB54243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:34:13 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 134E22439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:34:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series fixes up some things in the messenger code related
to how it uses pages.  A new ceph_tcp_sendpage() helper is
created to match the existing ceph_tcp_sendmsg() interface,
and it is used rather than the sendmsg interface when sending
zeroes over the wire for a revoked message.  The helper is
also used for sending message data.  Also, the address mapping
to the zero page gets eliminated, thereby making the zero page
get treated no differently than any other page when it is the
source of a send operation.  Finally there is a little code
cleanup in the message sending code.

					-Alex
