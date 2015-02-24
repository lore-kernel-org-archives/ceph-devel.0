From: John Spray <john.spray@redhat.com>
Subject: Re: Tool for ceph performance analysis
Date: Tue, 24 Feb 2015 12:16:41 +0000
Message-ID: <54EC6BA9.3070405@redhat.com>
References: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com> <54EC6714.3090604@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42095 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752676AbbBXMQq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Feb 2015 07:16:46 -0500
In-Reply-To: <54EC6714.3090604@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>


On 24/02/2015 11:57, John Spray wrote:
>> It would be great, if there will be internal possibility to collect
>> info about whole cluster from one node. May be, something like
>> extension for "tell" command, which can call any node directly and
>> replace external network connections. Or improved version of "ceph osd
>> perf" command, which would allow to get more info.
>>
> This pretty much already exists if someone chooses to deploy 
> diamond+graphite.  Perhaps we need to talk about what's wrong with 
> that solution as it stands?  I'm guessing the main problem is that 
> it's less highly available than ceph mons, and comparatively 
> heavyweight, especially if one is only interested in the latest values.
Ah, I also forgot to mention: it is not very hard to make a cut-down 
version of calamari that doesn't require lots of heavyweight 
dependencies.  I started building this a while back before switching 
tasks, but there's an old branch here: 
https://github.com/ceph/calamari/commits/wip-lite

The key things there are that it doesn't require a postgres database, 
and the remote-execution is abstracted into a "Remote" interface so that 
you can implement alternatives to salt (e.g. SSH, or run locally on 
mon).  It's all free software so borrow what you wish ;-)  The point is 
that it isn't necessary to start from scratch in order to get something 
lightweight.

Cheers,
John
