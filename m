From: Samuel Just <sam.just@dreamhost.com>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 08:30:26 -0800
Message-ID: <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com>
References: <1404301.on6okQVZ04@pc10>
	<4EEA1309.9030602@grnet.gr>
	<3807778.ycpoZxnZL4@pc10>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56712 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758988Ab1LOQa1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Dec 2011 11:30:27 -0500
Received: by wgbdr13 with SMTP id dr13so4333257wgb.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 08:30:26 -0800 (PST)
In-Reply-To: <3807778.ycpoZxnZL4@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

'ceph pg dump' will tell you the status (active/clean/scrubbing/etc)
for each pg.  Does the same pg remain in state active+clean+scrubbing
for more than 10 minutes?
-Sam

On Thu, Dec 15, 2011 at 7:45 AM, Guido Winkelmann
<guido-ceph@thisisnotatest.de> wrote:
> Am Donnerstag, 15. Dezember 2011, 17:32:25 schrieben Sie:
>> On 12/15/2011 05:07 PM, Guido Winkelmann wrote:
>> > Hi,
>> >
>> > I've got a small ceph cluster with one mon, one mds and two osds (=
all on
>> > the same machine, for now), that I want to use as a block- and fil=
e
>> > storage backend for qemu machine virtualisation.
>> >
>> > I found that read access to some of the rbd images, or parts of so=
me of
>> > them sometimes blocks indefinitely, usually after the image has be=
en
>> > sitting around untouched for a while, for example over night. This=
 has
>> > the effect that virtual machines that try to access their disks as=
 well
>> > as rbd commands like "rbd cp" will just hang indefinitely.
>> >
>> > =C2=A0I found that these blocks can usually be "fixed" by restarti=
ng one of
>> > =C2=A0the>
>> > osds.
>> >
>> > The last time this happened, ceph -s reported one of the osds to b=
e in
>> > state "active+clean+scrubbing". (I'm afraid I don't have the compl=
ete
>> > output from ceph -s anymore.)
>> >
>> > Does anybody have any idea what could be going wrong here?
>>
>> I think it's fixed in v0.39
>
> I'm already using 0.39, so, no. (Should have mentioned that to start =
with...)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
