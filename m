From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Little update on the build platform
Date: Thu, 2 Jun 2016 10:11:21 +0200
Message-ID: <574FEA29.7040508@suse.cz>
References: <902296593.97770947.1464716952266.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53284 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751474AbcFBILX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 2 Jun 2016 04:11:23 -0400
In-Reply-To: <902296593.97770947.1464716952266.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>, ceph-devel@vger.kernel.org

> - An diagnosis helper is now in place to spot known build failures  :
> A list of common issues have been entered (like gcc or jenkins failures, segfaults, etc...)
> A typical output looks like : https://jenkins.ceph.com/job/ceph-pull-requests/6448/

Thanks, guys, this looks like an excellent improvement.

Now I have a PR with failing make check and it appears that Jenkins is 
aware of the failures:

https://jenkins.ceph.com/job/ceph-pull-requests/6550/consoleFull#17782142537ba86caa-bd6c-4071-8005-3f6d80f92e07

The two recognized failures are highlighted in red:

FATAL: java.io.IOException: Unexpected termination of the channel

java.lang.NullPointerException: no workspace from node 
hudson.slaves.DumbSlave[158.69.84.81+trusty_huge__c69f129f-3dff-46c2-9bd4-d14364fcb62f] 
which is computer hudson.slaves.SlaveComputer@1957dd58 and has channel null

But I don't know what to do about them? Do we have documentation of the 
common failure cases and what can be done to fix them?

Nathan
