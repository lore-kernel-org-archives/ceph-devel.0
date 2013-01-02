From: Dennis Jacobfeuerborn <dennisml@conversis.de>
Subject: Re: status monitoring options for ceph cluster
Date: Wed, 02 Jan 2013 17:34:36 +0100
Message-ID: <50E4619C.6070300@conversis.de>
References: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com> <50E44D79.6070809@widodh.nl> <50E45909.4080907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail4.conversis.de ([213.203.219.181]:45921 "EHLO
	mail4.conversis.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939Ab3ABQei (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:34:38 -0500
In-Reply-To: <50E45909.4080907@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Wido den Hollander <wido@widodh.nl>, Ugis <ugis22@gmail.com>, ceph-devel@vger.kernel.org

On 01/02/2013 04:58 PM, Joao Eduardo Luis wrote:
> On 01/02/2013 03:08 PM, Wido den Hollander wrote:
>> On 01/02/2013 04:05 PM, Ugis wrote:
>>> Hi all,
>>>
>>> I am planning to set up monitoring of ceph cluster relying on output
>>> of commands:
>>>
>>> #ceph health
>>> #ceph -s
>>>
>>> The need is to retrieve certain values, for example %degraded;
>>> proportion "X GB / Y GB avail" to calculate available space%. I plan
>>> to graph those values via zabbix and set up triggers for certain
>>> tresholds.
>>> May be somebody already has written shell parser for getting values
>>> from output of these commands?
>>>
>>> Probably this ir wider question - what is the intended approach for
>>> ceph cluster monitoring? What do you guys use?
>>
>> You might want to take a look at: http://tracker.newdream.net/issues/685
>>
>> In version 0.35 a json output was added. I've never tried it before, but
>> you might want to look at that.
> 
> Currently, the only command that will output useful json for this kind of
> thing is 'ceph report'. I am finishing up on a patch to add json output
> capabilities to 'ceph health' and 'ceph status' though, but wasn't aiming
> at doing it with such level of detail -- basically, just output the same
> info as their plain counterparts, but using json instead.

I'm interested in this topic as well. What is also needed is a way to query
the state of the individual daemons on each machine in the cluster.

Regards,
  Dennis

