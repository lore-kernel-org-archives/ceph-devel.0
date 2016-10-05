From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: boost submodule update
Date: Wed, 5 Oct 2016 11:23:20 -0600
Message-ID: <CALqRxCz0rH+DNmb3M0MCuz9pYd8S=WtgAHx5QjaXCAfunwrsfg@mail.gmail.com>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
 <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com> <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:33176 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754187AbcJERXW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Oct 2016 13:23:22 -0400
Received: by mail-ua0-f179.google.com with SMTP id p102so45382861uap.0
        for <ceph-devel@vger.kernel.org>; Wed, 05 Oct 2016 10:23:22 -0700 (PDT)
In-Reply-To: <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Matt,

I'm not following? You're doubtful that what will arise?

- Ken

On Fri, Sep 30, 2016 at 6:42 AM, Matt Benjamin <mbenjamin@redhat.com> wrote:
> Hi Ken,
>
> I'm doubtful that case will arise in practice?
>
> Matt
>
> ----- Original Message -----
>> From: "Ken Dreyer" <kdreyer@redhat.com>
>> To: "Sage Weil" <sweil@redhat.com>
>> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Thursday, September 29, 2016 6:42:48 PM
>> Subject: Re: boost submodule update
>>
>> On Thu, Sep 29, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
>> >  * There is still the option to use a system boost via a cmake option.  I
>> > doubt anyone will opt for this in practice given the distros tend to lag,
>> > but they can if they want.
>>
>> Can we have it automatically enable the system boost if it's > 1.6.1?
>> Otherwise I'm afraid no one will set WITH_SYSTEM_BOOST :)
>>
>> Fedora 26 or 27 will probably have Boost 1.6.2+
>> (https://bugzilla.redhat.com/1374088)
>>
>> - Ken
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
