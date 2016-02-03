From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Infernalis on NVMe cephx authentication impact
Date: Tue, 2 Feb 2016 17:53:41 -0800
Message-ID: <56B15DA5.3010505@redhat.com>
References: <034AAD465C6CBE4F96D9FB98573A79A6024B1591@FMSMSX108.amr.corp.intel.com>
 <56B14F6B.7050405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39097 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932130AbcBCBxm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Feb 2016 20:53:42 -0500
In-Reply-To: <56B14F6B.7050405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, "Moreno, Orlando" <orlando.moreno@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>

On 02/02/2016 04:52 PM, Mark Nelson wrote:
> Hi Orlando,
>
> Hrm, looks like https://github.com/ceph/ceph/pull/3896 didn't make it
> into Hammer at release. :(  That might also account for a large part of
> the performance disparity.  Coincidentally Josh Durgin made a branch
> with the PR backported to hammer a couple of weeks ago here:
>
> https://github.com/ceph/ceph/commits/wip-auth-hammer

Turns out it fixes a bug [0] in addition to being faster, so expect it
in a future hammer release.

Has anyone measured the overhead of message signing (the 'cephx sign 
messages' option)? It's on by default with cephx, but can be disabled
separately. What auth settings were these tests using?

It may be worth requiring message signatures by default now that it's
been supported in the kernel client since 3.19.

Josh

[0] http://tracker.ceph.com/issues/14620
