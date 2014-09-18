From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw-admin list users?
Date: Thu, 18 Sep 2014 10:38:19 -0700
Message-ID: <CABBk=J8bUPZLCxfJy5X9-X=oZzwZQW_ftvOR-=VFeLQpygx7aQ@mail.gmail.com>
References: <1464A418-AB3C-46C6-8D20-8FA796538A62@gmail.com>
	<robbat2-20140918T171125-842049841Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:61051 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaIRRiU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Sep 2014 13:38:20 -0400
Received: by mail-ig0-f180.google.com with SMTP id a13so1813936igq.1
        for <ceph-devel@vger.kernel.org>; Thu, 18 Sep 2014 10:38:19 -0700 (PDT)
In-Reply-To: <robbat2-20140918T171125-842049841Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 18, 2014 at 10:27 AM, Robin H. Johnson <robbat2@gentoo.org>=
 wrote:
> Related to this thread, radosgw-admin doesn't seem to have anything t=
o
> list the users.
>
> The closest I have as a hack is:
> rados ls --pool=3D.users.uid |sed 's,.buckets$,,g' |sort |uniq
>

Try:

$ radosgw-admin metadata list user

Yehuda

> But this does require internal knowledge of how it's stored, and I do=
n't
> want to rely on it.
>
> On Thu, Sep 18, 2014 at 03:53:27PM +0800,  Zhao zhiming wrote:
>> HI ALL,
>>       I know radosgw-admin can delete one user with command =E2=80=98=
radosgw-admin user rm uid=3Dxxx=E2=80=99, I want to know have some comm=
ands to delete multiple or all users?
>>
>> thanks. --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
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
