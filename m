From: Mykola Golub <to.my.trociny@gmail.com>
Subject: mon: forwarding user commands
Date: Sun, 18 Jan 2015 11:28:16 +0200
Message-ID: <20150118092815.GA2488@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:60754 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbARJ2U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Jan 2015 04:28:20 -0500
Received: by mail-wi0-f170.google.com with SMTP id em10so252023wid.1
        for <ceph-devel@vger.kernel.org>; Sun, 18 Jan 2015 01:28:19 -0800 (PST)
Received: from localhost ([91.225.202.60])
        by mx.google.com with ESMTPSA id 7sm12702884wjq.29.2015.01.18.01.28.17
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jan 2015 01:28:18 -0800 (PST)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Right now, for not a monitor leader, if a received command is not
supported locally, but is supported by the leader, it is forwarded to
the leader.

For the recently added "ceph tell mon.x version" it gives a confusing
behavior: if the mon.x is not a leader and does not support "version"
command yet, but the leader does, the user will receive the version of
the leader, and can't be actually sure about a non leader version.

I have a patch that fixes this by checking if the received "version"
command is forwarded and returning the error in this case:

https://github.com/trociny/ceph/commit/98f835357e378b1c5f05b32ba90a8b8537ba1ad8

But may be we need a more general solution? We might face a similar
issue in future, when adding a new command, which is not expected to
be forwarded to the leader (like injectargs).

-- 
Mykola Golub
