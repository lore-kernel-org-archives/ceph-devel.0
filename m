From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: status monitoring options for ceph cluster
Date: Wed, 02 Jan 2013 15:58:01 +0000
Message-ID: <50E45909.4080907@inktank.com>
References: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com> <50E44D79.6070809@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:35118 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab3ABP63 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 10:58:29 -0500
Received: by mail-bk0-f51.google.com with SMTP id ik5so6214707bkc.10
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 07:58:28 -0800 (PST)
In-Reply-To: <50E44D79.6070809@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Ugis <ugis22@gmail.com>, ceph-devel@vger.kernel.org

On 01/02/2013 03:08 PM, Wido den Hollander wrote:
> On 01/02/2013 04:05 PM, Ugis wrote:
>> Hi all,
>>
>> I am planning to set up monitoring of ceph cluster relying on output
>> of commands:
>>
>> #ceph health
>> #ceph -s
>>
>> The need is to retrieve certain values, for example %degraded;
>> proportion "X GB / Y GB avail" to calculate available space%. I plan
>> to graph those values via zabbix and set up triggers for certain
>> tresholds.
>> May be somebody already has written shell parser for getting values
>> from output of these commands?
>>
>> Probably this ir wider question - what is the intended approach for
>> ceph cluster monitoring? What do you guys use?
>
> You might want to take a look at: http://tracker.newdream.net/issues/685
>
> In version 0.35 a json output was added. I've never tried it before, but
> you might want to look at that.

Currently, the only command that will output useful json for this kind 
of thing is 'ceph report'. I am finishing up on a patch to add json 
output capabilities to 'ceph health' and 'ceph status' though, but 
wasn't aiming at doing it with such level of detail -- basically, just 
output the same info as their plain counterparts, but using json instead.

   -Joao
