From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: ceph-workbench 1.5.15 released
Date: Fri, 10 Feb 2017 08:52:41 +0100
Message-ID: <5e3251af-bb98-c940-b0fe-cbc4742b1597@corp.ovh.com>
References: <01fcc394-8f9b-17eb-a169-0102ec0a3e17@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 4.mo301.mail-out.ovh.net ([137.74.110.67]:60441 "EHLO
        4.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbdBJHwt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 02:52:49 -0500
In-Reply-To: <01fcc394-8f9b-17eb-a169-0102ec0a3e17@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 02/10/2017 12:00 AM, Loic Dachary wrote:
> Hi Piotr,
>
> Now that teuthology-openstack is fixed and uses the latest teuthology master branch [1], I took this opportunity to publish a new version of ceph-workbench[2]. It should work out of the box with an OVH tenant. You can run a teuthology suite with something like:
>
>    ceph-workbench ceph-qa-suite --verbose --suite rados --ceph kraken
>
> and collect the results from the teuthology cluster it creates, like with the basic example that ran today at http://158.69.82.163:8081/
>
> Cheers
>
> [1] https://github.com/ceph/teuthology/pull/1028
> [2] http://ceph-workbench.readthedocs.io/en/latest/

Awesome, thanks! I'm going to check it out soon.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
