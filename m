From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 15:12:41 +0200
Message-ID: <57065CC9.5090909@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:43441 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756271AbcDGNMh (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 7 Apr 2016 09:12:37 -0400
In-Reply-To: <CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 04/07/2016 02:33 PM, Alfredo Deza wrote:
> On Wed, Apr 6, 2016 at 4:23 AM, Owen Synge <osynge@suse.com> wrote:
>> Dear Greg and others,
>>
>> Thankyou for your very helpful email, as it completely misses my poi=
nt,
>> and that illustrate why this point is so important to be addressed.
>>
>> I am sure Greg has a deep understanding of this area. But I am pleas=
ed
>> Greg missed my points from 0-9, Greg's assumption that it is lack of
>> understanding on my part (which I am sure is common), clearly
>> illustrates where this "magic" of the side effect of starting a mon
>> demon becomes becomes "dark magic".
>>
>> If you object to "magic" and "dark magic" in this email please
>> substitute them with "side effect" and "negative consequences of sid=
e
>> effects" respectively, and you get a more serious reply :)
>>
>> On 04/05/2016 10:14 PM, Gregory Farnum wrote:
>>> I think you're fundamentally understanding how these keys come into
>>> existence. They aren't generated randomly on the local monitor; it
>>> uses get-or-create in order to fetch them (and create them if they
>>> don't already exist).
>>
>> I have looked at this issue in depth, and general confusion in this =
area
>> is indeed very common, so it is reasonable to expect everyone is
>> confused by the same thing.
>>
>> In my experience it is "magic" that causes admins fear, as good admi=
ns,
>> need to understand, because they need to understand the side effects=
 of
>> any "magic", in case the "magic" is "dark", and in this case it is w=
ith
>> points (0) to (8) showing is indeed "dark magic".
>>
>> Lets be specific:
>>
>> Fetch and create are fundamentally different in side effects when do=
ing
>> deployment. Lets be clear, when ceph does a "fetch" of a key, is not=
 I
>> believe and issue, but when ceph uses magic to "create" keys, it can
>> often cause side effects. Hence the process to "create" a key should
>> only occur when its asked to be done.
>>
>> The current get-or-create keyrings as a side effect of booting a mon
>> makes many issues (points 0-8 may not be all the issues, just ones t=
hat
>> spring to my mind). If the booting of a mon only did a fetch I would
>> feel we could resolve all my point except (2) and (9) sadly a boot o=
f a
>> mon will also do a create keys where this "magic" starts to become v=
ery
>> "dark" indeed.
>>
>>> So maybe it's difficult to pre-generate your own keys and plug them
>>> into the system (I don't remember where the initial values come fro=
m
>>> in standard deployment scenarios),
>>
>> See my reply to John as to how you can deploy ceph without ceph-crea=
te-keys.
>>
>>> but once they're set up you don't
>>> need to carefully install your values on all the monitor nodes =E2=80=
=94 they
>>> will fetch the correct values from the monitor cluster.
>>
>> I am objecting to the side effect of booting the mon and that proces=
s
>> creating keys that where not asked for, potentially causing valid
>> osd-bootstrap, rgw-bootstrap or mds-bootstrap to fail authentication=
 as
>> invalid ones have been created as a side effect of starting the mon =
daemons.
>=20
> That has been a *major* pain point in all deployment strategies
> (ceph-deploy, ceph-ansible, ceph-installer, manual deployment)
> I've tried: at some point a monitor is created and started and the
> whole thing hangs forever because the keys are being helpfully
> get-or-created for you but for $reasons it is unable to do so and
> waits indefinitely.

Thank you for the conformation, that this has effected you too.

I have had this problem with trying to make "ceph-salt" truly idiot
proof and without any timing issues.

> This loop here:
> https://github.com/ceph/ceph/blob/master/src/ceph-create-keys#L89-L12=
0

=46ortunately I have not yet seen this loop waiting indefinitely.

I (or some one else) should I guess get around to writing a time out
patch, if some one does not get there first.

> Not even the log output is helpful because it is used as a side effec=
t
> process of starting a monitor, muting all output:
>=20
> https://github.com/ceph/ceph/blob/jewel/src/init-ceph.in#L443

Oh yes that is probably the most horrid consequence of the "magic" I
have yet seen. I think this now deserves being referenced as point (10)

>>> The coordination problem here is not really any different than that=
 of
>>> making sure your monitors are all part of the "mon initial members"
>>> config option,
>>
>> You are forgetting that we also have osd-bootstrap, rgw-bootstrap or
>> mds-bootstrap keys and these may be generated by some other tool tha=
n
>> the mon, this is made much much harder to do by the mon init scripts
>> without being asked explicitly to do so.
>>
>>> btw. Which you need to solve or else you're liable to
>>> have them coming up and creating independent monitor clusters and
>>> going haywire.
>>> -Greg
>>
>> Not knowing what is happening is the enemy of understanding, and hen=
ce
>> the creator of "magic". Often giving the "magic" a name, or making i=
t
>> explicit, causes enough understanding to remove it's "magic" propert=
ies.
>> Hence making all occurrences of key "create" (not "fetch") an explic=
it
>> step rather than a side effect will go a great deal to address this =
issue.
>>
>> So if creating keys was not a side effect of booting mons, we would =
have
>> not issue here, as anyone who is used to cluster automation, has goo=
d
>> tools. These tools include chef, puppet, salt, and ansible, for clus=
ter
>> management ideally, but more manually we have tools to copy files su=
ch
>> as rsync, scp, and tools to diagnose such issues such as checksums.
>>
>>   ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>>
>> Having the above command separated from booting a mon actually avoid=
s
>> osd's rgw's and mds's going haywire if they are configured in parall=
el
>> to the mon with keys from a source external to the mon, unless you
>> either (a) build in a layer of cluster synchronization above ceph, s=
uch
>> as ceph-deploy has done with its single threaded operation across a
>> complete cluster, or (b) do lots of dirty "magic" to remove
>> inconsistencies. Solution (a) is not good due to issue (0) amongst
>> others, and (b) creates more "magic" which has to be very carefully
>> designed to avoid it being "dark".
>=20
> Putting the "magic" definition aside,  being explicit about the
> creation and management of keys would
> be fantastic to have. Having an extra explicit step where a user/admi=
n
> needs to "create a key or distribute the keys you already have for
> your cluster"
> would be a big win here.

This is wonderful that we are coming to consensus here :)

So I will raise a bug, and site this thread.

Best regards

Owen

>=20
>>
>> Another way to remove this "magic" is to document "magic" in detail,=
 and
>> documenting this in this email is long and detailed, although Greg m=
ade
>> a start, he missed out the very important part of why the mds-bootst=
rap
>> keyring, is more important than is documented when if comes to deplo=
ying
>> your cluster the first time. I will skip it for now, but I am happy =
to
>> expand if needed.
>>
>> In this case I argue the "magic" can be removed by making the proces=
s of
>> creating keys explicit. I would propose separating the "create" of  =
keys
>> from booting a mon is the least confusing and "magical" solution, wi=
th
>> the least chance of causing trouble for admins.
>>
>> Thank you Greg for taking the time to reply, and please forgive me f=
or
>> using your reply to illustrate that the real problem is the "magic",=
 and
>> that "magic" removes understanding, hence knowledge of the "magic"
>> having "dark" issues, as this is a fear inducing thing for an admin =
new
>> to ceph.
>>
>> Best wishes,
>>
>> Owen
>>
>>> On Tue, Apr 5, 2016 at 4:56 AM, Owen Synge <osynge@suse.com> wrote:
>>>> Dear all,
>>>>
>>>> This is in my opinion is clearly a bug, but I raise it in the mail=
ing
>>>> list as I expect all admins of ceph will strongly agree, that this=
 makes
>>>> ceph simpler, but developers may feel that since it requires chang=
es to
>>>> more than one repo its not worth doing.
>>>>
>>>> When ever you start the mon demon as a side effect the admin, osd,=
 rgw
>>>> and mds keys are created as a side effect if the mds keyring is no=
t
>>>> existing.
>>>>
>>>> In the systemV and systemd init scripts (at least) we have a side
>>>> effect, that should be removed in my opinion, (or worse in my
>>>> alternatively correctly documented.)
>>>>
>>>> This is a deployment layer violation, in my opinion, and it requir=
es
>>>> considerably more documentation, (and on my part also code) to kee=
p this
>>>> side effect than remove it.
>>>>
>>>> usecases for removing this are:
>>>>
>>>> (0) A ceph cluster should be able to be installed in any order. Wi=
th the
>>>> current behavior if the mds, rgw, or osd nodes are deployed first =
(along
>>>> with the boot strap keyrings), the mon created must have all keys =
for
>>>> the admin, mds-bootstrap, rgw-bootstrap, and osd-boostrap deployed=
 in
>>>> the correct path before the mon can safely be started, even if the
>>>> cluster does not need the mds or rgw service's.
>>>>
>>>> (1) It is unfriendly to configuration being stored on the configur=
ation
>>>> server as the server needs to be updated with the values from the
>>>> configured node keys, when people might want to store these keys c=
entrally.
>>>>
>>>> (2) Assuming the admin, rgw-bootstrap, mds-bootstrap and osd-boost=
rap
>>>> keys are always installed on all mon nodes is clearly increasing t=
he
>>>> distribution of keys where they might not be needed. Hence reducin=
g
>>>> security.
>>>>
>>>> (3) Using the current model adds an extra complication that these =
keys
>>>> then need to be distributed to each node from the configured node,=
 if
>>>> generated by starting the mon, and not from the configuration serv=
er.
>>>>
>>>> (4) If you wish to use a more devops approach, and generate keys
>>>> explicitly all the keys must be installed on all mon nodes before =
the
>>>> mon nodes are started.
>>>>
>>>> (4.1) As a side effect we need to document why admins need the
>>>> mds-bootstrap keyring when they dont want this service it is confu=
sing,
>>>> and requires an unnecessary process of migrating all keys to the
>>>> explicitly desired keys.
>>>>
>>>> (5) I am developing a simple python library to configure ceph on e=
ach
>>>> node independently of all others, (think of it as a parallelism ve=
rsion
>>>> of ceph-deploy that can be called by any config management system)=
 but
>>>> with the current side effect behavior starting the mon needs to fa=
il if
>>>> the mds-bootstrap keyring is not created on the mon nodes before
>>>> starting the mon, otherwise we get ordering complications.
>>>>
>>>> (5) The side effect is confusing, as no one expects this side effe=
ct,
>>>> hence this leads to ceph seeming complex to a first time user.
>>>>
>>>> (6) I feel it is the responsibility of configuration management no=
t the
>>>> mon demon to request creating these keys.
>>>>
>>>> (7) I dont think this is clearly documented, hence this leads to c=
eph
>>>> seeming complex to a first time user.
>>>>
>>>> (8) As more services like mds and rgw get added to ceph the proble=
m gets
>>>> multiplied.
>>>>
>>>> (9) Adding one more step to the by hand installation will clarify =
the
>>>> authentication process. This extra step would simply be:
>>>>
>>>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME=
}
>>>>
>>>> This is simpler and clearer than documenting the side effect.
>>>>
>>>> consequences:
>>>>
>>>> (1) Each configuration system which depends upon this behavior wil=
l need
>>>> to be modified to call the single command on each mon:
>>>>
>>>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME=
}
>>>>
>>>> Here is a fix for ceph-deploy:
>>>>
>>>> https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9=
a3762e64dd74bf50c
>>>>
>>>> I assume other solutions will be easy to fix too.
>>>>
>>>> The systemd file in question, is
>>>> "/usr/lib/systemd/system/ceph-create-keys@.service" and should be =
removed.
>>>>
>>>> This will simplify the salt configuration module documentation
>>>> considerably, and if this is not done the salt module will need to=
 add a
>>>> requirement on the mds keyring being created before the mon can be=
 created.
>>>>
>>>> the systemd file looks as follows:
>>>>
>>>>     [Unit]
>>>>     Description=3DCeph cluster key creator task
>>>>
>>>>     # the last key created is the mds bootstrap key -- look for th=
at.
>>>>     ConditionPathExists=3D!/var/lib/ceph/bootstrap-mds/ceph.keyrin=
g
>>>>
>>>>     [Service]
>>>>     EnvironmentFile=3D-/etc/sysconfig/ceph
>>>>     Environment=3DCLUSTER=3Dceph
>>>>     ExecStart=3D/usr/sbin/ceph-create-keys --cluster ${CLUSTER} --=
id %i
>>>>
>>>> as you can see the side effect is blocked if the file
>>>>
>>>>     /var/lib/ceph/bootstrap-mds/ceph.keyring
>>>>
>>>> already exists, which is just more to document.
>>>>
>>>> Hoping that you all agree
>>>>
>>>> Owen Synge
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rff=
er, HRB
>> 21284 (AG
>> N=C3=BCrnberg)
>>
>> Maxfeldstra=C3=9Fe 5
>>
>> 90409 N=C3=BCrnberg
>>
>> Germany
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
