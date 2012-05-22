From: Greg Farnum <greg@inktank.com>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 12:52:09 -0700
Message-ID: <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
References: <4FBB8A5B.9010500@profihost.ag>
 <B141A2FBE87F4859AF931D71A339468E@inktank.com>
 <4FBBEBC8.1000205@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61285 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760207Ab2EVTwQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 15:52:16 -0400
Received: by dady13 with SMTP id y13so8690306dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 12:52:15 -0700 (PDT)
In-Reply-To: <4FBBEBC8.1000205@profihost.ag>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: ceph-devel@vger.kernel.org

On Tuesday, May 22, 2012 at 12:40 PM, Stefan Priebe wrote:
> Am 22.05.2012 21:35, schrieb Greg Farnum:
> > What does your test look like? With multiple large IOs in flight we can regularly fill up a 1GbE link on our test clusters. With smaller or fewer IOs in flight performance degrades accordingly.
> 
> 
> 
> iperf shows 950Mbit/s so this is OK (from KVM host to OSDs)
> 
> sorry:
> dd if=/dev/zero of=test bs=4M count=1000; dd if=test of=/dev/null bs=4M 
> count=1000;
> 1000+0 records in
> 1000+0 records out
> 4194304000 bytes (4,2 GB) copied, 99,7352 s, 42,1 MB/s
> 
> 1000+0 records in
> 1000+0 records out
> 4194304000 bytes (4,2 GB) copied, 47,4493 s, 88,4 MB/s

Huh. That's less than I would expect. Especially since it ought to be going through the page cache.
What version of RBD is KVM using here?

Can you (from the KVM host) run
"rados -p data bench seq 60 -t 1"
"rados -p data bench seq 60 -t 16"
and paste the final output from both?

