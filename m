From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Block storage performance test tool - would like to merge into
 cbt
Date: Mon, 13 Jul 2015 10:16:23 -0500
Message-ID: <55A3D647.1050703@redhat.com>
References: <CACxKWazeKFOoebysNJ4XajwEmBf2kk6Asw0WVAAKLo=hCp32sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbbGMPQ3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Jul 2015 11:16:29 -0400
In-Reply-To: <CACxKWazeKFOoebysNJ4XajwEmBf2kk6Asw0WVAAKLo=hCp32sA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Konstantin Danilov <kdanilov@mirantis.com>, ceph-devel@vger.kernel.org
Cc: Ben England <bengland@redhat.com>, Ben Turner <bturner@redhat.com>, Kyle Bader <kbader@redhat.com>, tyler Brekke <tbrekke@redhat.com>, cbt <cbt@ceph.com>

Hi Konstantin,

I'm definitely interested in looking at your tools and seeing if we can 
merge them into cbt!  One of the things we lack right now in cbt is any 
kind of real openstack integration.  Right now CBT basically just 
assumes you've already launched VMs and specified them as clients in the 
yaml, so being able to spin up VMs in a standard way would be very 
useful.  It might be worth exploring if we can use your tool to make the 
cluster base class "openstack aware" so that any of the eventual cluster 
classes (ceph, and maybe some day gluster, swift, etc) can use it to 
launch VMs or do other things.  I'd really love to be able to create a 
cbt yaml config file and iterate through parametric configuration 
parameters building multiple different clusters and running tests 
against them with system monitoring and data post processing happening 
automatically.

The data post processing is also something that will be very useful.  We 
have a couple of folks really interested in this area as well.

Mark



On 07/11/2015 03:02 AM, Konstantin Danilov wrote:
> Hi all,
>
> We(Mirantis ceph team) have a tool for block storage performance test,
> called 'wally' -
> https://github.com/Mirantis/disk_perf_test_tool.
>
> It has some nice features, like:
>
> * Openstack and FUEL integration (can spawn VM for tests, gather HW info, etc)
> * Set of tests, joined into suit, which measures different performnce
> aspects and
> creates joined report, as example -
> http://koder-ua.github.io/6.1GA/cinder_volume_iscsi.html,
> VM running on ceph drives report example -
> http://koder-ua.github.io/random/ceph_example.html
> * Data postrocessing - confidence intervals, etc
>
> We would like to merge our code into cbt. Do you interesting in it?
> Can we discuss a way to merge?
>
> Thanks
>
