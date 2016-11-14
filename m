From: Sage Weil <sage@newdream.net>
Subject: Re: Understanding encrypted OSD's and cephx
Date: Mon, 14 Nov 2016 16:17:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611141608140.29579@piezo.us.to>
References: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37386 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbcKNQSP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2016 11:18:15 -0500
In-Reply-To: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 14 Nov 2016, Owen Synge wrote:
> Dear all,
> 
> I have been trying to get to grips with understanding cephx and
> encrypted OSD's. WRT this bug:
> 
>     http://tracker.ceph.com/issues/17833
> 
> Please correct me here if I am wrong:
> 
> Installing a encrypted OSD with ceph-deploy as:
> 
>   ceph-deploy osd create --dmcrypt ceph-node3:vdc
> 
> Will fail unless you first run:
> 
>   ceph-deploy osd admin ceph-node3
> 
> I have been digging further:
> 
> (1) Encrypted OSD's are mounted using a key.
> (2) This key is retrieved from the mon, using a cephx key.
> (3) This cephx key is generated with the capability to retrieve the key
> from the mon.
> 
> The reason being the admin key is needed is to make keys with correct
> capabilities.
> 
> To set this up I have played with the command.
> 
> With the admin key you can:
> 
>     /usr/bin/ceph --connect-timeout 20  config-key list
>     /usr/bin/ceph --connect-timeout 20  config-key put  key value
>     /usr/bin/ceph --connect-timeout 20  config-key get key value
> 
> So we dont want to put the admin keyring on the OSD's with encrypted
> OSD's as all encrypted OSD keys can be retrived using the admin keyring.
> 
> So I then looked at locking down the capabilities:
> 
> I can generate a key with only the ability to get a single key:
> 
>    /usr/bin/ceph auth get-or-create \
>        client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
>        mon 'allow command "config-key get" with key="Key_name"' \
>        > /tmp/foo
> 
> I can then use this key to get the key's value:
> 
>     /usr/bin/ceph --keyring /tmp/foo  --name \
>         client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
>        config-key get Key_name
> 
> I can also create a key that can only place values for a key:
> 
>     /usr/bin/ceph auth get-or-create client.bar mon \
>         'allow command "config-key put"' > /tmp/bar
> 
> And this can upload to that value:
> 
>     /usr/bin/ceph auth get-or-create client.nting mon \
>         'allow command "config-key put" with \
>         key="Key_name"'
> 
> And it can only set this value:
> 
>     /usr/bin/ceph --connect-timeout 20 --keyring /tmp/bar --name \
>         client.bar   config-key put Key_name Key_value
> 
> I can also use the mon keyrign ratehr than the admin key to create these
> keys:
> 
>     /usr/bin/ceph --connect-timeout 20 --keyring \
>          /var/lib/ceph/mon/ceph-ceph-node1/keyring \
>         --name mon. auth get-or-create client.jam mon \
>         'allow command "config-key put" with \
>         key="Key_name"'
> 
> So it seems to me, that we can potentially resolve bug:
> 
>     http://tracker.ceph.com/issues/17833
> 
> Without ever putting the admin key or similar high privileged key on an
> encrypted OSD node.
> 
> Now where does this leave us:
> 
> (1) We either continue to expect the admin keyring to exist.
> (2) We use locked down keys on the OSD nodes.
> 
> Following option (2) We can take 1 of 2 approaches:
> 
> (A) ceph-deploy shoudl set up the encryption key and value on the mon
> node, generate a value readonly key to the OSD node then deploy the
> encrypted OSD.
> (B) ceph-deploy should set up a read and write keys for the OSD
> encryption value, then ship these to OSD node to deploy the OSD, then
> remove the write key.
> 
> In both these cases ceph-deploy will need to contact the osd node, get
> the partion UUID, process this on the mon node, then finish the process
> of deploying an encrypted OSD on the OSD node.
> 
> Option (A) seems simpler here.
> 
> Does anyone see a better way assuming (2)?

I think ideally we want this to be permitted as part of the osd-bootstrap 
key.  Then we can hopefully improve things to make provisioning tools 
temporarily issue a bootstrap key, create the osds, then remove the 
bootstrep key.

However, it isn't really possible to sufficiently restrict the commands to 
do the bootstrap with a generic key.  You need to know things like the 
uuid to restrict the key properly.  And it's tedious.  And even the 
current bootstrap process isn't fully secure, see MonCap.cc:

  if (profile == "bootstrap-mds") {
...
    profile_grants.push_back(MonCapGrant("auth get-or-create"));  // FIXME: this can expose other mds keys

I think the fix for this is to give up on trying to write a capability 
that lets you do the necessary steps to set up an OSD or MDS or whatever, 
and instead define a new monitor command to do all of this in one go.  
For example, 'osd bootstrap' could take the necessary arguments (e.g., the 
uuid and local key) and in one step set up the various keys for you.  I 
think that's going to be the most maintainable and sane solution going 
forward.

In the meantime, though... let's just change the ceph deploy test to 
install the admin key so that we can make the tests pass?  And set teh bug 
severity on this so that we make sure it's addressed in a complete way 
soon.

sage

