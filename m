From: huang jun <hjwsm1989@gmail.com>
Subject: how to improve read through on sparse files (vm image file)
Date: Fri, 27 Jun 2014 00:27:06 +0800
Message-ID: <CABAwU-buZtx=ViUTCs4n2sgvdCLPA41VweB9waa4eHPPZE7BSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:39744 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbaFZQ1H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jun 2014 12:27:07 -0400
Received: by mail-yk0-f176.google.com with SMTP id 131so2129299ykp.7
        for <ceph-devel@vger.kernel.org>; Thu, 26 Jun 2014 09:27:06 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
We migrate vmware EXSI vm from ceph cluster via NFS to local disk,the
image file size is about 250GB. we have 8 OSDs on 2 hosts.
But the migrate speed is pretty slow, we test it in 3 way:
1) NFS + kclient + ceph
during the first 5 minutes, read speed is about 40MB/s,
but after that, down to 20MB/s, the whole migrate cost 3 hours.
Check the osd log, we find there are many read request at 4KB size,
and OSD return -2, which means those requests are for the hole in the
vm image file.
we also find that NFS send random read request to OSDs while checking
the client log,

2) NFS + ceph-fuse + ceph
avg read speed is about 40MB/s, the whole migrate cost 2 hours.
After check the osd log, the read request size is 128KB.

2.1) set  the client readahead size like below:
[client]
client_readahead_min = 4194304
client_readahead_max = 41943040

but is doesn't make big difference, the migration cost 1 hour 58 minutes.

2.2) we change the client code to always read ahead objects when we do
every read request.
unfortunately, the migration time does reduce much.

3) NFS + rbd + ceph
the read speed can reach 117MB/s (reading holes in sparse file)
and decrease to 40MB/s when reading the data parts of the vm image file.

i have questions:
1) is there any way to improve the through when reading sparse files?
2) can i change the read size of nfs(may be asked on nfs mailing list)?

3) any other params to set on ceph fuse client to improve read speed?

-- 
thanks
huangjun
