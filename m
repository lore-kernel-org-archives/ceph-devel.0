From: Luis Pabon <lpabon@redhat.com>
Subject: Re: RGW Swift questions
Date: Thu, 14 Aug 2014 12:00:20 -0400 (EDT)
Message-ID: <368555473.7277905.1408032020541.JavaMail.zimbra@redhat.com>
References: <53ECC736.2090202@redhat.com> <CABBk=J9KxxYNeZNTpLbRRNbd0ApqdSojbh-f3R7iuuF=FvfoGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:38425 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbaHNQAV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 12:00:21 -0400
In-Reply-To: <CABBk=J9KxxYNeZNTpLbRRNbd0ApqdSojbh-f3R7iuuF=FvfoGQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the quick turnaround Yehuda.  I have just a few more comment=
s below:

----- Original Message -----
=46rom: "Yehuda Sadeh" <yehuda@redhat.com>
To: "Luis Pab=C3=B3n" <lpabon@redhat.com>
Cc: ceph-devel@vger.kernel.org
Sent: Thursday, August 14, 2014 11:02:06 AM
Subject: Re: RGW Swift questions

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

[LP] Great, thank you

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

[LP] I will have to check why it is empty.


> * Where do I place the OpenStack Tenant information?
The tenant id should be the user name.

[LP] Cool, thanks. So if the tenant is the user name in RGW, what is th=
e Swift user
map to?

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
