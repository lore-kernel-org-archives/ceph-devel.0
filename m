From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: how to debug slow rbd block device
Date: Tue, 22 May 2012 22:13:38 +0200
Message-ID: <4FBBF372.5090300@profihost.ag>
References: <4FBB8A5B.9010500@profihost.ag> <B141A2FBE87F4859AF931D71A339468E@inktank.com> <4FBBEBC8.1000205@profihost.ag> <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:59225 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab2EVUNl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 16:13:41 -0400
In-Reply-To: <1C70F3FB753C4AEC97247E04FAE3C733@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

Am 22.05.2012 21:52, schrieb Greg Farnum:
> On Tuesday, May 22, 2012 at 12:40 PM, Stefan Priebe wrote:
> Huh. That's less than I would expect. Especially since it ought to be going through the page cache.
> What version of RBD is KVM using here?
v0.47.1

> Can you (from the KVM host) run
> "rados -p data bench seq 60 -t 1"
> "rados -p data bench seq 60 -t 16"
> and paste the final output from both?
I think your meant:
  rados -p data bench 60 seq -t 1 ?

but even that results in:
~# rados -p data bench 60 seq -t 1
Must write data before running a read benchmark!
error during benchmark: -2
error 2: (2) No such file or directory

Stefan
