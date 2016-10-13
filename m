From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Running multiple Jenkins on one host??
Date: Thu, 13 Oct 2016 12:32:02 +0200
Message-ID: <359a1cc9-93a0-ecf1-19ac-f2ce414f9d55@digiware.nl>
References: <f01169fc-17c9-19dc-58d4-63c58085bb10@digiware.nl>
 <CALqRxCwCFNVhUuf5=9H7RHqYUzPRML+hD9O+P-cuCGPpG4EAhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:52247 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753682AbcJMKcF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 13 Oct 2016 06:32:05 -0400
In-Reply-To: <CALqRxCwCFNVhUuf5=9H7RHqYUzPRML+hD9O+P-cuCGPpG4EAhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 12-10-2016 18:40, Ken Dreyer wrote:
> For jenkins.ceph.com, when we set up each Jenkins slave in OpenStack
> and connect it up to our Jenkins master, we only assign a single
> executor per slave, so we haven't seen issues with /tmp or colliding
> ports.
> 
> If we want to parallelize Jenkins jobs further, we create more VMs
> (https://github.com/ceph/mita/)

Yes, makes sense if you already have a OpenStack running.
Did not want to burden our cluster with this, but perhaps it is the
easier road

--WjW

> On Wed, Oct 12, 2016 at 6:52 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> Are people running multiple builds in Jenkins in parallel on the same
>> host/vm?
>>
>> Or is everybody using one Jenkings thread per VM, and thus avoiding
>> classes in /tmp and in port-usuage?

