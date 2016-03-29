From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Virtualenv tests still nort running...
Date: Tue, 29 Mar 2016 17:12:28 +0200
Message-ID: <56FA9B5C.5060307@digiware.nl>
References: <56FA67A8.6050809@digiware.nl> <56FA74F4.5040905@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:48272 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917AbcC2PMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 29 Mar 2016 11:12:50 -0400
In-Reply-To: <56FA74F4.5040905@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 29-3-2016 14:28, Loic Dachary wrote:
> Hi Willem,
> 
> This has undergone various fixes all of them wrong in a context or
> another. The last of them is (hopefully ;-)
> https://github.com/ceph/ceph/pull/8320

Hi Loic,

I watched the discussion carefully, and was under the assemption that
everything was already merged. But I'll take your pull and see what happens.

--WjW

> Cheers
> 
> On 29/03/2016 13:31, Willem Jan Withagen wrote:
>> 
>> Hi,
>> 
>> I have rebased to the most recent HEAD before building verything
>> again. But the testrun still is unable to get the virtualenv
>> correct.
>> 
>> Suggestions on how to diagnose this?
>> 
>> =========== cp -f ./fetch_config ./sample.fetch_config cd
>> ./ceph-detect-init ; ../tools/setup-virtualenv.sh ; test -d
>> wheelhouse && export NO_INDEX=--no-index ; virtualenv/bin/pip
>> install $NO_INDEX --use-wheel --find-links=file://$(pwd)/wheelhouse
>> -e . /bin/sh: ../tools/setup-virtualenv.sh: not found /bin/sh:
>> virtualenv/bin/pip: not found Makefile:32259: recipe for target
>> 'ceph-detect-init/virtualenv' failed ===========
>> 
>> path for setup-virtual ./src/tools/setup-virtualenv.sh
>> 
>> =========== cat ./src/tools/setup-virtualenv.sh rm -fr virtualenv 
>> virtualenv virtualenv . virtualenv/bin/activate # older versions of
>> pip will not install wrap_console scripts # when using wheel
>> packages pip --log virtualenv/log.txt install --upgrade 'pip >=
>> 6.1' if test -d wheelhouse ; then export NO_INDEX=--no-index fi pip
>> --log virtualenv/log.txt install $NO_INDEX --use-wheel
>> --find-links=file://$(pwd)/wheelhouse --upgrade di stribute pip
>> --log virtualenv/log.txt install $NO_INDEX --use-wheel
>> --find-links=file://$(pwd)/wheelhouse 'tox >=1.9' if test -f
>> requirements.txt ; then pip --log virtualenv/log.txt install
>> $NO_INDEX --use-wheel --find-links=file://$(pwd)/wheelhouse -r
>> requi rements.txt fi =========== Perhaps here the virtualenv paths
>> need to be converted into SHELLVARs as well?
>> 
>> --WjW -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to majordomo@vger.kernel.org 
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
> 

