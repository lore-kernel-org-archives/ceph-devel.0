From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: BUG: problem when removing / creating rbd image (format v2)
Date: Sat, 03 Nov 2012 17:32:19 +0100
Message-ID: <50954713.4060100@profihost.ag>
References: <5094F19E.7010401@profihost.ag> <fdab665c0c79278012d1e8642a584a86@hq.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:60401 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721Ab2KCQcP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 12:32:15 -0400
In-Reply-To: <fdab665c0c79278012d1e8642a584a86@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, alexandre DERUMIER <aderumier@odiso.com>

Am 03.11.2012 17:18, schrieb Josh Durgin:
> On 2012-11-03 03:27, Stefan Priebe wrote:
>> Hello list,
>>
>> [systemI: ~]# rbd -p kvmstor rm vm-113-disk-1
>> 2012-11-03 11:25:43.520833 7fb191d71760 -1 librbd::ImageCtx: error
>> finding header: (2) No such file or directory
>> Removing image: 0% complete...failed.
>> rbd: delete error: (2) No such file or directory
>> 2012-11-03 11:25:43.531708 7fb191d71760 -1 librbd: error removing img
>> from new-style directory: (2) No such file or directory
>>
>> [systemI: ~]# rbd create -p kvmstor --format 2 --size 32000
>> --stripe-count 4 --stripe-unit 1048576 -s 4194304 kvm-113-disk-1
>> rbd: create error: (17) File exists
>> 2012-11-03 11:25:41.017364 7fae8b832760 -1 librbd: rbd image
>> kvm-113-disk-1 already exists
>
>    ^ this k wasn't in your other commands. Is this a copy-paste error
> or a typo?

*ARGH* Sorry it was a typo and i didn't recognized it.

Stefan
