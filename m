From: John Spray <jspray@redhat.com>
Subject: Re: Broken links in Ceph documentation
Date: Thu, 23 Mar 2017 08:24:29 -0400
Message-ID: <CALe9h7eSYZGApxFmg5g7Y6Cqc9j5HXsf+LnHVpxU1Z1fmmdf-g@mail.gmail.com>
References: <CACKY0b8-rq-R0Sun9Mxfk3ogtA-YMF26HMWUJj0xEZ__9_Z9YQ@mail.gmail.com>
 <CAJE9aONJQ7nAO3m+z8zyx_7qnkacU_cHPQcUMWq-5QLrA80xjQ@mail.gmail.com>
 <CACKY0b8y8CFXGJEcHqjM8D+XRSBKs4Ag5k01QWwpY78ZjjU4Dw@mail.gmail.com>
 <CAJE9aONcAndHg-TXjzWyaS=i=xw+X7uX4kRMw=PLKjUjsjXUvg@mail.gmail.com> <a81ccd21-715c-adc8-2e2f-1797a4147a18@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37087 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754043AbdCWMYw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 08:24:52 -0400
Received: by mail-wm0-f52.google.com with SMTP id n11so61246165wma.0
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 05:24:51 -0700 (PDT)
In-Reply-To: <a81ccd21-715c-adc8-2e2f-1797a4147a18@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: kefu chai <tchaikov@gmail.com>, liuchang0812 <liuchang0812@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 23, 2017 at 8:21 AM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> BTW, there are a lot of `http://github.com/ceph/ceph/pull/xxxx` links.
>>> It should be `https://github.com/ceph/ceph/pull/xxx` in our
>>> ReleaseNotes.rst
>>
>>
>> they are redirected to https://github.com/ceph/ceph/pull/xyz, so i
>> guess it's fine?
>
>
> "git clone http://github.com/ceph/ceph" also works fine.
>
> Also, I am not aware of any security risk that is addressed by using SSL.
> Ceph is FLOSS, after all. Why encrypt the HTTP traffic?

The point of HTTPS in this context is not to keep the code a secret,
but to prevent modification in flight.

If you pull http:// code then your government can easily modify it in
flight to implant whatever they want.

John

>
> Nathan
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
