From: Owen Synge <osynge@suse.com>
Subject: Understanding encrypted OSD's and cephx
Date: Mon, 14 Nov 2016 16:46:39 +0100
Message-ID: <7a406860-1bc6-7534-9e2c-341bb6ac09eb@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44581 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932447AbcKNPrN (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 14 Nov 2016 10:47:13 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Dear all,

I have been trying to get to grips with understanding cephx and
encrypted OSD's. WRT this bug:

    http://tracker.ceph.com/issues/17833

Please correct me here if I am wrong:

Installing a encrypted OSD with ceph-deploy as:

  ceph-deploy osd create --dmcrypt ceph-node3:vdc

Will fail unless you first run:

  ceph-deploy osd admin ceph-node3

I have been digging further:

(1) Encrypted OSD's are mounted using a key.
(2) This key is retrieved from the mon, using a cephx key.
(3) This cephx key is generated with the capability to retrieve the key
from the mon.

The reason being the admin key is needed is to make keys with correct
capabilities.

To set this up I have played with the command.

With the admin key you can:

    /usr/bin/ceph --connect-timeout 20  config-key list
    /usr/bin/ceph --connect-timeout 20  config-key put  key value
    /usr/bin/ceph --connect-timeout 20  config-key get key value

So we dont want to put the admin keyring on the OSD's with encrypted
OSD's as all encrypted OSD keys can be retrived using the admin keyring.

So I then looked at locking down the capabilities:

I can generate a key with only the ability to get a single key:

   /usr/bin/ceph auth get-or-create \
       client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
       mon 'allow command "config-key get" with key="Key_name"' \
       > /tmp/foo

I can then use this key to get the key's value:

    /usr/bin/ceph --keyring /tmp/foo  --name \
        client.osd-lockbox.d967ec85-4bd5-44c5-b20c-fc6864f6c7c0 \
       config-key get Key_name

I can also create a key that can only place values for a key:

    /usr/bin/ceph auth get-or-create client.bar mon \
        'allow command "config-key put"' > /tmp/bar

And this can upload to that value:

    /usr/bin/ceph auth get-or-create client.nting mon \
        'allow command "config-key put" with \
        key="Key_name"'

And it can only set this value:

    /usr/bin/ceph --connect-timeout 20 --keyring /tmp/bar --name \
        client.bar   config-key put Key_name Key_value

I can also use the mon keyrign ratehr than the admin key to create these
keys:

    /usr/bin/ceph --connect-timeout 20 --keyring \
         /var/lib/ceph/mon/ceph-ceph-node1/keyring \
        --name mon. auth get-or-create client.jam mon \
        'allow command "config-key put" with \
        key="Key_name"'

So it seems to me, that we can potentially resolve bug:

    http://tracker.ceph.com/issues/17833

Without ever putting the admin key or similar high privileged key on an
encrypted OSD node.

Now where does this leave us:

(1) We either continue to expect the admin keyring to exist.
(2) We use locked down keys on the OSD nodes.

Following option (2) We can take 1 of 2 approaches:

(A) ceph-deploy shoudl set up the encryption key and value on the mon
node, generate a value readonly key to the OSD node then deploy the
encrypted OSD.
(B) ceph-deploy should set up a read and write keys for the OSD
encryption value, then ship these to OSD node to deploy the OSD, then
remove the write key.

In both these cases ceph-deploy will need to contact the osd node, get
the partion UUID, process this on the mon node, then finish the process
of deploying an encrypted OSD on the OSD node.

Option (A) seems simpler here.

Does anyone see a better way assuming (2)?

Best regards

Owen
