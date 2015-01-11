From: Sage Weil <sage@newdream.net>
Subject: Re: ceph perf command?
Date: Sat, 10 Jan 2015 21:53:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501102151370.18957@cobra.newdream.net>
References: <alpine.DEB.2.00.1501102121410.18957@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40986 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbAKFxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jan 2015 00:53:08 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 290548044F
	for <ceph-devel@vger.kernel.org>; Sat, 10 Jan 2015 21:53:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id ECAED8044F
	for <ceph-devel@vger.kernel.org>; Sat, 10 Jan 2015 21:53:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501102121410.18957@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Sat, 10 Jan 2015, Sage Weil wrote:
> Ceph is collecting all kinds of metrics internally that are exposed 
> through the admin socket or via the 'ceph perf dump' command.  There's no 
> convenient way to watch these values from the command line, though.
> 
> A while back I wrote script/perf-watch.py that tries to provide something 
> that spits out a line every second (ala vmstat, iostat, etc) of whatever 
> metrics you specify.  It's a bit kludgey but look something like this:
> 
> $ script/perf-watch.py -s out/osd.0.asok filestore.bytes osd.wr filestore.commitcycle osd.op osd.op_rw

One note: this currently only works on a vstart cluster (it assumes 
./ceph) and I had to turn off the dev warning:

-DEVMODEMSG = '*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***'
+#DEVMODEMSG = '*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***'
+DEVMODEMSG = ''

(Incidentally, perhaps we should just turn that off anyway?)

sage
