From: Zhao zhiming <zhaozhiming003@gmail.com>
Subject: Re: radosgw-admin list users?
Date: Fri, 19 Sep 2014 10:35:58 +0800
Message-ID: <FD7981E0-88DA-4E62-A279-B4046E5341D2@gmail.com>
References: <1464A418-AB3C-46C6-8D20-8FA796538A62@gmail.com> <robbat2-20140918T171125-842049841Z@orbis-terrarum.net> <CABBk=J8bUPZLCxfJy5X9-X=oZzwZQW_ftvOR-=VFeLQpygx7aQ@mail.gmail.com> <robbat2-20140918T195955-487876044Z@orbis-terrarum.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46567 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaISCgK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 22:36:10 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so2845840pab.4
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 19:36:09 -0700 (PDT)
In-Reply-To: <robbat2-20140918T195955-487876044Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Robin and Yehuda, but I want to how to delete multiple users.

I use 'radosgw-admin metadata list user=92 to list all users, and found=
 some users have unreadable code.

radosgw-admin metadata list user
[
    "zzm1",
    "?zzm1",
    "?zzm1=94]

and I can=92t delete these unreadable users.

radosgw-admin user rm =97uid=3D"?zzm1"
could not remove user: unable to remove user, user does not exist

so I want to know, do rgw admin have command to delete multiply or all =
users?

Thanks.

On Sep 19, 2014, at 4:01 AM, Robin H. Johnson <robbat2@gentoo.org> wrot=
e:

> On Thu, Sep 18, 2014 at 10:38:19AM -0700,  Yehuda Sadeh wrote:
>> On Thu, Sep 18, 2014 at 10:27 AM, Robin H. Johnson <robbat2@gentoo.o=
rg> wrote:
>>> Related to this thread, radosgw-admin doesn't seem to have anything=
 to
>>> list the users.
>>>=20
>>> The closest I have as a hack is:
>>> rados ls --pool=3D.users.uid |sed 's,.buckets$,,g' |sort |uniq
>>>=20
>>=20
>> Try:
>>=20
>> $ radosgw-admin metadata list user
> Ooh nice!
> Nothing in the --help output says 'metadata list' takes arguments (an=
d
> the manpage for radosgw-admin doesn't even have the metadata commands=
).
>=20
> --=20
> Robin Hugh Johnson
> Gentoo Linux: Developer, Infrastructure Lead
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
