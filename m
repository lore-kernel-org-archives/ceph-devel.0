From: Alfredo Deza <adeza@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 08:33:47 -0400
Message-ID: <CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
References: <5703A7FF.2090002@suse.com>
	<CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
	<5704C76C.2050408@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35810 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbcDGMdt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 08:33:49 -0400
Received: by mail-wm0-f51.google.com with SMTP id 191so90062484wmq.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 05:33:48 -0700 (PDT)
In-Reply-To: <5704C76C.2050408@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Apr 6, 2016 at 4:23 AM, Owen Synge <osynge@suse.com> wrote:
> Dear Greg and others,
>
> Thankyou for your very helpful email, as it completely misses my poin=
t,
> and that illustrate why this point is so important to be addressed.
>
> I am sure Greg has a deep understanding of this area. But I am please=
d
> Greg missed my points from 0-9, Greg's assumption that it is lack of
> understanding on my part (which I am sure is common), clearly
> illustrates where this "magic" of the side effect of starting a mon
> demon becomes becomes "dark magic".
>
> If you object to "magic" and "dark magic" in this email please
> substitute them with "side effect" and "negative consequences of side
> effects" respectively, and you get a more serious reply :)
>
> On 04/05/2016 10:14 PM, Gregory Farnum wrote:
>> I think you're fundamentally understanding how these keys come into
>> existence. They aren't generated randomly on the local monitor; it
>> uses get-or-create in order to fetch them (and create them if they
>> don't already exist).
>
> I have looked at this issue in depth, and general confusion in this a=
rea
> is indeed very common, so it is reasonable to expect everyone is
> confused by the same thing.
>
> In my experience it is "magic" that causes admins fear, as good admin=
s,
> need to understand, because they need to understand the side effects =
of
> any "magic", in case the "magic" is "dark", and in this case it is wi=
th
> points (0) to (8) showing is indeed "dark magic".
>
> Lets be specific:
>
> Fetch and create are fundamentally different in side effects when doi=
ng
> deployment. Lets be clear, when ceph does a "fetch" of a key, is not =
I
> believe and issue, but when ceph uses magic to "create" keys, it can
> often cause side effects. Hence the process to "create" a key should
> only occur when its asked to be done.
>
> The current get-or-create keyrings as a side effect of booting a mon
> makes many issues (points 0-8 may not be all the issues, just ones th=
at
> spring to my mind). If the booting of a mon only did a fetch I would
> feel we could resolve all my point except (2) and (9) sadly a boot of=
 a
> mon will also do a create keys where this "magic" starts to become ve=
ry
> "dark" indeed.
>
>> So maybe it's difficult to pre-generate your own keys and plug them
>> into the system (I don't remember where the initial values come from
>> in standard deployment scenarios),
>
> See my reply to John as to how you can deploy ceph without ceph-creat=
e-keys.
>
>> but once they're set up you don't
>> need to carefully install your values on all the monitor nodes =E2=80=
=94 they
>> will fetch the correct values from the monitor cluster.
>
> I am objecting to the side effect of booting the mon and that process
> creating keys that where not asked for, potentially causing valid
> osd-bootstrap, rgw-bootstrap or mds-bootstrap to fail authentication =
as
> invalid ones have been created as a side effect of starting the mon d=
aemons.

That has been a *major* pain point in all deployment strategies
(ceph-deploy, ceph-ansible, ceph-installer, manual deployment)
I've tried: at some point a monitor is created and started and the
whole thing hangs forever because the keys are being helpfully
get-or-created for you but for $reasons it is unable to do so and
waits indefinitely.

This loop here:
https://github.com/ceph/ceph/blob/master/src/ceph-create-keys#L89-L120

Not even the log output is helpful because it is used as a side effect
process of starting a monitor, muting all output:

https://github.com/ceph/ceph/blob/jewel/src/init-ceph.in#L443

>
>> The coordination problem here is not really any different than that =
of
>> making sure your monitors are all part of the "mon initial members"
>> config option,
>
> You are forgetting that we also have osd-bootstrap, rgw-bootstrap or
> mds-bootstrap keys and these may be generated by some other tool than
> the mon, this is made much much harder to do by the mon init scripts
> without being asked explicitly to do so.
>
>> btw. Which you need to solve or else you're liable to
>> have them coming up and creating independent monitor clusters and
>> going haywire.
>> -Greg
>
> Not knowing what is happening is the enemy of understanding, and henc=
e
> the creator of "magic". Often giving the "magic" a name, or making it
> explicit, causes enough understanding to remove it's "magic" properti=
es.
> Hence making all occurrences of key "create" (not "fetch") an explici=
t
> step rather than a side effect will go a great deal to address this i=
ssue.
>
> So if creating keys was not a side effect of booting mons, we would h=
ave
> not issue here, as anyone who is used to cluster automation, has good
> tools. These tools include chef, puppet, salt, and ansible, for clust=
er
> management ideally, but more manually we have tools to copy files suc=
h
> as rsync, scp, and tools to diagnose such issues such as checksums.
>
>   ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>
> Having the above command separated from booting a mon actually avoids
> osd's rgw's and mds's going haywire if they are configured in paralle=
l
> to the mon with keys from a source external to the mon, unless you
> either (a) build in a layer of cluster synchronization above ceph, su=
ch
> as ceph-deploy has done with its single threaded operation across a
> complete cluster, or (b) do lots of dirty "magic" to remove
> inconsistencies. Solution (a) is not good due to issue (0) amongst
> others, and (b) creates more "magic" which has to be very carefully
> designed to avoid it being "dark".

Putting the "magic" definition aside,  being explicit about the
creation and management of keys would
be fantastic to have. Having an extra explicit step where a user/admin
needs to "create a key or distribute the keys you already have for
your cluster"
would be a big win here.

>
> Another way to remove this "magic" is to document "magic" in detail, =
and
> documenting this in this email is long and detailed, although Greg ma=
de
> a start, he missed out the very important part of why the mds-bootstr=
ap
> keyring, is more important than is documented when if comes to deploy=
ing
> your cluster the first time. I will skip it for now, but I am happy t=
o
> expand if needed.
>
> In this case I argue the "magic" can be removed by making the process=
 of
> creating keys explicit. I would propose separating the "create" of  k=
eys
> from booting a mon is the least confusing and "magical" solution, wit=
h
> the least chance of causing trouble for admins.
>
> Thank you Greg for taking the time to reply, and please forgive me fo=
r
> using your reply to illustrate that the real problem is the "magic", =
and
> that "magic" removes understanding, hence knowledge of the "magic"
> having "dark" issues, as this is a fear inducing thing for an admin n=
ew
> to ceph.
>
> Best wishes,
>
> Owen
>
>> On Tue, Apr 5, 2016 at 4:56 AM, Owen Synge <osynge@suse.com> wrote:
>>> Dear all,
>>>
>>> This is in my opinion is clearly a bug, but I raise it in the maili=
ng
>>> list as I expect all admins of ceph will strongly agree, that this =
makes
>>> ceph simpler, but developers may feel that since it requires change=
s to
>>> more than one repo its not worth doing.
>>>
>>> When ever you start the mon demon as a side effect the admin, osd, =
rgw
>>> and mds keys are created as a side effect if the mds keyring is not
>>> existing.
>>>
>>> In the systemV and systemd init scripts (at least) we have a side
>>> effect, that should be removed in my opinion, (or worse in my
>>> alternatively correctly documented.)
>>>
>>> This is a deployment layer violation, in my opinion, and it require=
s
>>> considerably more documentation, (and on my part also code) to keep=
 this
>>> side effect than remove it.
>>>
>>> usecases for removing this are:
>>>
>>> (0) A ceph cluster should be able to be installed in any order. Wit=
h the
>>> current behavior if the mds, rgw, or osd nodes are deployed first (=
along
>>> with the boot strap keyrings), the mon created must have all keys f=
or
>>> the admin, mds-bootstrap, rgw-bootstrap, and osd-boostrap deployed =
in
>>> the correct path before the mon can safely be started, even if the
>>> cluster does not need the mds or rgw service's.
>>>
>>> (1) It is unfriendly to configuration being stored on the configura=
tion
>>> server as the server needs to be updated with the values from the
>>> configured node keys, when people might want to store these keys ce=
ntrally.
>>>
>>> (2) Assuming the admin, rgw-bootstrap, mds-bootstrap and osd-boostr=
ap
>>> keys are always installed on all mon nodes is clearly increasing th=
e
>>> distribution of keys where they might not be needed. Hence reducing
>>> security.
>>>
>>> (3) Using the current model adds an extra complication that these k=
eys
>>> then need to be distributed to each node from the configured node, =
if
>>> generated by starting the mon, and not from the configuration serve=
r.
>>>
>>> (4) If you wish to use a more devops approach, and generate keys
>>> explicitly all the keys must be installed on all mon nodes before t=
he
>>> mon nodes are started.
>>>
>>> (4.1) As a side effect we need to document why admins need the
>>> mds-bootstrap keyring when they dont want this service it is confus=
ing,
>>> and requires an unnecessary process of migrating all keys to the
>>> explicitly desired keys.
>>>
>>> (5) I am developing a simple python library to configure ceph on ea=
ch
>>> node independently of all others, (think of it as a parallelism ver=
sion
>>> of ceph-deploy that can be called by any config management system) =
but
>>> with the current side effect behavior starting the mon needs to fai=
l if
>>> the mds-bootstrap keyring is not created on the mon nodes before
>>> starting the mon, otherwise we get ordering complications.
>>>
>>> (5) The side effect is confusing, as no one expects this side effec=
t,
>>> hence this leads to ceph seeming complex to a first time user.
>>>
>>> (6) I feel it is the responsibility of configuration management not=
 the
>>> mon demon to request creating these keys.
>>>
>>> (7) I dont think this is clearly documented, hence this leads to ce=
ph
>>> seeming complex to a first time user.
>>>
>>> (8) As more services like mds and rgw get added to ceph the problem=
 gets
>>> multiplied.
>>>
>>> (9) Adding one more step to the by hand installation will clarify t=
he
>>> authentication process. This extra step would simply be:
>>>
>>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>>>
>>> This is simpler and clearer than documenting the side effect.
>>>
>>> consequences:
>>>
>>> (1) Each configuration system which depends upon this behavior will=
 need
>>> to be modified to call the single command on each mon:
>>>
>>>    /usr/sbin/ceph-create-keys --cluster ${CLUSTER} --id ${MON_NAME}
>>>
>>> Here is a fix for ceph-deploy:
>>>
>>> https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9a=
3762e64dd74bf50c
>>>
>>> I assume other solutions will be easy to fix too.
>>>
>>> The systemd file in question, is
>>> "/usr/lib/systemd/system/ceph-create-keys@.service" and should be r=
emoved.
>>>
>>> This will simplify the salt configuration module documentation
>>> considerably, and if this is not done the salt module will need to =
add a
>>> requirement on the mds keyring being created before the mon can be =
created.
>>>
>>> the systemd file looks as follows:
>>>
>>>     [Unit]
>>>     Description=3DCeph cluster key creator task
>>>
>>>     # the last key created is the mds bootstrap key -- look for tha=
t.
>>>     ConditionPathExists=3D!/var/lib/ceph/bootstrap-mds/ceph.keyring
>>>
>>>     [Service]
>>>     EnvironmentFile=3D-/etc/sysconfig/ceph
>>>     Environment=3DCLUSTER=3Dceph
>>>     ExecStart=3D/usr/sbin/ceph-create-keys --cluster ${CLUSTER} --i=
d %i
>>>
>>> as you can see the side effect is blocked if the file
>>>
>>>     /var/lib/ceph/bootstrap-mds/ceph.keyring
>>>
>>> already exists, which is just more to document.
>>>
>>> Hoping that you all agree
>>>
>>> Owen Synge
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffe=
r, HRB
> 21284 (AG
> N=C3=BCrnberg)
>
> Maxfeldstra=C3=9Fe 5
>
> 90409 N=C3=BCrnberg
>
> Germany
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
