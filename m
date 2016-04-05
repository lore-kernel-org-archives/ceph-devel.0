From: Owen Synge <osynge@suse.com>
Subject: Re: mon daemon makes authentication side effects on startup
Date: Wed, 6 Apr 2016 01:18:07 +0200
Message-ID: <570447AF.4060307@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CALe9h7fR3o2ixciazKO8B09aLjxCGCLwdfs9MMWi1u2EwY8Jzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:44638 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267AbcDEXSR (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 5 Apr 2016 19:18:17 -0400
In-Reply-To: <CALe9h7fR3o2ixciazKO8B09aLjxCGCLwdfs9MMWi1u2EwY8Jzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Dear John,

Thanks for the reply, I hope my answer does not sound to abrupt.

On 04/05/2016 08:35 PM, John Spray wrote:
> On Tue, Apr 5, 2016 at 12:56 PM, Owen Synge <osynge@suse.com> wrote:
>> Dear all,
>>
>> This is in my opinion is clearly a bug, but I raise it in the mailin=
g
>> list as I expect all admins of ceph will strongly agree, that this m=
akes
>> ceph simpler, but developers may feel that since it requires changes=
 to
>> more than one repo its not worth doing.
>>
>> When ever you start the mon demon as a side effect the admin, osd, r=
gw
>> and mds keys are created as a side effect if the mds keyring is not
>> existing.
>>
>> In the systemV and systemd init scripts (at least) we have a side
>> effect, that should be removed in my opinion, (or worse in my
>> alternatively correctly documented.)
>>
>> This is a deployment layer violation, in my opinion, and it requires
>> considerably more documentation, (and on my part also code) to keep =
this
>> side effect than remove it.
>>
>> usecases for removing this are:
>>
>> (0) A ceph cluster should be able to be installed in any order. With=
 the
>> current behavior if the mds, rgw, or osd nodes are deployed first (a=
long
>> with the boot strap keyrings), the mon created must have all keys fo=
r
>> the admin, mds-bootstrap, rgw-bootstrap, and osd-boostrap deployed i=
n
>> the correct path before the mon can safely be started, even if the
>> cluster does not need the mds or rgw service's.
>>
>> (1) It is unfriendly to configuration being stored on the configurat=
ion
>> server as the server needs to be updated with the values from the
>> configured node keys, when people might want to store these keys cen=
trally.
>=20
> Is there anything stopping you from pre-generating all your keys
> (including bootstrap etc) using ceph-authtool, and then including
> those keys in the keyring file that you pass into mons when you creat=
e
> them?  That way, you could create your keys and store them in your
> config management tool, all before starting any mons.

Currently you can not use pre-generated keys and configure nodes in any
order (point 0) using secrets from the configuration server (point 1)
for brevity I skip other use cases. We can remove this restraint very
simply, if we prevent ceph-create-keys being run on mon nodes at the
booting stage of mon's by our choice of methods, which I propose is bes=
t
done by removing ceph-create-keys from the init scripts.

To answer your question, yes, you can have a fully functioning cluster
with pre-generated keys, without using ceph-create-keys at any stage.
pre-generating all your keys and making a running cluster is possible
and not very hard.

What is needed is to create a "booting the mon keyring", by importing
the mon and the admin keys. Then use this when creating the mon.

=46or reference the two steps to set up the mon nodes are:

(1) creating the boot key:

ceph-authtool \
  --create-keyring ${path_booting_keyring} \
  --import-keyring ${path_mon_keyring}

ceph-authtool \
  ${path_booting_keyring} \
  --import-keyring ${path_admin_keyring}

(it seems you can also just concatenate both keyrings, but I expect
using ceph-authtool is safer in the long term)

(2) creating the mon:

ceph-mon \
 --mkfs \
 -i ${hostname} \
 --monmap ${path_monmap}
 --keyring ${booting_key_path}

=46or reference I also include the step of generating the admin and mon
keyrings which can be done before configuring any service:

(0) Creating admin and mon keys:

ceph-authtool \
-n client.admin \
--create-keyring ${path_admin_keyring} \
--gen-key \
--cap mds 'allow *' \
--cap mon 'allow *' \
--cap osd 'allow *'

ceph-authtool \
-n mon. \
--create-keyring ${path_mon_keyring} \
--gen-key \
--set-uid=3D0 \
--cap mon 'allow *'

>> (2) Assuming the admin, rgw-bootstrap, mds-bootstrap and osd-boostra=
p
>> keys are always installed on all mon nodes is clearly increasing the
>> distribution of keys where they might not be needed. Hence reducing
>> security.
>=20
> I think this is a bit of a subjective balance between security and
> convenience.=20

I do not agree the current behavior is convenient for the admin who run=
s
a ceph cluster.

=46or the admin points (0), (1), (2), (3), (4), (4.1), (5), (6), (7) ar=
e
currently an issue, and lead to ceph being both mysterious and magical,
with all the fear that gives an admin.

Only if you are a developer of ceph, is the current behavior more
convenient, but the convenience only extends to avoiding running one
command in setting up your test environment namely running:

 ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}

Having this as a separate step to booting a mon adds clarity to the
"magic", and is a simple one liner command line operation, which can be
skipped when not wanted, rather than running under some conditions
whenever you boot a mon as is the current behavior.

> Currently we don't have to explain to folks how to get
> their admin key into /etc/ceph, because it just pops out when the mon
> starts.

Yes, I object to the side effect "magic" and the consequences of the
"magic", and this "magic" is completely undocumented, and that is far
worse than not documenting a path.

   ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}

You still would not have to explain the paths, if the above was a
separate step, ie creating the keys, I would have no problem with this
being a separate step, since their is an alternative as detailed above.

Ideally I also feel the process I outlined should also be documented as
an alternative to running ceph-create-keys.

> The security sacrifice is small because the keys are
> remaining in the same domain (same host, same UID) as the mon's
> /var/lib, which is already a master key.

I agree that the enhancement is security is small.

In a high security environment, we could have the mon keyring deleted
after startup, by the mon.

I am not advocating this for anyone but the very security conscious, bu=
t
it is definitely possible that some ceph users with highly secure
environments could find this desirable, assuming you can not run
ceph-create-keys without access to the mon keyring, which I expect is
true (but have not tested).

Such an approach would be even more work with the current side effect o=
f
creating all the missing keys each time the mon boots.

> For sites/systems that don't want to write out key files, it would be
> straightforward to add a configuration option to ceph-create-keys so
> that it would not write these out to disk.

Agreed.

But my objection is the side effect, of running ceph-create-keys on mon
boot up, not that ceph-create-keys as a tool exists, or that the tool
ceph-create-keys writes out all the keys, although having this as
optional may be desirable for some deployments.

> Once you had that option, and were also pre-generating all your keys
> with ceph-authtool, I think you'd have the behaviour you wanted
> without anyone else having to update for a change to the mon's defaul=
t
> behaviour.

Thank you for trying hard to preserve the current behavior and address
this issue, but no I don=E2=80=99t have the behavior I want for all the=
 other
points I have raised.

I accept only for point (2) your proposal of not writing the keys to
disk, is a solution, but I caution that this potential solution is even
more confusing than the current behavior, and my proposed solution of
removing this step irrespective of writing to disk or not, from the boo=
t
up of a mon is much more intuitive for an admin coming to ceph.

What I want is that booting a mon does not always run or under some
conditions run, ceph-create-keys after booting in an automagical way.

We still have a lot of use cases I have raised, as to why the current
behavior is magical, and hence creates fear in system admins.

>=20
> John

Thank you for your reply.

(I will get to Greg's kind reply tomorrow is its now 01:00 AM)

Best wishes.

Owen

>> (3) Using the current model adds an extra complication that these ke=
ys
>> then need to be distributed to each node from the configured node, i=
f
>> generated by starting the mon, and not from the configuration server=
=2E
>>
>> (4) If you wish to use a more devops approach, and generate keys
>> explicitly all the keys must be installed on all mon nodes before th=
e
>> mon nodes are started.
>>
>> (4.1) As a side effect we need to document why admins need the
>> mds-bootstrap keyring when they dont want this service it is confusi=
ng,
>> and requires an unnecessary process of migrating all keys to the
>> explicitly desired keys.
>>
>> (5) I am developing a simple python library to configure ceph on eac=
h
>> node independently of all others, (think of it as a parallelism vers=
ion
>> of ceph-deploy that can be called by any config management system) b=
ut
>> with the current side effect behavior starting the mon needs to fail=
 if
>> the mds-bootstrap keyring is not created on the mon nodes before
>> starting the mon, otherwise we get ordering complications.
>>
>> (5) The side effect is confusing, as no one expects this side effect=
,
>> hence this leads to ceph seeming complex to a first time user.
>>
>> (6) I feel it is the responsibility of configuration management not =
the
>> mon demon to request creating these keys.
>>
>> (7) I dont think this is clearly documented, hence this leads to cep=
h
>> seeming complex to a first time user.
>>
>> (8) As more services like mds and rgw get added to ceph the problem =
gets
>> multiplied.
>>
>> (9) Adding one more step to the by hand installation will clarify th=
e
>> authentication process. This extra step would simply be:
>>
>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>>
>> This is simpler and clearer than documenting the side effect.
>>
>> consequences:
>>
>> (1) Each configuration system which depends upon this behavior will =
need
>> to be modified to call the single command on each mon:
>>
>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>>
>> Here is a fix for ceph-deploy:
>>
>> https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9a3=
762e64dd74bf50c
>>
>> I assume other solutions will be easy to fix too.
>>
>> The systemd file in question, is
>> "/usr/lib/systemd/system/ceph-create-keys@.service" and should be re=
moved.
>>
>> This will simplify the salt configuration module documentation
>> considerably, and if this is not done the salt module will need to a=
dd a
>> requirement on the mds keyring being created before the mon can be c=
reated.
>>
>> the systemd file looks as follows:
>>
>>     [Unit]
>>     Description=3DCeph cluster key creator task
>>
>>     # the last key created is the mds bootstrap key -- look for that=
=2E
>>     ConditionPathExists=3D!/var/lib/ceph/bootstrap-mds/ceph.keyring
>>
>>     [Service]
>>     EnvironmentFile=3D-/etc/sysconfig/ceph
>>     Environment=3DCLUSTER=3Dceph
>>     ExecStart=3D/usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id=
 %i
>>
>> as you can see the side effect is blocked if the file
>>
>>     /var/lib/ceph/bootstrap-mds/ceph.keyring
>>
>> already exists, which is just more to document.
>>
>> Hoping that you all agree
>>
>> Owen Synge
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
