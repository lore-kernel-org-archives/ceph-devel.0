From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: Snapshots of consistency groups
Date: Tue, 1 Nov 2016 11:01:45 -0400
Message-ID: <CA+aFP1D46xgNffUux5cGKeg2cJQeQ4nWh+_wgLgVystL74HhGg@mail.gmail.com>
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
 <CA+hcxJS-3Y-3QTgpU1NwQmg8znrg5Jo+jHH9f7T5n7x_+NcvyQ@mail.gmail.com>
 <CA+aFP1A4YYDG0HSJ52R__DPKBc_Y7p62Ec4tzhdXt+UPkC=vNw@mail.gmail.com>
 <CA+hcxJR6S8AZQ0mY5MTKiBwjf0bQYswWoL16WBJgfrOzzQ40zg@mail.gmail.com>
 <CA+hcxJS4JDHBc-GYqwjXjHTiVBeq_YZhcvRfG5SRZMhTGZt-FA@mail.gmail.com>
 <CA+aFP1Dg0Tc8CDumoL7hJPD62itu+RqZaKcjnuEnvZwrHdZZ=w@mail.gmail.com>
 <CA+hcxJQC1eJLRYxDMD1_XDsD5vKtvcVXyxQwM-OuSEmNTXnHRg@mail.gmail.com> <CA+aFP1ARgWp71xgqicF6vgx6Rd6kzYd-2mn1WPD9XtpQfO75=w@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33231 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966636AbcKAPBr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Nov 2016 11:01:47 -0400
Received: by mail-lf0-f44.google.com with SMTP id c13so21658462lfg.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Nov 2016 08:01:47 -0700 (PDT)
In-Reply-To: <CA+aFP1ARgWp71xgqicF6vgx6Rd6kzYd-2mn1WPD9XtpQfO75=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman <dillaman@redhat.com>
Cc: Victor Denisov <vdenisov@mirantis.com>, Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

I chatted with Xing on IRC this morning re: Cinder generic groups. It
sounds like RBD will need to support preserving the image's
consistency group snapshots even if the image is removed from the
group. In the OpenStack case, you won't have to worry about the image
being deleted while it still has associated group snapshots.

We will also want to support being able to clone child images from a
group snapshot to ensure that we can thin provision new groups volumes
when creating a new group from a group snapshot. This means that the
group snapshots should be able to be protected/unprotected just like
standard user snapshots.

On Mon, Oct 31, 2016 at 9:07 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> Looking at the Cinder codebase, I don't see any such restriction that
> would prevent you from removing a volume from a consistency group that
> has associated snapshots. I would double-check on the OpenStack
> development mailing list if this is correct and is the intent. Worst
> case, the RBD driver could raise an exception if there are still
> consistency group snapshots associated to the image.
>
>
> On Fri, Oct 28, 2016 at 6:41 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Another thing that bothers me. When we remove an image from a consistency group.
>> Should we remove all snapshots of this image that were created as part
>> of a consistency group snapshot?
>>
>> The easiest solution would be to remove all snapshots that are in
>> GroupSnapshotNamespace and reference this consistency group.
>> I looked into cinder docs for this feature:
>> http://docs.openstack.org/admin-guide/blockstorage-consistency-groups.html
>>
>> But it's not clear to me which behavior cinder expects.
>>
>> Thanks,
>> V.
>>
>> On Wed, Oct 26, 2016 at 6:16 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> In a perfect world, it would be nice to add a new optional to "rbd
>>> snap ls" to show all snapshots (with a new column to indicate the
>>> associated namespace).
>>>
>>> On Tue, Oct 25, 2016 at 11:07 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> Question. When we print out snapshots of an image, should the group
>>>> snapshots be listed, or should they be marked as special snapshots?
>>>>
>>>> Thanks,
>>>> V.
>>>>
>>>> On Mon, Oct 10, 2016 at 3:14 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>> Ok. I didn't have any intention to throw exceptions.
>>>>> I was more concerned about whether it's ok to allocate and delete
>>>>> objects or I should use smart pointers.
>>>>>
>>>>> On Mon, Oct 10, 2016 at 7:18 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>>> The only place exceptions are routinely used is within the "::decode"
>>>>>> functions. I would prefer to see the code not throwing new exceptions
>>>>>> on purpose.
>>>>>>
>>>>>> On Fri, Oct 7, 2016 at 2:26 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>> Are any exceptions used in librbd code? Should the code be exception safe?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> V.
>>>>>>>
>>>>>>> On Fri, Sep 16, 2016 at 10:37 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>>>>> On Thu, Sep 15, 2016 at 7:17 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>>>> if (struct_v >= 5) {
>>>>>>>>>       ::decode(snapshot_namespace, p);
>>>>>>>>>     } else {
>>>>>>>>>       snapshot_namespace = cls::rbd::UserSnapshotNamespace();
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>> then code for ::encode function of cls_rbd_snap would change accordingly:
>>>>>>>>>
>>>>>>>>> instead of
>>>>>>>>>
>>>>>>>>> boost::apply_visitor(cls::rbd::EncodeSnapshotTypeVisitor(bl),
>>>>>>>>> snapshot_namespace);
>>>>>>>>>
>>>>>>>>> I would do:
>>>>>>>>> ::encode(snapshot_namespace, bl);
>>>>>>>>
>>>>>>>>
>>>>>>>> +1 -- looks good to me
>>>>>>>>
>>>>>>>> --
>>>>>>>> Jason
>>>>>>
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Jason
>>>
>>>
>>>
>>> --
>>> Jason
>
>
>
> --
> Jason



-- 
Jason
