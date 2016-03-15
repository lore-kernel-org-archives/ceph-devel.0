From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Publishing development releases
Date: Tue, 15 Mar 2016 21:31:48 +0100
Message-ID: <56E87134.6060206@suse.cz>
References: <56E7D22E.2060701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38679 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932347AbcCOUbw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Mar 2016 16:31:52 -0400
In-Reply-To: <56E7D22E.2060701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Martin Palma <martin@palma.bz>, "Chen, Xiaoxi" <xiaoxchen@ebay.com>, Vicente Cheng <freeze.bilsted@gmail.com>, Gaurav Bafna <bafnag@gmail.com>, Rajat Garg <rajatgarg.iitr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic:

I, too, think this is a good idea and am willing to accept the extra 
workload.

Nathan

On 03/15/2016 10:13 AM, Loic Dachary wrote:
> Hi Abhishek V, Abhishek L, Swami, Nathan, Gaurav, Rajat, Martin, Xiaoxi, Vicente,
>
> A few weeks ago, 10.0.3 was tagged for release, but packages were not published and these packages were missed by the Ceph user base. We, the members of the Stable Releases team, got to thinking how we could help.
>
> This led to an idea that was discussed on the mailing list[1] and during CDM[2]. Since we were already building packages as a side effect of running teuthology suites on OpenStack, this could be extended into a full-fledged release process that would:
>
> 1. ensure that the community's demand for development releases is met
> 2. complement, not replace, the existing package publication workflow
> 3. be automated.
>
> So I added a "release" subcommand to the ceph-workbench[3] tool we are already using to automate various backporting tasks. The new subcommand is included in the latest ceph-workbench release, and works like this:
>
>               ceph-workbench release --suite buildpackages/any \
>                           --ceph jewel \
>                           --version 10.0.5 \
>                           --filter ubuntu_14.04,centos_7.2
>
> When it completes the packages can be uploaded to a permanent mirror similar to downloads.ceph.com.
>
> I believe we can commit to publish Ceph development releases with this process. The "release" subcommand is relatively small (around 300 lines of code) and there are integration tests to help with its maintenance. There are enough of us to rotate the release duties so that it does not become too much of a burden for anyone.
>
> Since it's a decision that changes our focus and our workload, are you OK with adding this activity to the scope of our team?
>
> Cheers
>
> [1] (Un)Stable release team http://www.spinics.net/lists/ceph-devel/msg28887.html
> [2] publishing development and unsupported releases http://tracker.ceph.com/projects/ceph/wiki/CDM_02-MAR-2016
> [3] ceph-workbench release merge request http://ceph-workbench.dachary.org/root/ceph-workbench/merge_requests/43/diffs#9f3ebf1fc38506b66593397f3baac514d515c496_231_232
>


-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
