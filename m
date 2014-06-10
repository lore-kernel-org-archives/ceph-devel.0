From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [ceph-users] Fwd: CEPH Multitenancy and Data Isolation
Date: Tue, 10 Jun 2014 16:30:39 -0700
Message-ID: <5397951F.1000009@inktank.com>
References: <CFBB8E65.E806%vilobhmm@yahoo-inc.com> <AE4D7541-2202-4A06-BBC6-DADEC88AE89D@yahoo-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:52441 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbaFJXa7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jun 2014 19:30:59 -0400
Received: by mail-qc0-f179.google.com with SMTP id r5so3395031qcx.10
        for <ceph-devel@vger.kernel.org>; Tue, 10 Jun 2014 16:30:59 -0700 (PDT)
In-Reply-To: <AE4D7541-2202-4A06-BBC6-DADEC88AE89D@yahoo-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vilobh Meshram <vilobhmm@yahoo-inc.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>

On 06/10/2014 01:56 AM, Vilobh Meshram wrote:
>> How does CEPH guarantee data isolation for volumes which are not mea=
nt
>> to be shared in a Openstack tenant?
>>
>> When used with OpenStack the data isolation is provided by the
>> Openstack level so that all users who are part of same tenant will b=
e
>> able to access/share the volumes created by users in that tenant.
>> Consider a case where we have one pool named =93Volumes=94 for all t=
he
>> tenants. All the tenants use the same keyring to access the volumes =
in
>> the pool.
>>
>>  1. How do we guarantee that one user can=92t see the contents of th=
e
>>     volumes created by another user; if the volume is not meant to b=
e
>>     shared.

OpenStack users or tenants have no access to the keyring. Cinder tracks
volume ownership and checks permissions when a volume is attached, and
qemu prevents users from seeing anything outside of their vm, including=
=20
the keyring.

>>  2. If someone malicious user gets the access to the keyring (which =
we
>>     used as a authentication mechanism between the client/Openstack
>>     and CEPH) how does CEPH guarantee that the malicious user can=92=
t
>>     access the volumes in that pool.

The keyring gives a user access to the cluster. If someone has a valid=20
keyring, Ceph treats them as a valid user, since there is no informatio=
n
to say otherwise. Ceph can't tell whether the user of a keyring is
malicious.

>>  3. Lets say our Cinder services are running on the Openstack API
>>     node. How does the CEPH keyring information gets transferred fro=
m
>>     the API node to the Hypervisor node ? Does this keyring passed
>>     through message queue? If yes can the malicious user have a look
>>     at the message queue and grab this keyring information ? If not
>>     then how does it reach from the API node to the Hypervisor node.

The keyring is static and configured by the administrator on the nodes
running cinder-volume and nova-compute. It's not sent over the network,
and is not needed by nova or cinder api nodes.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
