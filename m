From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] rbd: finish up basic format 2 support
Date: Wed, 10 Oct 2012 09:29:00 -0700
Message-ID: <5075A24C.1080008@inktank.com>
References: <50748FA5.4030508@inktank.com> <20121010165510.fc07422a.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34933 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab2JJQ3C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 12:29:02 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so779608pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Oct 2012 09:29:02 -0700 (PDT)
In-Reply-To: <20121010165510.fc07422a.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8gTWFydGlucw==?= <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org, elder@inktank.com

On 10/10/2012 08:55 AM, Cl=C3=A1udio Martins wrote:
>
> On Tue, 09 Oct 2012 13:57:09 -0700 Alex Elder <elder@inktank.com> wro=
te:
>> This series includes updates for two patches posted previously.
>>
>> 					-Alex
>
>   Greetings,
>
>   We're gearing up to test v0.52 (specifically the RBD stuff) on our
> cluster. After reading this series of posts about rbd format 2 patche=
s
> I began wondering if we should start testing these patches as well or
> not. To put it simply, what I'd like to know is:
>
>   Is it enough to use the 3.6 vanilla kernel client to take full
> advantage of the rbd changes in v0.52 (i.e. new RBD cloning features)=
?
>
>   Do we have any benefits from applying any of these patches on top o=
f
> v3.6 and using "format 2", assuming that we stick to v0.52 on the
> server, or is this strictly v0.53 and beyond stuff?
>
>
>   I apologize if this is a dumb question, but by looking at the v0.52
> changelog, at doc/rbd/* and the list, it doesn't seem clear how this
> fits with v0.52.
>
>   Thanks in advance
>
> Best regards
>
> Cl=C3=A1udio

These patches support using format 2, to make adding new features
easy, but this is not very useful to you yet. They don't yet support
any new features (like cloning) - that's the next step, but it will
take a bunch more work.

To use rbd cloning, you'll need to access rbd through userspace (e.g.
with qemu and librbd) for now.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
