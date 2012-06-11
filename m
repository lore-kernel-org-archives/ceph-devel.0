From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw-admin: mildly confusing man page and usage message
Date: Mon, 11 Jun 2012 14:39:37 -0700
Message-ID: <CAC-hyiHRR9dvtniK47L9aF9dWbUB8KLqNi0a7wdU9gb_Ka140w@mail.gmail.com>
References: <4FD664BA.6040801@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60796 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab2FKVji convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 17:39:38 -0400
Received: by bkcji2 with SMTP id ji2so3952789bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 14:39:37 -0700 (PDT)
In-Reply-To: <4FD664BA.6040801@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 11, 2012 at 2:35 PM, Florian Haas <florian@hastexo.com> wro=
te:
> Hi,
>
> just noticed that radosgw-admin comes with a bit of confusing content=
 in
> its man page and usage message:
>
> EXAMPLES
> =A0 =A0 =A0 Generate a new user:
>
> =A0 =A0 =A0 $ radosgw-admin user gen --display-name=3D"johnny rotten"
> --email=3Djohnny@rotten.com
>
> As far as I remember "user gen" is gone, and it's now "user create".
> However:
>
> radosgw-admin user create --display-name=3D"test" --email=3Dtest@demo
> user_id was not specified, aborting
>
> ... is followed by a usage message that doesn't mention user_id anywh=
ere
> (the option string is --uid). So conceivably the example could also u=
se
> a mention of --uid.
>
> Also, is there a way to retrieve the "next available" user_id or just
> tell radosgw-admin to use max(user_id)+1?
>
> If one of the Ceph guys could provide a quick comment on this, I can
> send a patch to the man page RST. Thanks.
>

Minimum required to create a user:

radosgw-admin user create --uid=3D<user id> --display-name=3D<display n=
ame>

The user id is actually a user 'account' name, not necessarily a
numeric value. The email param is optional.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
