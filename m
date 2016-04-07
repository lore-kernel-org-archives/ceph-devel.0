From: Owen Synge <osynge@suse.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 18:08:13 +0200
Message-ID: <570685ED.2050102@suse.com>
References: <5703A7FF.2090002@suse.com>
 <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
 <5704C76C.2050408@suse.com>
 <CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
 <CAJ4mKGZ=LzPxG0H1Xb-RfpvABQa7o0JRxCn=c6n+HzvxVkkegQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60995 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbcDGQIJ (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 7 Apr 2016 12:08:09 -0400
In-Reply-To: <CAJ4mKGZ=LzPxG0H1Xb-RfpvABQa7o0JRxCn=c6n+HzvxVkkegQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 04/07/2016 04:22 PM, Gregory Farnum wrote:
> On Thu, Apr 7, 2016 at 5:33 AM, Alfredo Deza <adeza@redhat.com> wrote=
:
>> On Wed, Apr 6, 2016 at 4:23 AM, Owen Synge <osynge@suse.com> wrote:
>>> Dear Greg and others,
>>>
>>> Thankyou for your very helpful email, as it completely misses my po=
int,
>>> and that illustrate why this point is so important to be addressed.
>>>
>>> I am sure Greg has a deep understanding of this area. But I am plea=
sed
>>> Greg missed my points from 0-9, Greg's assumption that it is lack o=
f
>>> understanding on my part (which I am sure is common), clearly
>>> illustrates where this "magic" of the side effect of starting a mon
>>> demon becomes becomes "dark magic".
>>>
>>> If you object to "magic" and "dark magic" in this email please
>>> substitute them with "side effect" and "negative consequences of si=
de
>>> effects" respectively, and you get a more serious reply :)
>>>
>>> On 04/05/2016 10:14 PM, Gregory Farnum wrote:
>>>> I think you're fundamentally understanding how these keys come int=
o
>>>> existence. They aren't generated randomly on the local monitor; it
>>>> uses get-or-create in order to fetch them (and create them if they
>>>> don't already exist).
>>>
>>> I have looked at this issue in depth, and general confusion in this=
 area
>>> is indeed very common, so it is reasonable to expect everyone is
>>> confused by the same thing.
>>>
>>> In my experience it is "magic" that causes admins fear, as good adm=
ins,
>>> need to understand, because they need to understand the side effect=
s of
>>> any "magic", in case the "magic" is "dark", and in this case it is =
with
>>> points (0) to (8) showing is indeed "dark magic".
>>>
>>> Lets be specific:
>>>
>>> Fetch and create are fundamentally different in side effects when d=
oing
>>> deployment. Lets be clear, when ceph does a "fetch" of a key, is no=
t I
>>> believe and issue, but when ceph uses magic to "create" keys, it ca=
n
>>> often cause side effects. Hence the process to "create" a key shoul=
d
>>> only occur when its asked to be done.
>>>
>>> The current get-or-create keyrings as a side effect of booting a mo=
n
>>> makes many issues (points 0-8 may not be all the issues, just ones =
that
>>> spring to my mind). If the booting of a mon only did a fetch I woul=
d
>>> feel we could resolve all my point except (2) and (9) sadly a boot =
of a
>>> mon will also do a create keys where this "magic" starts to become =
very
>>> "dark" indeed.
>>>
>>>> So maybe it's difficult to pre-generate your own keys and plug the=
m
>>>> into the system (I don't remember where the initial values come fr=
om
>>>> in standard deployment scenarios),
>>>
>>> See my reply to John as to how you can deploy ceph without ceph-cre=
ate-keys.
>>>
>>>> but once they're set up you don't
>>>> need to carefully install your values on all the monitor nodes =E2=
=80=94 they
>>>> will fetch the correct values from the monitor cluster.
>>>
>>> I am objecting to the side effect of booting the mon and that proce=
ss
>>> creating keys that where not asked for, potentially causing valid
>>> osd-bootstrap, rgw-bootstrap or mds-bootstrap to fail authenticatio=
n as
>>> invalid ones have been created as a side effect of starting the mon=
 daemons.
>>
>> That has been a *major* pain point in all deployment strategies
>> (ceph-deploy, ceph-ansible, ceph-installer, manual deployment)
>> I've tried: at some point a monitor is created and started and the
>> whole thing hangs forever because the keys are being helpfully
>> get-or-created for you but for $reasons it is unable to do so and
>> waits indefinitely.
>=20
> I don't have any attachment to ceph-create-keys and the magic itself,
> but this right here is my main concern about changing things: the
> $reasons for failure being cited here were never problems with
> ceph-create-keys itself; it was just the first part of the process
> which required a functioning monitor quorum, and so it functioned as =
a
> (not very good) break point. I have very little personal interest in
> the configuration systems and would be vaguely more content if that
> "test your monitors are speaking to each other" step was both distinc=
t
> from the keys stage and more explicit/debuggable.

That is a good point.

=46ortunately we already have a command that does not require authentic=
ation:

  ceph --connect-timeout 25 \
    --cluster=3Dceph \
    --admin-daemon /var/run/ceph/${CLUSTER}-mon.${MON_NAME}.asok \
    mon_status

and the follwoing command can be used to create the keys:

  ceph --connect-timeout 25 \
    --cluster ceph \
    --name', ${KEY_ID} \
    --keyring ${KEYPATH} \
    auth get-or-create \
    ....
    ....

So for by hand and for ceph-deploy installs we have no issue here as fa=
r
as I can see.

> (But I am noticing that so far the monitor test has either been moved
> to the "create new OSDs" phase or else to the "user runs post-setup
> ceph -s and gets nothing" unsupervised phase; I'm not sure those are
> better since they don't even point directly to the monitors.)

Is this true given my answer above?

> So I think it would be fine to not automatically create keys on
> monitor startup. But Owen is saying, if you create your own bootstrap
> keys, you need to make sure you write them out to the monitor node
> filesystems before startup or they won't match. That's not true!=20

Tiz so :)

> You
> need to make sure the monitor cluster has them, internally, yes. But
> once you've accomplished that, all of your monitors are going to grab
> the bootstrap keys from the cluster and write them out locally =E2=80=
=94 if
> you've got different bootstrap keys on different monitors, you've
> *created multiple monitor clusters*.

Your missing a few points  here:

(A) ceph-create-keys is started on each mon currently as a side effect
of booting the mon, unless a file exists at location

  /var/lib/ceph/bootstrap-mds/ceph.keyring

At least for systemd. ceph-create-keys is looping and waiting for the
mons to reach quorum, as stated by Alfredo, so you have no time window
to add your keys before ceph-create-keys does its thing.

(B) Sure you can create mds-bootstrap, rgw-bootstrap, osd-bootstrap, an=
d
admin keys and add them all to the mon before you start the mon's and
then ceph-create-keys will not cause confusion, but if you dont think
you want one of these keys and change your mind later, then confusion
will happen.

> That's why I'm worried about this specific thread of complaint. :)
> -Greg

Have I removed your worries yet?

Best regards

Owen

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
