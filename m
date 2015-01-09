From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Some gitbuilders not working
Date: Fri, 09 Jan 2015 06:40:57 -0700
Message-ID: <54AFDA69.2080002@redhat.com>
References: <54AF7B4C.6010305@inktank.com> <54AFAE7D.5070402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724AbbAINmE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 9 Jan 2015 08:42:04 -0500
In-Reply-To: <54AFAE7D.5070402@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, David Zafman <david.zafman@inktank.com>, ceph-devel@vger.kernel.org

On 01/09/2015 03:33 AM, Loic Dachary wrote:
> On 09/01/2015 07:55, David Zafman wrote:
>>
>> We are seeing gitbuilder failures.  This is what I saw on one.
>>
>> error: Failed build dependencies:
>> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
> 
> This is because https://github.com/ceph/ceph/pull/3036 was recently merged.
> However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlstarlet
> about a month ago. Maybe some gitbuilder machines were not updated
> accordingly. If I'm not mistaken this is a manual process but I'm not sure
> exactly how to do it myself.

I'm not entirely sure of the SOP to apply fabfile changes across our
infrastructure, either. Is there a simple "push this fabfile change
everywhere" command for gitbuilder?

In the long term we'll want to get to a point where we're building
Ceph's RPM packages using mock [1] instead of rpmbuild so that mock can
resolve these sort of things automatically without having to deal with
installing new BuildRequires by hand.

- Ken

[1] http://fedoraproject.org/wiki/Projects/Mock

