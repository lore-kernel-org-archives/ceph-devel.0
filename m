From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW and Keystone
Date: Tue, 4 Jun 2013 08:04:37 -0700
Message-ID: <CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com>
References: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:44486 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3FDPEj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 11:04:39 -0400
Received: by mail-vc0-f170.google.com with SMTP id hf12so257617vcb.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jun 2013 08:04:38 -0700 (PDT)
In-Reply-To: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chmouel Boudjnah <chmouel@enovance.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

(resending due to formatting)

I'm not Florian, but I think I can help here.

The radosgw user-tenant model is (currently) different from the swift
one. It's more like the S3 model, where users live in a single
namespace. So the current Swift user mapping is not perfect. We
created 'subusers' to emulate that, but in the end all accounts reside
under the same tenant (in the swift jargon).
That been said, I've prototyped a real multi-tenancy solution not too
long ago that will encapsulate both the swift and the S3 user cases
(wip-5073-2 for the brave ones). It might still be missing some
pieces, but most of it is there. I also have a new blueprint on my
to-do list.

Yehuda

On Tue, Jun 4, 2013 at 2:44 AM, Chmouel Boudjnah <chmouel@enovance.com> wrote:
> Hello Florian,
>
> I was wondering how the Keystone integration with ceph, I have been
> reading the documentation of the way it shows how to configure the
> keystone endpoints here :
>
> http://ceph.com/docs/next/radosgw/config/
>
> and I don't see how the part :
>
> keystone endpoint-create --service-id <id> --publicurl
> http://radosgw.example.com/swift/v1 \
>         --internalurl http://radosgw.example.com/swift/v1 --adminurl
> http://radosgw.example.com/swift/v1
>
> would work with multiple tenancies since user a or user b putting an
> object called bar in container foo would always end up with the same
> URL like :
>
> http://radosgw.example.com/swift/v1/foo/bar
>
> The way we do that in Swift is to have in keystone this type of URL :
>
>  --publicurl 'http://192.168.206.130:8888/v1/AUTH_%(tenant_id)s' \
>
> and the keystoneauth make sure the token validated match the
> %(tenant_id) in URL, i.e:
>
> https://github.com/openstack/swift/blob/master/swift/common/middleware/keystoneauth.py#L204
>
> am I totally off track or the keystone support support only a single tenant?
>
> digging into the code I don't see any trickeries to make this works
> properly it just check for the roles assigned to the user/tenant
> matching the configuration (which is good) but don't do much more
> after that :
>
> https://github.com/ceph/ceph/blob/master/src/rgw/rgw_swift.cc#L500
>
> Let me know what do you think.
>
> Cheers,
> Chmouel.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
