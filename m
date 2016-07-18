From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: AttributeError: 'Rados' object has no attribute 'monitor_log'
Date: Mon, 18 Jul 2016 10:03:44 +0200
Message-ID: <7c58273d-9982-618b-aed5-7282da825ca7@digiware.nl>
References: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
 <CAF-wwdG5-NSDT2YDBWk_cNSU7vzajv9EQ75GZ99qSQJBUbjVkQ@mail.gmail.com>
 <0b1f91d5-81bb-0c5c-961e-a9ad19ba7f6d@digiware.nl>
 <d8c34a15-563b-e438-6b01-bf45a7be0a9a@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:48079 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419AbcGRIER (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jul 2016 04:04:17 -0400
In-Reply-To: <d8c34a15-563b-e438-6b01-bf45a7be0a9a@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 17-7-2016 14:44, Willem Jan Withagen wrote:
> On 14-7-2016 22:50, Willem Jan Withagen wrote:
>> On 7-7-2016 00:46, Brad Hubbard wrote:
>>> On Thu, Jul 7, 2016 at 3:22 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> Hi,
>>>>
>>>> I'm trying to run cephtool-test-mon.sh, and it gets there quite far
>>>> but somewhere down the test I have this error:
>>>> Now python is not my strong point.
>>>
>>> Not mine either but monitor_log should be defined in
>>> src/pybind/rados/rados.pyx and within the
>>> "Rados" object definition.
>>>
>>>  519 cdef class Rados(object):
>>> ...
>>> 1280     def monitor_log(self, level, callback, arg):
>>>
>>> I guess just checking they are there is a start :)
>>>
>>> HTH,
>>> Brad
>>
>> Fixed by recompilation.
>> So could be a faulty leftover from previous build attempts.
> 
> Not quite....
> 
> Turns out that I had ceph-libs in /usr/local/lib from a leftover (wrong)
> setup.
> So that means that the search path of python libraries prefers
> /usr/local/lib over the libs in buidl/lib...
> I guess that that is a serach path setting, but would it be wise move
> ./lib more up front?

Nothing ever seems to be as easy as it looks like to be...

This required a fix in cmake/modules/AddCephTest.cmake
Which contains a hardcode path with lib.linux-x86_64-2.7 in it, which is
the location where cython leaves certain results. Making this behave a
bit nicer seems to work.

--WjW

