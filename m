From: John Spray <john.spray@redhat.com>
Subject: Re: ceph-ci.git?
Date: Mon, 18 May 2015 17:29:19 +0100
Message-ID: <555A135F.301@redhat.com>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net> <55599E24.6040208@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbbERQaX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 May 2015 12:30:23 -0400
In-Reply-To: <55599E24.6040208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org



On 18/05/2015 09:09, Loic Dachary wrote:
> One problem with promoting http://github.com/ceph/ceph to that role is that while the migration is in progress there will be two queues of pull requests, the new one at http://github.com/ceph-ci/ceph and the old one at http://github.com/ceph/ceph. Given our current flow of pull requests the migration will probably take about three months. And after that, since it's not possible to forbid pull requests on github.com (you can disable issues but not pull requests on a given repository) there will forever be a flow of misdirected pull requests against the old repository.
If I understand correctly, this is not an issue as pull requests would 
still be against the original ceph repository.  The ceph-ci repository 
would be where people could push their branches directly to have them 
built, and then they could create a PR to the ceph repository (either 
from their branch on ceph-ci or their original branch in their own 
github repo).

So my workflow as a developer would be to write some code locally, push 
my branch to /jcsp/ceph to "save" it, push it to /ceph/ceph-ci to have 
the gitbuilders pick it up and build it, and then ultimately make a PR 
to /ceph/ceph to merge it.

Apologies in advance for muddying the water if I've got any of that 
wrong :-)

Cheers,
John
