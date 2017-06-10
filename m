From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Errors in Ceph block \free\bsd jenkins
Date: Sat, 10 Jun 2017 11:52:04 +0200
Message-ID: <52d5b791-eb27-110e-3dc4-d0bf682eb471@digiware.nl>
References: <838cd04c-d291-42dd-56a1-995f8bd42855@digiware.nl>
 <alpine.DEB.2.11.1706091822130.3646@piezo.novalocal>
 <0eb49180-26bd-c780-272d-99369ef27a39@digiware.nl>
 <b632e53a-a73d-dd55-ccc0-c51a72b05c76@digiware.nl>
 <alpine.DEB.2.11.1706092144540.3646@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:17306 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbdFJJwJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 10 Jun 2017 05:52:09 -0400
In-Reply-To: <alpine.DEB.2.11.1706092144540.3646@piezo.novalocal>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



Op 9-6-2017 om 23:46 schreef Sage Weil:
> On Fri, 9 Jun 2017, Willem Jan Withagen wrote:
>> On 9-6-2017 20:30, Willem Jan Withagen wrote:
>>> On 9-6-2017 20:23, Sage Weil wrote:
>>>> Try with this:
>>>>
>>>> 	https://github.com/ceph/ceph/pull/15588
>>>>
>>>> mgr is probably dying trying to start up dashboard.
>>> A new Jenkins run was already running, lets see if it catches up on my
>>> editting. Otherwise we'll known at the next run.
>> This PR did not help.
>> Looks more or less like the command is not recognized.
>> Am I missing the patch that implements the 'tell x ...' stuff
> Oh.. you're probably missing python-pecan or one of its
> dependnecies, preventing the restful module from loading.  Either add
> that to your environment, or we can add a vstart flag to skip that part.
> (Look at the mgr.x.log after vstart to see why the restful module is
> failing to load.. you should see a python backtrace error splat in
> there somewhere.)

For now I commented this out, and tests work again.
How problematic is this going to be in the near future?
Any more code going to depend on this?

I'll see if there is an easy way to get pecan installed, since it is not 
in the packages.

--WjW

> sage
>
>> --WjW
>>
>>> Thanx
>>> --WjW
>>>
>>>> sage
>>>>
>>>> On Fri, 9 Jun 2017, Willem Jan Withagen wrote:
>>>>
>>>>> Hi
>>>>>
>>>>> All my jenkins builds on FreeBSD get terminated in errors in
>>>>> build/bin/ceph, due to faulty command.
>>>>> Am I the only one being hampered by this?
>>>>>
>>>>> --Wjw
>>>>>
>>>>> Starting mgr.x
>>>>> /home/jenkins/workspace/ceph-master/build/bin/ceph-mgr -i x -c
>>>>> /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
>>>>> /home/jenkins/workspace/ceph-master/build/bin/ceph -c
>>>>> /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/ceph.conf
>>>>> -k /home/jenkins/workspace/ceph-master/build/src/test/td/t-7205/keyring
>>>>> tell mgr.x restful create-key admin -o /tmp/tmp.ZrcYS640
>>>>> no valid command found; 10 closest matches:
>>>>> osd reweight-by-utilization {<int>} {<float>} {<int>} {--no-increasing}
>>>>> osd pool stats {<name>}
>>>>> pg repair <pgid>
>>>>> pg deep-scrub <pgid>
>>>>> osd blocked-by
>>>>> osd perf
>>>>> pg dump_stuck {inactive|unclean|stale|undersized|degraded
>>>>> [inactive|unclean|stale|undersized|degraded...]} {<int>}
>>>>> pg ls {<int>}
>>>>> {active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered
>>>>> [active|clean|down|scrubbing|degraded|inconsistent|peering|repair|recovering|backfill_wait|incomplete|stale|remapped|deep_scrub|backfill|backfill_toofull|recovery_wait|undersized|activating|peered...]}
>>>>> pg scrub <pgid>
>>>>> pg debug unfound_objects_exist|degraded_pgs_exist
>>>>> Error EINVAL: invalid command
>>>>>
>>>>>
>>>>> 25% tests passed, 3 tests failed out of 4
>>>>>
>>>>> Total Test time (real) = 503.43 sec
>>>>>
>>>>> The following tests FAILED:
>>>>> 	  4 - cephtool-test-mon.sh (Failed)
>>>>> 	  5 - cephtool-test-osd.sh (Failed)
>>>>> 	  6 - cephtool-test-rados.sh (Failed)
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

