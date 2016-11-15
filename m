From: Owen Synge <osynge@suse.com>
Subject: Re: Understanding encrypted OSD's and cephx
Date: Tue, 15 Nov 2016 10:30:01 +0100
Message-ID: <c343594b-b84a-ea54-c78b-52ef2d35b81d@suse.com>
References: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com>
 <alpine.DEB.2.11.1611141608140.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:51670 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755479AbcKOJaW (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 15 Nov 2016 04:30:22 -0500
In-Reply-To: <alpine.DEB.2.11.1611141608140.29579@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11/14/2016 05:17 PM, Sage Weil wrote:
> On Mon, 14 Nov 2016, Owen Synge wrote:
>> Dear all,
>>
>> I have been trying to get to grips with understanding cephx and
>> encrypted OSD's. WRT this bug:
>>
>>     http://tracker.ceph.com/issues/17833
>>
>> Please correct me here if I am wrong:
>>
>> Installing a encrypted OSD with ceph-deploy as:
>>
>>   ceph-deploy osd create --dmcrypt ceph-node3:vdc
>>
>> Will fail unless you first run:
>>
>>   ceph-deploy osd admin ceph-node3
>>
>> I have been digging further:
>>
>> (1) Encrypted OSD's are mounted using a key.
>> (2) This key is retrieved from the mon, using a cephx key.
>> (3) This cephx key is generated with the capability to retrieve the key
>> from the mon.
>>
>> The reason being the admin key is needed is to make keys with correct
>> capabilities.
>>
>> To set this up I have played with the command.
>>
>> With the admin key you can:
>>
>>     /usr/bin/ceph --connect-timeout 20  config-key list
>>     /usr/bin/ceph --connect-timeout 20  config-key put  key value
>>     /usr/bin/ceph --connect-timeout 20  config-key get key value
>>
>> So we dont want to put the admin keyring on the OSD's with encrypted
>> OSD's as all encrypted OSD keys can be retrieved using the admin keyring.
>>
>> So I then looked at locking down the capabilities:
>>
>> I can generate a key with only the ability to get a single key:
>>
>>    /usr/bin/ceph auth get-or-create \
>>        client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
>>        mon 'allow command "config-key get" with key="Key_name"' \
>>        > /tmp/foo
>>
>> I can then use this key to get the key's value:
>>
>>     /usr/bin/ceph --keyring /tmp/foo  --name \
>>         client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
>>        config-key get Key_name
>>
>> I can also create a key that can only place values for a key:
>>
>>     /usr/bin/ceph auth get-or-create client.bar mon \
>>         'allow command "config-key put"' > /tmp/bar
>>
>> And this can upload to that value:
>>
>>     /usr/bin/ceph auth get-or-create client.nting mon \
>>         'allow command "config-key put" with \
>>         key="Key_name"'
>>
>> And it can only set this value:
>>
>>     /usr/bin/ceph --connect-timeout 20 --keyring /tmp/bar --name \
>>         client.bar   config-key put Key_name Key_value
>>
>> I can also use the mon keyrign ratehr than the admin key to create these
>> keys:
>>
>>     /usr/bin/ceph --connect-timeout 20 --keyring \
>>          /var/lib/ceph/mon/ceph-ceph-node1/keyring \
>>         --name mon. auth get-or-create client.jam mon \
>>         'allow command "config-key put" with \
>>         key="Key_name"'
>>
>> So it seems to me, that we can potentially resolve bug:
>>
>>     http://tracker.ceph.com/issues/17833
>>
>> Without ever putting the admin key or similar high privileged key on an
>> encrypted OSD node.
>>
>> Now where does this leave us:
>>
>> (1) We either continue to expect the admin keyring to exist.
>> (2) We use locked down keys on the OSD nodes.
>>
>> Following option (2) We can take 1 of 2 approaches:
>>
>> (A) ceph-deploy shoudl set up the encryption key and value on the mon
>> node, generate a value readonly key to the OSD node then deploy the
>> encrypted OSD.
>> (B) ceph-deploy should set up a read and write keys for the OSD
>> encryption value, then ship these to OSD node to deploy the OSD, then
>> remove the write key.
>>
>> In both these cases ceph-deploy will need to contact the osd node, get
>> the partion UUID, process this on the mon node, then finish the process
>> of deploying an encrypted OSD on the OSD node.
>>
>> Option (A) seems simpler here.
>>
>> Does anyone see a better way assuming (2)?
> 
> I think ideally we want this to be permitted as part of the osd-bootstrap 
> key.  Then we can hopefully improve things to make provisioning tools 
> temporarily issue a bootstrap key, create the osds, then remove the 
> bootstrep key.

That sounds reasonable.

> However, it isn't really possible to sufficiently restrict the commands to 
> do the bootstrap with a generic key. 

I would agree.

I have always considered security a compromise between usability and
security as if some thing is secure and unusable, then we have no point
in making some thing secure as it will never be used. The approaches I
outlined with (A) and (B) are significantly more secure, but they are
impacting usability considerably, and possibly unusable.

> You need to know things like the
> uuid to restrict the key properly.  And it's tedious.  And even the 
> current bootstrap process isn't fully secure, see MonCap.cc:
> 
>   if (profile == "bootstrap-mds") {
> ...
>     profile_grants.push_back(MonCapGrant("auth get-or-create"));  // FIXME: this can expose other mds keys

I agree that this approach is not fully secure for exactly the above reason.

> I think the fix for this is to give up on trying to write a capability 
> that lets you do the necessary steps to set up an OSD or MDS or whatever, 

I agree, I had a look at this briefly and decided I needed to bring the
mailing list on board before I even considered trying.

> and instead define a new monitor command to do all of this in one go.  
> For example, 'osd bootstrap' could take the necessary arguments (e.g., the 
> uuid and local key) and in one step set up the various keys for you.  I 
> think that's going to be the most maintainable and sane solution going 
> forward.

Having a single command to do this sounds a good long term solution.

I would add that a replay attack is still a danger, with a one command
approach.

Using the trigger of OSD registering to prevent replay attacks, seems
like a better compromise than making each command only work once, so
setup can be repeated until success, and then since replay is prevented
other keys cannot be exposed.

> In the meantime, though... let's just change the ceph deploy test to 
> install the admin key so that we can make the tests pass?  And set teh bug 
> severity on this so that we make sure it's addressed in a complete way 
> soon.

I fully agree.

Please can you (Sage) raise the bug so this plan is executed with
appropriate timeliness, as I feel if you raise the bug it will enhance
the importance. I would suggest you also include the replay attack issue
in the bug report.

I will need help to understand how to change the functional test suite.
The change will be just to issue:

    ceph-deploy admin $TARGET_NODE

before issuing:

    ceph-deploy osd create --dmcrypt $TARGET_NODE:sdb:sdc

Best wishes

Owen
