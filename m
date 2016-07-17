From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: AttributeError: 'Rados' object has no attribute 'monitor_log'
Date: Sun, 17 Jul 2016 14:44:21 +0200
Message-ID: <d8c34a15-563b-e438-6b01-bf45a7be0a9a@digiware.nl>
References: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
 <CAF-wwdG5-NSDT2YDBWk_cNSU7vzajv9EQ75GZ99qSQJBUbjVkQ@mail.gmail.com>
 <0b1f91d5-81bb-0c5c-961e-a9ad19ba7f6d@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:22162 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbcGQMop (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Jul 2016 08:44:45 -0400
In-Reply-To: <0b1f91d5-81bb-0c5c-961e-a9ad19ba7f6d@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 14-7-2016 22:50, Willem Jan Withagen wrote:
> On 7-7-2016 00:46, Brad Hubbard wrote:
>> On Thu, Jul 7, 2016 at 3:22 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> Hi,
>>>
>>> I'm trying to run cephtool-test-mon.sh, and it gets there quite far
>>> but somewhere down the test I have this error:
>>> Now python is not my strong point.
>>
>> Not mine either but monitor_log should be defined in
>> src/pybind/rados/rados.pyx and within the
>> "Rados" object definition.
>>
>>  519 cdef class Rados(object):
>> ...
>> 1280     def monitor_log(self, level, callback, arg):
>>
>> I guess just checking they are there is a start :)
>>
>> HTH,
>> Brad
> 
> Fixed by recompilation.
> So could be a faulty leftover from previous build attempts.

Not quite....

Turns out that I had ceph-libs in /usr/local/lib from a leftover (wrong)
setup.
So that means that the search path of python libraries prefers
/usr/local/lib over the libs in buidl/lib...
I guess that that is a serach path setting, but would it be wise move
./lib more up front?

--WjW


