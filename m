From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Log_query
Date: Tue, 12 Jul 2016 11:49:32 +1000
Message-ID: <20160712014932.GB27622@rskikr.localdomain>
References: <loom.20160711T165846-774@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33257 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcGLBtk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jul 2016 21:49:40 -0400
Received: by mail-pf0-f181.google.com with SMTP id i123so913671pfg.0
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jul 2016 18:49:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20160711T165846-774@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Srikar <srikar.kumar@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 11, 2016 at 03:03:15PM +0000, Srikar wrote:
> Hi All,
>      I am trying to look for logs while deleting or creating an osd. I have
> configured "log to stderr = true" in ceph.conf file, but still logs are not
> available. Do I need to run cluster in development mode? Is there any
> additional things I am missing ?

From a quick look at the code this option only seems to be relevant in the
event of a crash (if I read it right).

Information on logging and debugging can be found here.

http://docs.ceph.com/docs/master/rados/troubleshooting/log-and-debug/

Also keep in mind that you can adjust logging levels on the fly with commands
like the following.

# ceph tell osd.* injectargs '--debug_osd 20 --debug_ms 20'

Most of the daemons support the -d option to run in the foreground and log to
stderr.

# ceph-osd -i 0 -c ceph.conf -d

HTH,
Brad

> Thanks & Regards,
> Srikar.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers,
Brad
