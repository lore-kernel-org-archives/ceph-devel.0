From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Blueprint: inline data support (step 2)
Date: Wed, 31 Jul 2013 22:34:22 +0800
Message-ID: <51F9206E.9040604@ubuntukylin.com>
References: <51F855D9.6070306@ubuntukylin.com> <51F857B5.5070409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:52249 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097Ab3GaOea (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Jul 2013 10:34:30 -0400
In-Reply-To: <51F857B5.5070409@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Sure, just being busy with some other things, I will post it before the 
summit.

Cheers,
Li Wang

On 07/31/2013 08:17 AM, Loic Dachary wrote:
> Hi,
>
> It would be nice to have URLs to the current implementation and the benchmark results you got in the blueprint.
>
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Inline_data_support_%28Step_2%29
>
> Cheers
>
> On 31/07/2013 02:10, Li Wang wrote:
>> We have worked out a preliminary implementation for inline data support, and observed obvious speed up for small file access.
>>
>> The step 2 will focus on (1) Try to make things simpler to eliminate the state of a file half-inlined; (2) To efficiently deal with the share write or read/write; (3) Protocal backword compatability
>>
>> We submitted a blueprint for this, anyone interested is welcome to join the discussion.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
