From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Running src/ceph generates python error
Date: Fri, 19 Feb 2016 08:22:49 +0100
Message-ID: <56C6C2C9.1040502@digiware.nl>
References: <56C6403C.7060400@digiware.nl> <56C66791.8040005@digiware.nl>
 <56C69819.5000809@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:38977 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbcBSHWz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 19 Feb 2016 02:22:55 -0500
In-Reply-To: <56C69819.5000809@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On 19-2-2016 05:20, Loic Dachary wrote:
> Hi,
>
> I suspect this is something you changed in your branch. Is there a way to compare your branch with the current master ?

I try to stay away from changing python too much, since I'm not really 
into python.
But then that could be the reason I made a mess of it.

I have a ceph/master here as well.
I'll pull/rebase both, and then run diff over the *py files.

It seems to come from calling src/ceph, since I've isolated the eronous 
call to:
./ceph osd create --fsid=d9e9b487-d5e0-11e5-be15-1c6f6582ec12 
--auth-supported=none --mon-host=127.0.0.1:7101 
--osd-backfill-full-ratio=.99 --osd-failsafe-full-ratio=.99 
--osd-journal-size=100 --osd-scrub-load-threshold=2000 
--osd-data=testdir/test-erasure-code/0 --chdir= --erasure-code-dir=.libs 
--plugin-dir=.libs --osd-class-dir=.libs --run 
-dir=testdir/test-erasure-code --debug-osd=20 
--log-file=testdir/test-erasure-code/$name.log 
--pid-file=testdir/test-erasure-code/$name.pid

So it has got to be in that code (or imports) somewhere.

--WjW

> Cheers
>
> On 19/02/2016 07:53, Willem Jan Withagen wrote:
>> On 18-2-2016 23:05, Willem Jan Withagen wrote:
>>> I'm trying to run
>>
>> I was not quite complex in my message:
>> Running:  test/erasure-code/test-erasure-code.sh
>>
>> And I can get it actually working when I comment out the line:
>> ../qa/workunits/ceph-helpers.sh: line 547
>>      # ceph_args+=" --plugin-dir=.libs"
>>
>> But the error seems to be because of an error in the python script
>> called then refuses the about --plugin-dir option
>>
>> --WjW
>>
>>> And it terminates with:
>>> ======
>>> .......
>>> .......
>>> ../qa/workunits/ceph-helpers.sh:555: activate_osd:  mkdir -p
>>> testdir/test-erasure-code/0
>>> ../qa/workunits/ceph-helpers.sh:556: activate_osd:
>>> CEPH_ARGS='--fsid=d9e9b487-d5e0-11e5-be15-1c6f6582ec12
>>> --auth-supported=none -
>>> -mon-host=127.0.0.1:7101  --osd-backfill-full-ratio=.99
>>> --osd-failsafe-full-ratio=.99 --osd-journal-size=100 --osd-scrub-load-thre
>>> shold=2000 --osd-data=testdir/test-erasure-code/0 --chdir=
>>> --erasure-code-dir=.libs --plugin-dir=.libs --osd-class-dir=.libs --run
>>> -dir=testdir/test-erasure-code --debug-osd=20
>>> --log-file=testdir/test-erasure-code/$name.log
>>> --pid-file=testdir/test-erasure-code/
>>> $name.pid  '
>>> ../qa/workunits/ceph-helpers.sh:556: activate_osd:  ceph-disk
>>> --statedir=testdir/test-erasure-code --sysconfdir=testdir/test-erasu
>>> re-code --prepend-to-path= activate --mark-init=none
>>> testdir/test-erasure-code/0
>>> ceph-disk: Error: ceph osd create failed: Command './ceph' returned
>>> non-zero exit status 22: --plugin-dir=.libs not valid:  --plug
>>> in-dir=.libs doesn't represent an int
>>> Invalid command:  unused arguments: [u'--plugin-dir=.libs']
>>> osd create {<uuid>} {<int[0-]>} :  create new osd (with optional UUID
>>> and ID)
>>> Error EINVAL: invalid command
>>>
>>> ======
>>>
>>> So it seems it does not like all the values that are put in the
>>> ENV{CEPH_ARGS}.
>>>
>>> Is this just my problem?
>>> And if so, what am I doing wrong?
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
