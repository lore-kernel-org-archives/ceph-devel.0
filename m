From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: Test infrastructure: 2 or more servers?
Date: Tue, 15 Jan 2013 23:26:42 +0100
Message-ID: <CAJH6TXjAv4mVBkcYbWg0u_CPmfkf8UEwXKTkrvST32B6u+Jg2A@mail.gmail.com>
References: <CAJH6TXhBucB2t-ZRmXf5bCZyNaTRJoSHZhoJ9hsW8mR7NxhWnA@mail.gmail.com>
	<50F5D24B.70308@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:48217 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab3AOW0p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 17:26:45 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm2so652878wib.4
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 14:26:43 -0800 (PST)
In-Reply-To: <50F5D24B.70308@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: ceph-devel@vger.kernel.org

2013/1/15 Xing Lin <xinglin@cs.utah.edu>:
> You can change the number replicas in runtime with the following command:
>
> $ ceph osd pool set {poolname} size {num-replicas}

So it's absolutely safe to start with just 2 server, make all the
necessary tests and when ready to go in production, increase the
servers and replicas?
