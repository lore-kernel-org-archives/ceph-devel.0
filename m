From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Enabling contributors to run teuthology suites
Date: Mon, 24 Aug 2015 07:00:39 -0500
Message-ID: <55DB0767.9070609@redhat.com>
References: <55DB0553.90406@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58077 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbbHXMAv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 24 Aug 2015 08:00:51 -0400
In-Reply-To: <55DB0553.90406@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is a really neat idea Loic!  Do you think at some point it will 
make sense to just setup the sepia lab as cloud infrastructure that lets 
folks run teuthology on it in the same fashion?

Mark

On 08/24/2015 06:51 AM, Loic Dachary wrote:
> Hi Sam,
>
> Maybe we can start an experiment to enable contributors to run their own teuthology suites. It would go like this:
>
> * Send an OpenStack credential file to the author of a pull request
> * Ask her/him to follow the instructions at https://github.com/dachary/teuthology/tree/openstack#openstack-backend to verify it works
> * Ask her/him to run and debug a specific suite by providing the command line such as
>
>     teuthology-openstack --key-name myself --key-filename ~/Downloads/myself --suite ceph-disk --suite-branch wip-11881-multipath --filter=ubuntu_14.04 --ceph wip-11881-multipath
>
> We don't yet have a long term solution to fund this kind of testing, but that's not a blocker. It's cheap enough to setup and I'm willing to spend 500 euros per month of my own money for the time being. It's really selfish of me : enabling contributors will save me time that's worth more than 500 euros ;-)
>
> The details of how the first account has been setup are at http://tracker.ceph.com/projects/ceph/wiki/RunTeuthology
>
> What do you think ?
>
> Cheers
>
