From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Facing some basic stability issues
Date: Thu, 10 Mar 2011 09:16:08 -0800
Message-ID: <41CFF52D45D542C8A45E8590301D5557@gmail.com>
References: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62688 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1CJRQa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 12:16:30 -0500
Received: by qyg14 with SMTP id 14so1645675qyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Mar 2011 09:16:29 -0800 (PST)
In-Reply-To: <1299755096.9697.325.camel@indica.cc.iitb.ac.in>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

Hmmm, your conf file isn't obviously broken but you shouldn't be having any trouble with an untar, either.

When the untar hangs, have you checked to make sure none of the daemons have crashed? Are they all idle, or is one of them using a lot of CPU?
-Greg
On Thursday, March 10, 2011 at 3:04 AM, Ajit K Jena wrote: 
> Hi List,
> 
> We are trying to setup a small 3 node ceph testbed.
> The basic setup is:
> 
>  node1: cmon and mds
> 
>  node2: osd1
> 
>  node3: osd2
> 
>  cl1 and cl2: The clients where ceph filesystem
>  is mounted. We are using it as a
>  standard POSIX filesystem and not
>  using fuse.
> 
>  Operating System: All the participating systems
>  have Fedora core 14 as the operating
>  system.
> 
>  Underlying Filesystem: We have tried both btrfs and
>  and ext4. For each filesystem type we
>  have tried both with and without journal
>  options.
> 
>  Ceph version: 0.25
> 
> The problem we are facing is:
> 
>  The setup goes thru fine. When we copy single files of
>  upto 5-6 GB that also is fine. However we get into trouble
>  if we untar even small files (e.g. 50 MB). The untar
>  process on the client hangs. In fact if any process tries
>  to access the ceph mounted filesystem (e.g. doing 'ls -l'),
>  the process simply hangs and even the shell gets locked
>  up. The only solution seems to be a system reboot.
> 
> The ceph.conf file is attached with the mail.
> 
> Pl help us solve this problem. I have seen
> other postings in this list where people talk
> about performance benchmarking but we are
> stuck up on this very basic issue.
> 
> Thanks in anticipation.
> 
> --ajit
> 
> Attachments: 
> - ceph.conf
> 
> 


