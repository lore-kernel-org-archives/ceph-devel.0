From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RGW Swift questions
Date: Thu, 14 Aug 2014 08:02:06 -0700
Message-ID: <CABBk=J9KxxYNeZNTpLbRRNbd0ApqdSojbh-f3R7iuuF=FvfoGQ@mail.gmail.com>
References: <53ECC736.2090202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:58511 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbaHNPCH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 11:02:07 -0400
Received: by mail-ig0-f170.google.com with SMTP id h3so14617486igd.5
        for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 08:02:06 -0700 (PDT)
In-Reply-To: <53ECC736.2090202@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Luis_Pab=C3=B3n?= <lpabon@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 14, 2014 at 7:27 AM, Luis Pab=C3=B3n <lpabon@redhat.com> wr=
ote:
>
> Hi Yehuda,
>     I am starting work on RGW and have a few questions:
>
> * Why is the command 'user create' when I am sending '--subuser'. See=
ms
> confusing.  Is there a reason why we are not to use 'subuser create'?

A subuser needs to have the containing user in order to be created.
The 'user create' command generates ones. The order of things would be
to create a user, then create a subuser for that user. By specifying
--subuser=3D.. on the user creation it should do both.

> * If I use "user create --subuser", the JSON returned shows the entry=
 for
> "subusers" is empty.  What is subusers for? (This is related to the p=
revious
> question)

So I assume the subuser wasn't created?
The rgw user model follows the S3 user model which is a bit different
from the swift one. In S3 there's basically a single tenant, multiple
users. With swift there are multiple tenants (originally referred to
as 'accounts'), each have different users that share a similar view of
the system (e.g., share list of containers, etc.). The more natural
(although not perfect) mapping is by having an rgw user map to a swift
account. That's why we needed to add a second level of identification,
the subuser.


> * Where do I place the OpenStack Tenant information?
The tenant id should be the user name.

> * Is there a document which describes how to setup RGW for OpenStack =
Swift?

Not that I'm aware of. Basically rgw is set to work with both S3 and
Swift out of the box. Here's how to integrate with keystone:
http://ceph.com/docs/master/radosgw/keystone/

> * The radosgw-admin help screen does not explain which options to use=
 for
> certain commands.  Is this something that we should fix?

We should certainly improve documentation. This can either go into the
man page, or a complete rework of the usage help.

> * On page: http://ceph.com/docs/master/radosgw/swift/auth/ , clicking=
 on
> "see radosgw-admin" does not work.

I opened issue #9116.


Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
