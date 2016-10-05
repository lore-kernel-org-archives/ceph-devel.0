From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: boost submodule update
Date: Wed, 5 Oct 2016 12:31:48 +1000
Message-ID: <20161005023148.GC6047@rskikr.localdomain>
References: <alpine.DEB.2.11.1609291550010.19850@piezo.us.to>
 <CALqRxCzEXgA57EEty2j3vUrt9fm=eY8tTVYT4iy_p8Ad-rVfLw@mail.gmail.com>
 <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33550 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbcJECb5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Oct 2016 22:31:57 -0400
Received: by mail-pa0-f41.google.com with SMTP id cd13so75435050pac.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Oct 2016 19:31:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <761939168.1814833.1475239348666.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjamin@redhat.com>
Cc: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I acknowledge what Sage says about most of boost being header only but I still
feel compelled to offer some input here.

https://www.akkadia.org/drepper/no_static_linking.html
https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7-Beta/html-single/Developer_Guide/index.html#lib.compatibility.static

I guess we are aware of these pain points and have decided "it's worth it"?

-- 
Cheers,
Brad

On Fri, Sep 30, 2016 at 10:42 PM, Matt Benjamin <mbenjamin@redhat.com> wrote:
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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


