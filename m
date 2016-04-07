From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was: mon
 daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 07:23:52 -0700
Message-ID: <CAJ4mKGb1O5UWHoYQKaqWOeaNJkWES509Gmesxkgu4ZP+8-TSpQ@mail.gmail.com>
References: <5703A7FF.2090002@suse.com>
	<CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com>
	<5704C76C.2050408@suse.com>
	<alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com>
	<570666AB.8090408@suse.com>
	<alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34404 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756532AbcDGOXy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2016 10:23:54 -0400
Received: by mail-vk0-f41.google.com with SMTP id e185so100890332vkb.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2016 07:23:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Owen Synge <osynge@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>

On Thu, Apr 7, 2016 at 7:03 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 7 Apr 2016, Owen Synge wrote:
>> Hi Sage,
>>
>> On 04/07/2016 02:26 PM, Sage Weil wrote:
>> > Hi Owen,
>> >
>> > I never really liked ceph-create-keys either, but it simplified th=
e
>> > deployment process.
>>
>> I would propose we do this in two stages.
>>
>> (A) Remove calling the command from the init scripts as a side effec=
t of
>> starting the mon.
>>
>> This allows us to get most of the issues solved.
>>
>> (B) Remove the command.
>>
>> This is the long term goal, which is not as urgent in my opinion but
>> others may disagree.
>
> Works for me.  We just need to change ceph-deploy and get the other
> install/deploy tool folks on board before A.
>
>> > I have no problem with removing it as long as we make
>> > sure the deployment process doesn't too much harder for ceph-deplo=
y users.
>>
>> The documentation for the manual process without using ceph-deploy w=
ill
>> need to be changed if we remove calling ceph-create-keys from the bo=
ot
>> scripts.
>
> Yeah.
>
>> For ceph-deploy users I think we should see if any changes to the
>> process are needed, the next question is will any be wanted?
>
> Actually, thinking about it a bit more, I don't think ceph-deploy usa=
ge
> has to change at all.  The old way was
>
>  1. ceph-create-keys creates and installs the keys on the mons
>  2. ceph-deploy gatherkeys or create-initial slurps them up
>
> We can just change ceph-deploy so it creates and stores them locally,=
 and
> doesn't store them on the mons at all.  Users don't get the side-effe=
ct
> that the mons have the keys installed, but that is arguably better an=
yway.

Note that this would mean users can only run "ceph -s" from a node
that has explicitly installed the keys =E2=80=94 if you are debugging a
problem and ssh into the monitor node, you'll have to run fugly
command lines pointing to the monitor's data directory and using a
"mon." entity name in order to get any cluster debug info. :/
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
