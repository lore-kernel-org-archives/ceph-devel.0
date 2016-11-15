From: Owen Synge <osynge@suse.com>
Subject: Re: Understanding encrypted OSD's and cephx
Date: Tue, 15 Nov 2016 16:44:41 +0100
Message-ID: <0e346b36-2e8c-d934-1165-ce6b831c1f73@suse.com>
References: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com>
 <alpine.DEB.2.11.1611141608140.29579@piezo.us.to>
 <c343594b-b84a-ea54-c78b-52ef2d35b81d@suse.com>
 <alpine.DEB.2.11.1611151420160.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:38531 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941042AbcKOPo4 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 15 Nov 2016 10:44:56 -0500
In-Reply-To: <alpine.DEB.2.11.1611151420160.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11/15/2016 03:27 PM, Sage Weil wrote:
> On Tue, 15 Nov 2016, Owen Synge wrote:
>>> and instead define a new monitor command to do all of this in one go.  
>>> For example, 'osd bootstrap' could take the necessary arguments (e.g., the 
>>> uuid and local key) and in one step set up the various keys for you.  I 
>>> think that's going to be the most maintainable and sane solution going 
>>> forward.
>>
>> Having a single command to do this sounds a good long term solution.
>>
>> I would add that a replay attack is still a danger, with a one command
>> approach.
>>
>> Using the trigger of OSD registering to prevent replay attacks, seems
>> like a better compromise than making each command only work once, so
>> setup can be repeated until success, and then since replay is prevented
>> other keys cannot be exposed.
> 
> There are two options:
> 
>  (1) Make the command always instantiate a new osd id and set of keys, 
> such that you get leaked/garbage state if there is a command resend, 
> or

Understood.

>  (2) make the command properly idempotent.  The trick here is that we need 
> to uniquely identify the bootstrap command by some piece of state that is 
> private so that the command cannot be used to fetch secrets for the 
> created osd.  This shouldn't really be a problem.

Not sure I follow this point. Can you explain.

My difficulty is idempotent commands are suitable for replay attacks,
and cant understand how we get around this with a "private" data hook, I
am probably just being dumb here, please enlighten me if you have time.

Personally I like the idea of using the partition uuid to identify
things as is done currently.

> In the end, this will be significantly more secure than what we were doing 
> before.  The recommended workflow will become
> 
>  (1) push bootstrap-{osd,mon,mds} key to host
>  (2) create daemon (via new bootstrap command that is tailor-made for the 
> purpose)
>  (3) remove bootstrap key

Agreed, for my close the replay window when OSD is registered approach,
or your point (1) and probably when I understand it (2).

> Before we commit to this, there is an alternative model that does all key 
> creation on some other trusted host, but it would mean a more significant 
> rewrite of the ceph-disk tooling...

Yes,

Forgive me for going in circles here, I think if we substitute "mon
node" with "trusted host" this is what I proposed first in this thread
but I dont like it for the below reasons.

The negative of the "trusted host" approach is:

* We would still need to get the partition UUID and present it to the
"trusted host". Then take the output from the "trusted host" back to the
OSD with the encrypted disks. This makes for inter node communication
which makes for usability issues.

* Also new ceph-disk tooling as you pointed out. (ceph-deploy also)

The positive of the "trusted host" approach:

* It is the most secure approach.

* Requires no new tooling in the mon.

* No worries about replay attacks.

>>> In the meantime, though... let's just change the ceph deploy test to 
>>> install the admin key so that we can make the tests pass?  And set teh bug 
>>> severity on this so that we make sure it's addressed in a complete way 
>>> soon.
>>
>> I fully agree.
>>
>> Please can you (Sage) raise the bug so this plan is executed with
>> appropriate timeliness, as I feel if you raise the bug it will enhance
>> the importance. I would suggest you also include the replay attack issue
>> in the bug report.
>>
>> I will need help to understand how to change the functional test suite.
>> The change will be just to issue:
>>
>>     ceph-deploy admin $TARGET_NODE
>>
>> before issuing:
>>
>>     ceph-deploy osd create --dmcrypt $TARGET_NODE:sdb:sdc
> 
> Yep, that's it.  Should just be a few lines of code in 
> 
> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/ceph_deploy.py

I think this might do it,

    https://github.com/ceph/ceph-qa-suite/pull/1259

Sadly I haven’t had the opportunity to test this locally.

Best wishes

Owen

