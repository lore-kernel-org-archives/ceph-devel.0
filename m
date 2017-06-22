From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: clock skew on Jenkins builders causing Shaman builds to fail
Date: Thu, 22 Jun 2017 22:33:43 +0200
Message-ID: <8841fb5d-40ed-1c77-e336-276e441fb389@suse.cz>
References: <68d4c9c4-a9c0-b6a2-c948-0e31ff07b006@suse.cz>
 <1c385dcf-0aa5-5c90-3365-5ea1a7b7209f@suse.cz>
 <6df10653-bdc6-e520-d62a-dfce70766337@redhat.com>
 <b2a2a9ee-a712-e3ff-71da-a3ed8cba220f@suse.cz>
 <13f4032f-be00-1bc1-7900-3e87e03d013c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753362AbdFVUdp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 16:33:45 -0400
In-Reply-To: <13f4032f-be00-1bc1-7900-3e87e03d013c@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Galloway <dgallowa@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> I can restart.  Looks like maybe you only need centos7, is that right?

Yeah, but I just merged something so it's rebuilding everything all over 
again. Thanks!

> 
> On 06/22/2017 03:03 PM, Nathan Cutler wrote:
>> Thanks, David. Could you trigger a rebuild of jewel, or do I need to
>> wait until something gets merged?
>>
>> On 06/22/2017 05:19 PM, David Galloway wrote:
>>> I've installed and enabled NTP on all the slave-* slaves.
>>>
>>> I'll also add a few tasks to enable NTP in the playbooks we use to first
>>> provision these slaves.
>>>
>>> On 06/22/2017 03:20 AM, Nathan Cutler wrote:
>>>> This shows the failure nicely:
>>>> https://shaman.ceph.com/builds/ceph/jewel/
>>>>
>>>> On 06/22/2017 08:56 AM, Nathan Cutler wrote:
>>>>> Today I noticed that "jewel" failed to build for CentOS with the
>>>>> following error:
>>>>>
>>>>> configure: error: newly created file is older than distributed files!
>>>>> Check your system clock
>>>>>
>>>>> Here is the URL:
>>>>> https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/8518//consoleFull
>>>>>
>>>>>
>>>>>
>>>>> Others on IRC mentioned that this is a known problem from at least
>>>>> yesterday. Could somebody please take care of it. It is blocking jewel
>>>>> integration testing.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Nathan
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
