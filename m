From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Snapshots of consistency groups
Date: Mon, 10 Oct 2016 15:14:43 -0700
Message-ID: <CA+hcxJR6S8AZQ0mY5MTKiBwjf0bQYswWoL16WBJgfrOzzQ40zg@mail.gmail.com>
References: <CA+hcxJS8sbBUjYieM3+86XG5KX9ouP8dO+9iFwtsHoO+v=9KWA@mail.gmail.com>
 <CA+aFP1BAw7yzPYT5z6D6Wq6tPvd-Y9meDxfgqcVi0GBg0eR3+g@mail.gmail.com>
 <CA+aFP1BZPHhiBan4r5N7x0LfHofmkrUWgLPD0MrS-uV6WrF4Kg@mail.gmail.com>
 <CA+hcxJSO8TXSRV4bgTZVkrFsjX1wpW3DYFKqaDnWhA3+7gE_eg@mail.gmail.com>
 <CA+aFP1BMK1=daZpUFdNDJ+i8+nfQt42ahCXVaxy9fWdAY-kXwA@mail.gmail.com>
 <CA+hcxJT9JdVz-ZQz_SXwAPbbHoNegNSVfPk6h8kzmDo0xs0BJQ@mail.gmail.com>
 <20160819124813.GB17630@gmail.com> <CA+hcxJQs_t2u5PWiJNzJO1LPdH3HAh21VoB63w5pOdWk0+ih1Q@mail.gmail.com>
 <20160820162713.GA5997@gmail.com> <CA+hcxJTwVEJz5__s6pqivUN61X0xCccKHJ=0_o+1g8+Zu+wkDQ@mail.gmail.com>
 <CA+aFP1CqjyTVpzJNLiyuEg8ydOh_vXjF2ESFjwqESY6O7NhVfA@mail.gmail.com>
 <CA+hcxJQ1RBKbHam8tq2KL=pphLEmtvvacjD1qUvvpqs8NgkCcA@mail.gmail.com>
 <CA+hcxJQ80g_aROrb0+AVaXij1w_pqwRCxC+cHF7j+gXfGyW=Rw@mail.gmail.com>
 <CA+aFP1Dkv_vMMxfnyOE3MfaFP4CV=Z0atT-=bDTjSrRx-quNSw@mail.gmail.com>
 <CA+hcxJTxfT1BO5uuXARsUo8oyHwQxJgymzUTAM8KV1=ciJG20w@mail.gmail.com>
 <CA+aFP1BY67WbVWT-Wb3fHsS_-jUJBJ4FM3NO3VsqFO9+iRGNRg@mail.gmail.com>
 <CA+hcxJRbmnfUeZbnCkvZf52-0H_Du0tGeFb=h_GJryabv0Ng8A@mail.gmail.com>
 <CA+hcxJRptWbrh5R5v5s1YjD-1wuDLUmbGoF6+J=sv+BnrnAzWg@mail.gmail.com>
 <CA+hcxJROQ-xkxNpn5-SZo5abShntVu_mSUhX7ZwmCGuM+6PLVg@mail.gmail.com>
 <CA+aFP1A9-XcxZK---L8iYLVgKUR2ULzHrAVp9=fGbrDaQd3Zyw@mail.gmail.com>
 <CA+hcxJSQdxjxjeVy47AWMJ_-bVRh9NjcHr0h-FkHkJgymCrfUw@mail.gmail.com>
 <CA+hcxJQm4Z+ODFZbf_4Z9uNOez+amgA1bxLcAQtM5HVo7Qq_pw@mail.gmail.com>
 <CA+aFP1ABzFvX8HUyQBm4eFyAPDv7K5Qo7NyGogeHuuAaoLqNNw@mail.gmail.com>
 <CA+hcxJS-3Y-3QTgpU1NwQmg8znrg5Jo+jHH9f7T5n7x_+NcvyQ@mail.gmail.com> <CA+aFP1A4YYDG0HSJ52R__DPKBc_Y7p62Ec4tzhdXt+UPkC=vNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:33354 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752245AbcJJWOp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 18:14:45 -0400
Received: by mail-yw0-f178.google.com with SMTP id t192so2053878ywf.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Oct 2016 15:14:44 -0700 (PDT)
In-Reply-To: <CA+aFP1A4YYDG0HSJ52R__DPKBc_Y7p62Ec4tzhdXt+UPkC=vNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

Ok. I didn't have any intention to throw exceptions.
I was more concerned about whether it's ok to allocate and delete
objects or I should use smart pointers.

On Mon, Oct 10, 2016 at 7:18 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> The only place exceptions are routinely used is within the "::decode"
> functions. I would prefer to see the code not throwing new exceptions
> on purpose.
>
> On Fri, Oct 7, 2016 at 2:26 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Are any exceptions used in librbd code? Should the code be exception safe?
>>
>> Thanks,
>> V.
>>
>> On Fri, Sep 16, 2016 at 10:37 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> On Thu, Sep 15, 2016 at 7:17 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> if (struct_v >= 5) {
>>>>       ::decode(snapshot_namespace, p);
>>>>     } else {
>>>>       snapshot_namespace = cls::rbd::UserSnapshotNamespace();
>>>>     }
>>>>
>>>> then code for ::encode function of cls_rbd_snap would change accordingly:
>>>>
>>>> instead of
>>>>
>>>> boost::apply_visitor(cls::rbd::EncodeSnapshotTypeVisitor(bl),
>>>> snapshot_namespace);
>>>>
>>>> I would do:
>>>> ::encode(snapshot_namespace, bl);
>>>
>>>
>>> +1 -- looks good to me
>>>
>>> --
>>> Jason
>
>
>
> --
> Jason
