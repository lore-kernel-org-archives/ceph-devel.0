From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Virtualenv tests still nort running...
Date: Thu, 31 Mar 2016 13:47:14 +0200
Message-ID: <56FD0E42.2020207@digiware.nl>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
 <56FA9B5C.5060307@digiware.nl> <56FB9BA0.2060901@digiware.nl>
 <56FBA5FC.6040001@dachary.org> <56FC397D.8020700@digiware.nl>
 <56FCEE89.4080605@dachary.org> <56FCF63E.2060503@digiware.nl>
 <56FCF891.20706@dachary.org> <56FCFD69.10307@digiware.nl>
 <56FD068A.4010008@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43120 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756505AbcCaLr1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Mar 2016 07:47:27 -0400
In-Reply-To: <56FD068A.4010008@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 31-3-2016 13:14, Loic Dachary wrote:
> [re-adding ceph-devel]
> 
> On 31/03/2016 12:35, Willem Jan Withagen wrote:
>> On 31-3-2016 12:14, Loic Dachary wrote:
>>> : ${CEPH_DISK_VIRTUALENV:=/tmp/ceph-disk-virtualenv}
>>
>> That works when I run it like:
>>  > cd src
>>  > ./ceph-disk/run-tox.sh
>>
>> -----------------------------------------------------
>> TOTAL                    2302   1066    54%
>> ___________________________________ summary
>> ____________________________________
>>   flake8: commands succeeded
>>   py27: commands succeeded
>>   congratulations :)
>>
>> Still leaves remainder in /tmp so that needs to be added.
>> And it will require a large enough temp with plenty freespace
> 
> It's only used for python virtualenv which is small.
> 
>> On a more philosophical note:
>> The next thing to consider is that there is a fair chance that somebody
>> mounted a tmpfs ram-disk on tmp. Which is again a different fs-beast
>> from xfs, with different properties.
> 
> This location is only used to store virutalenv, not to run actual tests.

Oke, good, because otherwise it would give room for strange results i guess.

>> Personally I do not really like the fact that the Ceph tests leave files
>> lingering just about everyware: in .src, in /tmp.
>> testdir is a real nice place to drop test things in.
>>
>> Also the fact that gtest with EXPECT_DEATH do not cleanup the *cores
>> after them is also something that would warrant some cleanup.
> 
> Yes. I expect we'll get something saner when we switch to cmake.

Oke, thanx for the pointer.
And I'll not bother hacking too much on this in the mean time.

--WjW

