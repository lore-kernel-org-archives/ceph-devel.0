From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: AttributeError: 'Rados' object has no attribute 'monitor_log'
Date: Thu, 14 Jul 2016 22:50:43 +0200
Message-ID: <0b1f91d5-81bb-0c5c-961e-a9ad19ba7f6d@digiware.nl>
References: <30f6bbac-0b8b-b241-b58d-e3960051ad7c@digiware.nl>
 <CAF-wwdG5-NSDT2YDBWk_cNSU7vzajv9EQ75GZ99qSQJBUbjVkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:32250 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355AbcGNUvH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jul 2016 16:51:07 -0400
In-Reply-To: <CAF-wwdG5-NSDT2YDBWk_cNSU7vzajv9EQ75GZ99qSQJBUbjVkQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 7-7-2016 00:46, Brad Hubbard wrote:
> On Thu, Jul 7, 2016 at 3:22 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I'm trying to run cephtool-test-mon.sh, and it gets there quite far
>> but somewhere down the test I have this error:
>> Now python is not my strong point.
> 
> Not mine either but monitor_log should be defined in
> src/pybind/rados/rados.pyx and within the
> "Rados" object definition.
> 
>  519 cdef class Rados(object):
> ...
> 1280     def monitor_log(self, level, callback, arg):
> 
> I guess just checking they are there is a start :)
> 
> HTH,
> Brad

Fixed by recompilation.
So could be a faulty leftover from previous build attempts.

--WjW


