From: David Galloway <dgallowa@redhat.com>
Subject: Re: clock skew on Jenkins builders causing Shaman builds to fail
Date: Thu, 22 Jun 2017 11:19:36 -0400
Message-ID: <6df10653-bdc6-e520-d62a-dfce70766337@redhat.com>
References: <68d4c9c4-a9c0-b6a2-c948-0e31ff07b006@suse.cz>
 <1c385dcf-0aa5-5c90-3365-5ea1a7b7209f@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45334 "EHLO mx1.redhat.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1752643AbdFVPUG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 11:20:06 -0400
In-Reply-To: <1c385dcf-0aa5-5c90-3365-5ea1a7b7209f@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've installed and enabled NTP on all the slave-* slaves.

I'll also add a few tasks to enable NTP in the playbooks we use to first
provision these slaves.

On 06/22/2017 03:20 AM, Nathan Cutler wrote:
> This shows the failure nicely: https://shaman.ceph.com/builds/ceph/jewel/
> 
> On 06/22/2017 08:56 AM, Nathan Cutler wrote:
>> Today I noticed that "jewel" failed to build for CentOS with the
>> following error:
>>
>> configure: error: newly created file is older than distributed files!
>> Check your system clock
>>
>> Here is the URL:
>> https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/8518//consoleFull
>>
>>
>> Others on IRC mentioned that this is a known problem from at least
>> yesterday. Could somebody please take care of it. It is blocking jewel
>> integration testing.
>>
>> Thanks!
>>
>> Nathan
