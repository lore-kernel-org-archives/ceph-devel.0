From: Travis Rhoden <trhoden@gmail.com>
Subject: Re: Moving away from Yum/DNF repo priorities for Ceph and ceph-deploy
Date: Fri, 24 Jul 2015 17:01:01 -0700
Message-ID: <CACkq2mrOK9bnU3sUrb3H4TCf4gBbsdprGkdWD4a08mAuoGDE7w@mail.gmail.com>
References: <0FA51B40-C040-4A64-A2BF-266083E740B6@redhat.com>
 <20150724172400.77454881@guren.zaitcev.lan> <CACEfbZiwU4vMdst7OahtaDAuAC6ZdQaEaFaPYUJ1z8EAyQ7bHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33866 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbbGYABV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 20:01:21 -0400
Received: by oigd21 with SMTP id d21so27555037oig.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 17:01:20 -0700 (PDT)
In-Reply-To: <CACEfbZiwU4vMdst7OahtaDAuAC6ZdQaEaFaPYUJ1z8EAyQ7bHw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Woodward <xarses@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Andrew,

On Fri, Jul 24, 2015 at 4:52 PM, Andrew Woodward <xarses@gmail.com> wro=
te:
> We already had a similar problem with stackforge/puppet-ceph and went
> around in circles for a while trying to account for the issue. We
> ultimately resulted in [1] to resolve the issue for us.
>
> [1] https://review.openstack.org/#/c/197302/1/manifests/repo.pp

Yes, that was part of my motivation for re-opening this topic, and
wanting to reconsider adding "excludes" to .repo entries.  I still
wanted to find a way to not have to modify a different package's files
(e.g. epel-release owns epel.repo) though.  That's why I thought about
breaking it into two phases.

>
>
> On Fri, Jul 24, 2015 at 4:28 PM Pete Zaitcev <zaitcev@redhat.com> wro=
te:
>>
>> On Thu, 23 Jul 2015 16:12:59 -0700
>> Travis Rhoden <trhoden@redhat.com> wrote:
>>
>> > I=E2=80=99m working on ways to improve Ceph installation with ceph=
-deploy, and
>> > a common hurdle we have hit involves dependency issues between cep=
h.com
>> > hosted RPM repos, and packages within EPEL.  For a while we were a=
ble to
>> > managed this with the priorities plugin, but then EPEL shipped pac=
kages
>> > that included changes that weren=E2=80=99t available on the ceph.c=
om packages,
>> > and the EPEL packages =E2=80=9Cobsoleted=E2=80=9D the ceph.com one=
s. [...]
>>
>> This happens every time repos want to conflict with packages provide=
d
>> by the base distro or EPEL. I think the only sensible way to manage =
it is
>> not to conflict and rely on the base packages. That means getting th=
e right
>> versions in. In old EPEL/CentOS/RHEL this may mean versioned names o=
r other
>> tricks, but the point is to get them in. You have access to experien=
ced
>> packagers such as Haikel G., who can help you.
>>
>> So, I'm just curious, what are the specific pain points that we're h=
itting,
>> which prevent using EPEL packages? What are you duplicating and why?
>>
>> -- Pete
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
