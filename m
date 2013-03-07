From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: MDS running at 100% CPU, no clients
Date: Wed, 6 Mar 2013 18:18:22 -0800
Message-ID: <BD61F791-E392-4006-B363-BA15458015BB@cs.ucsc.edu>
References: <42F276A0-444F-4300-866D-4CDEE569D398@cs.ucsc.edu>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:42223 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350Ab3CGCST convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 21:18:19 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so50619pab.31
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 18:18:19 -0800 (PST)
In-Reply-To: <42F276A0-444F-4300-866D-4CDEE569D398@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Mar 6, 2013, at 5:57 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:

> The MDS process in my cluster is running at 100% CPU. In fact I thought the cluster came down, but rather an ls was taking a minute. There aren't any clients active. I've left the process running in case there is any probing you'd like to do on it:
> 
> virt   res          cpu
> 4629m  88m 5260 S   92  1.1 113:32.79 ceph-mds
> 
> Thanks,
> Noah
> 


This is a ceph-mds child thread under strace. The only thread
that appears to be doing anything.

root@issdm-44:/home/hadoop/hadoop-common# strace -p 3372
Process 3372 attached - interrupt to quit
read(1649, "7f0203235000-7f0203236000 ---p 0"..., 8191) = 4050
read(1649, "7f0205053000-7f0205054000 ---p 0"..., 8191) = 4050
read(1649, "7f0206e71000-7f0206e72000 ---p 0"..., 8191) = 4050
read(1649, "7f0214144000-7f0214244000 rw-p 0"..., 8191) = 4020
read(1649, "7f0215f62000-7f0216062000 rw-p 0"..., 8191) = 4020
read(1649, "7f0217d80000-7f0217e80000 rw-p 0"..., 8191) = 4020
read(1649, "7f0219b9e000-7f0219c9e000 rw-p 0"..., 8191) = 4020
...

That file looks to be:

ceph-mds 3337 root 1649r   REG    0,3    0   266903 /proc/3337/maps

(3337 is the parent process).