From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD image name constraints
Date: Fri, 8 Apr 2016 20:12:05 +0200
Message-ID: <CAOi1vP_kmBVJdE=bZgSArms44mH70ZvDn9dHQVZFE0VU55qLCg@mail.gmail.com>
References: <5707A2C4.3030102@corp.ovh.com>
	<CAOi1vP_MPeS8n7_rMnufeFPMU2=sy3vudOjDonZ=Gk+dHKuGCg@mail.gmail.com>
	<5707EC26.4000909@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35115 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbcDHSMN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Apr 2016 14:12:13 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so86716184lfb.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 Apr 2016 11:12:12 -0700 (PDT)
In-Reply-To: <5707EC26.4000909@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: =?UTF-8?B?QmFydMWCb21pZWogxZp3acSZY2tp?= <bartlomiej.swiecki@corp.ovh.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Apr 8, 2016 at 7:36 PM, Alex Elder <elder@ieee.org> wrote:
> On 04/08/2016 11:13 AM, Ilya Dryomov wrote:
>> On Fri, Apr 8, 2016 at 2:23 PM, Bart=C5=82omiej =C5=9Awi=C4=99cki
>> <bartlomiej.swiecki@corp.ovh.com> wrote:
>>> Hi,
>>>
>>> What are constraints regarding names of RBD images? I tried to look=
 it up
>>> but without success.
>>
>> I'm afraid this is something nobody ever paid enough attention to.
>>
>>>
>>> My tests show that maximum length is about 4089 bytes and the only =
forbidden
>>> characters are '\0' and '@' but didn't get deep enough into the cod=
e to
>>> figure out the length limit. Are my findings correct?
>>
>> There is an old define in the code base, but it's not enforced:
>>
>>     #define RBD_MAX_IMAGE_NAME_SIZE 96
>
> On the kernel RBD client we have RBD_IMAGE_NAME_LEN_MAX,
> which is 4093 bytes.  That is because the RBD "dir_get_name"
> object method returns an encoded string, which consists of a
> 32-byte name length followed by the name.  We place the result
> into a buffer which has room for a terminating NUL character.
> This length value was used to limit the buffer size to a 4KB
> page or less.  I haven't checked but I'm pretty sure the request
> fails of the name is larger than that.
>
> It does not surprise me that there are other limits that are
> more restrictive than that.  The one you're referring to below
> appears to be CEPH_MAX_OID_NAME_LEN.

Yes - it's the only one that matters.

>
>> The kernel client, however, won't process object requests with names
>> bigger than 100 chars.  Lifting this limitation wouldn't be hard, bu=
t
>> so far I've only seen this raised once, by Jean-Tiare Le Bigot, also
>> from OVH.
>>
>> Currently, with no enforcement from librbd, this comes down to how b=
ig
>> RADOS object names can be, which depends on config options and even =
the
>> choice of the data store - in case of ext4, you wouldn't get ~4k, fo=
r
>> example.
>
> Honestly I don't think there's much need for anything legitimate
> beyond about 100 characters, but it is important to test the
> limits, whatever they are.

Agreed.

Thanks,

                Ilya
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
