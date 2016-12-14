From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Cinder doesn't work with the current rados python bindings
Date: Tue, 13 Dec 2016 16:26:06 -0800
Message-ID: <CA+hcxJTdOZm6anLdOofyqRnmO76=jpamz9FNiSG8x_sH-bBQbw@mail.gmail.com>
References: <CA+hcxJS_wKucTUetNxPrHTn2j0V6vDUjCwKUTxp176xoCmSmVw@mail.gmail.com>
 <CA+aFP1Bz_=HPVnJTJa29NJMmvzX7_gSA3EEB2n5VZLctBU4tKA@mail.gmail.com>
 <CA+hcxJTBWk0VXYBdL7zLxWJTU6VfrT8RWL7W3e53ycHYUwqXyQ@mail.gmail.com> <CA+aFP1BnR-U_gFAR8zbgh3AnEk-SaLU1ucDA9AD5gu-t_UwxnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35546 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbcLNA00 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 19:26:26 -0500
Received: by mail-vk0-f51.google.com with SMTP id w194so5315947vkw.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 16:26:07 -0800 (PST)
In-Reply-To: <CA+aFP1BnR-U_gFAR8zbgh3AnEk-SaLU1ucDA9AD5gu-t_UwxnA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I see. Thank you.

On Tue, Dec 13, 2016 at 4:24 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> I actually already opened a ticket for this [1] and started to fix it
> since I would consider this a release blocker for Kraken.
>
> [1] http://tracker.ceph.com/issues/18247
>
> On Tue, Dec 13, 2016 at 7:10 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Yes. This is exactly the line I mean.
>> Is there any chance I can do it myself?
>> What kind of change is required?
>> I can unblock the cinder guy as well as contribute.
>> Let me know if I can be useful.
>>
>> Thanks.
>> V.
>>
>> On Tue, Dec 13, 2016 at 1:38 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> Are you referring to rbd_default_features [1]? If so, that was a
>>> change with unintentional consequences in the master branch that I
>>> will need to fix before the final Kraken release.
>>>
>>> [1] https://github.com/openstack/cinder/blob/9fcb3bf1ad00913654872858d0cec839a6a2f0c8/cinder/volume/drivers/rbd.py#L152
>>>
>>> On Tue, Dec 13, 2016 at 3:29 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> Hello,
>>>>
>>>> Who knows where pybind/rados/rados.pyx came from?
>>>> I talked to a guy in the cinder development team - he tried to build
>>>> his code against the latest python bindings from master.
>>>> It looks like the api's changed. Rados.conf_get('features') used to
>>>> return an integer.
>>>> It returns a string right now.
>>>>
>>>> I looked into the git history and I see that pybind.pyx has been where
>>>> it's right now only since February this year. I presume cinder's using
>>>> an older version.
>>>>
>>>> Can someone advise me on how I can track down the changes in python bindings.
>>>>
>>>> Thank you in advance.
>>>>
>>>> Victor.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
