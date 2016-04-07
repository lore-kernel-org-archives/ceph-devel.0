From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 09:51:50 -0700
Message-ID: <CAJ4mKGaori72gzpsBK0pS4TZA4TyyNemW=iWO8ePPnhPjJJccA@mail.gmail.com>
References: <5703A7FF.2090002@suse.com>
	<CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
	<5704C76C.2050408@suse.com>
	<CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
	<CAJ4mKGZ=LzPxG0H1Xb-RfpvABQa7o0JRxCn=c6n+HzvxVkkegQ@mail.gmail.com>
	<570685ED.2050102@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33230 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756553AbcDGQvv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 12:51:51 -0400
Received: by mail-vk0-f52.google.com with SMTP id k1so106894986vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 09:51:51 -0700 (PDT)
In-Reply-To: <570685ED.2050102@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Alfredo Deza <adeza@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Apr 7, 2016 at 9:08 AM, Owen Synge <osynge@suse.com> wrote:
> On 04/07/2016 04:22 PM, Gregory Farnum wrote:
>> On Thu, Apr 7, 2016 at 5:33 AM, Alfredo Deza <adeza@redhat.com> wrot=
e:
>>> On Wed, Apr 6, 2016 at 4:23 AM, Owen Synge <osynge@suse.com> wrote:
>>>> Dear Greg and others,
>>>>
>>>> Thankyou for your very helpful email, as it completely misses my p=
oint,
>>>> and that illustrate why this point is so important to be addressed=
=2E
>>>>
>>>> I am sure Greg has a deep understanding of this area. But I am ple=
ased
>>>> Greg missed my points from 0-9, Greg's assumption that it is lack =
of
>>>> understanding on my part (which I am sure is common), clearly
>>>> illustrates where this "magic" of the side effect of starting a mo=
n
>>>> demon becomes becomes "dark magic".
>>>>
>>>> If you object to "magic" and "dark magic" in this email please
>>>> substitute them with "side effect" and "negative consequences of s=
ide
>>>> effects" respectively, and you get a more serious reply :)
>>>>
>>>> On 04/05/2016 10:14 PM, Gregory Farnum wrote:
>>>>> I think you're fundamentally understanding how these keys come in=
to
>>>>> existence. They aren't generated randomly on the local monitor; i=
t
>>>>> uses get-or-create in order to fetch them (and create them if the=
y
>>>>> don't already exist).
>>>>
>>>> I have looked at this issue in depth, and general confusion in thi=
s area
>>>> is indeed very common, so it is reasonable to expect everyone is
>>>> confused by the same thing.
>>>>
>>>> In my experience it is "magic" that causes admins fear, as good ad=
mins,
>>>> need to understand, because they need to understand the side effec=
ts of
>>>> any "magic", in case the "magic" is "dark", and in this case it is=
 with
>>>> points (0) to (8) showing is indeed "dark magic".
>>>>
>>>> Lets be specific:
>>>>
>>>> Fetch and create are fundamentally different in side effects when =
doing
>>>> deployment. Lets be clear, when ceph does a "fetch" of a key, is n=
ot I
>>>> believe and issue, but when ceph uses magic to "create" keys, it c=
an
>>>> often cause side effects. Hence the process to "create" a key shou=
ld
>>>> only occur when its asked to be done.
>>>>
>>>> The current get-or-create keyrings as a side effect of booting a m=
on
>>>> makes many issues (points 0-8 may not be all the issues, just ones=
 that
>>>> spring to my mind). If the booting of a mon only did a fetch I wou=
ld
>>>> feel we could resolve all my point except (2) and (9) sadly a boot=
 of a
>>>> mon will also do a create keys where this "magic" starts to become=
 very
>>>> "dark" indeed.
>>>>
>>>>> So maybe it's difficult to pre-generate your own keys and plug th=
em
>>>>> into the system (I don't remember where the initial values come f=
rom
>>>>> in standard deployment scenarios),
>>>>
>>>> See my reply to John as to how you can deploy ceph without ceph-cr=
eate-keys.
>>>>
>>>>> but once they're set up you don't
>>>>> need to carefully install your values on all the monitor nodes =E2=
=80=94 they
>>>>> will fetch the correct values from the monitor cluster.
>>>>
>>>> I am objecting to the side effect of booting the mon and that proc=
ess
>>>> creating keys that where not asked for, potentially causing valid
>>>> osd-bootstrap, rgw-bootstrap or mds-bootstrap to fail authenticati=
on as
>>>> invalid ones have been created as a side effect of starting the mo=
n daemons.
>>>
>>> That has been a *major* pain point in all deployment strategies
>>> (ceph-deploy, ceph-ansible, ceph-installer, manual deployment)
>>> I've tried: at some point a monitor is created and started and the
>>> whole thing hangs forever because the keys are being helpfully
>>> get-or-created for you but for $reasons it is unable to do so and
>>> waits indefinitely.
>>
>> I don't have any attachment to ceph-create-keys and the magic itself=
,
>> but this right here is my main concern about changing things: the
>> $reasons for failure being cited here were never problems with
>> ceph-create-keys itself; it was just the first part of the process
>> which required a functioning monitor quorum, and so it functioned as=
 a
>> (not very good) break point. I have very little personal interest in
>> the configuration systems and would be vaguely more content if that
>> "test your monitors are speaking to each other" step was both distin=
ct
>> from the keys stage and more explicit/debuggable.
>
> That is a good point.
>
> Fortunately we already have a command that does not require authentic=
ation:
>
>   ceph --connect-timeout 25 \
>     --cluster=3Dceph \
>     --admin-daemon /var/run/ceph/${CLUSTER}-mon.${MON_NAME}.asok \
>     mon_status
>
> and the follwoing command can be used to create the keys:
>
>   ceph --connect-timeout 25 \
>     --cluster ceph \
>     --name', ${KEY_ID} \
>     --keyring ${KEYPATH} \
>     auth get-or-create \
>     ....
>     ....
>
> So for by hand and for ceph-deploy installs we have no issue here as =
far
> as I can see.
>
>> (But I am noticing that so far the monitor test has either been move=
d
>> to the "create new OSDs" phase or else to the "user runs post-setup
>> ceph -s and gets nothing" unsupervised phase; I'm not sure those are
>> better since they don't even point directly to the monitors.)
>
> Is this true given my answer above?
>
>> So I think it would be fine to not automatically create keys on
>> monitor startup. But Owen is saying, if you create your own bootstra=
p
>> keys, you need to make sure you write them out to the monitor node
>> filesystems before startup or they won't match. That's not true!
>
> Tiz so :)
>
>> You
>> need to make sure the monitor cluster has them, internally, yes. But
>> once you've accomplished that, all of your monitors are going to gra=
b
>> the bootstrap keys from the cluster and write them out locally =E2=80=
=94 if
>> you've got different bootstrap keys on different monitors, you've
>> *created multiple monitor clusters*.
>
> Your missing a few points  here:
>
> (A) ceph-create-keys is started on each mon currently as a side effec=
t
> of booting the mon, unless a file exists at location
>
>   /var/lib/ceph/bootstrap-mds/ceph.keyring
>
> At least for systemd. ceph-create-keys is looping and waiting for the
> mons to reach quorum, as stated by Alfredo, so you have no time windo=
w
> to add your keys before ceph-create-keys does its thing.

Ah, yeah, if we don't have an injection step that would be annoying. I
guess I was thinking back to last time I was dealing with Chef
cookbooks, but we didn't have the create-keys stuff then.

>
> (B) Sure you can create mds-bootstrap, rgw-bootstrap, osd-bootstrap, =
and
> admin keys and add them all to the mon before you start the mon's and
> then ceph-create-keys will not cause confusion, but if you dont think
> you want one of these keys and change your mind later, then confusion
> will happen.
>
>> That's why I'm worried about this specific thread of complaint. :)
>> -Greg
>
> Have I removed your worries yet?

Yeah, I was just not certain about the way it was being phrased. Sounds=
 good!
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
