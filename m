From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: testing the teuthology OpenStack backend
Date: Tue, 11 Aug 2015 09:02:25 +0800
Message-ID: <55C949A1.9080301@ubuntukylin.com>
References: <55C377B3.7050500@dachary.org> <55C6108C.7010803@ubuntukylin.com>
 <55C61F0C.3000903@dachary.org> <55C8A294.9050405@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:38826 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848AbbHKBCk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Aug 2015 21:02:40 -0400
In-Reply-To: <55C8A294.9050405@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,
   Thanks very much, we will give a try asap.

Cheers,
Li Wang

On 2015/8/10 21:09, Loic Dachary wrote:
> Hi,
>
> You should be able to follow the instructions at
>
>     https://github.com/dachary/teuthology/tree/wip-6502-v3-dragonfly#openstack-backend
>
> on your OpenStack cluster. I expect it to be portable accross OpenStack implemenations back to Havana. Please let me know if your OpenStack cluster has a non standard behavior and we will figure out a workaround. By using (note the --upload flag)
>
>     teuthology-openstack --key-filename myself.pem --key-name myself \
>                          --suite dummy --upload --teardown
>
> the results of the teuthology run will be uploaded to
>
>      http://integration.ceph.dachary.org/
>
> Cheers
>
> On 08/08/2015 17:23, Loic Dachary wrote:
>>
>>
>> On 08/08/2015 16:22, Li Wang wrote:
>>> Hi Loic,
>>>    Glad to talk with you on IRC about setting up
>>> the teuthology OpenStack backend. Once it is ready
>>> to run the test in private cloud, and the results
>>> could be exported and uploaded to a public place,
>>> please let me know asap :)
>>
>> I'm working on it, should be ready RSN.
>>
>>>
>>> Cheers,
>>> Li Wang
>>>
>>>
>>> On 2015/8/6 23:05, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> I'm looking into testing the OpenStack backend for teuthology on a new cluster to verify it's portable. I think it is but ... ;-) I'm told you have an OpenStack cluster and would be interested in running teuthology workloads on it. Does it have a public facing API ?
>>>>
>>>> Cheers
>>>>
>>
>
