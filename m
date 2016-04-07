From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 07:22:27 -0700
Message-ID: <CAJ4mKGZ=LzPxG0H1Xb-RfpvABQa7o0JRxCn=c6n+HzvxVkkegQ@mail.gmail.com>
References: <5703A7FF.2090002@suse.com>
	<CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
	<5704C76C.2050408@suse.com>
	<CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33332 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbcDGOW2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 10:22:28 -0400
Received: by mail-vk0-f43.google.com with SMTP id k1so100877149vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 07:22:27 -0700 (PDT)
In-Reply-To: <CAC-Np1xYbXMwHZ2QcqfvSJTmdhJrvjmEYkyRs8gLaezutZCKAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Owen Synge <osynge@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Apr 7, 2016 at 5:33 AM, Alfredo Deza <adeza@redhat.com> wrote:
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
>
> That has been a *major* pain point in all deployment strategies
> (ceph-deploy, ceph-ansible, ceph-installer, manual deployment)
> I've tried: at some point a monitor is created and started and the
> whole thing hangs forever because the keys are being helpfully
> get-or-created for you but for $reasons it is unable to do so and
> waits indefinitely.

I don't have any attachment to ceph-create-keys and the magic itself,
but this right here is my main concern about changing things: the
$reasons for failure being cited here were never problems with
ceph-create-keys itself; it was just the first part of the process
which required a functioning monitor quorum, and so it functioned as a
(not very good) break point. I have very little personal interest in
the configuration systems and would be vaguely more content if that
"test your monitors are speaking to each other" step was both distinct
from the keys stage and more explicit/debuggable.

(But I am noticing that so far the monitor test has either been moved
to the "create new OSDs" phase or else to the "user runs post-setup
ceph -s and gets nothing" unsupervised phase; I'm not sure those are
better since they don't even point directly to the monitors.)

So I think it would be fine to not automatically create keys on
monitor startup. But Owen is saying, if you create your own bootstrap
keys, you need to make sure you write them out to the monitor node
filesystems before startup or they won't match. That's not true! You
need to make sure the monitor cluster has them, internally, yes. But
once you've accomplished that, all of your monitors are going to grab
the bootstrap keys from the cluster and write them out locally =E2=80=94=
 if
you've got different bootstrap keys on different monitors, you've
*created multiple monitor clusters*.
That's why I'm worried about this specific thread of complaint. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
