From: Chmouel Boudjnah <chmouel@enovance.com>
Subject: Re: RGW and Keystone
Date: Tue, 4 Jun 2013 18:39:43 +0200
Message-ID: <C0B54484-F2D6-4FE3-87A4-F06C2B20903E@enovance.com>
References: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com> <CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:63882 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab3FDQjp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 12:39:45 -0400
In-Reply-To: <CABBk=J-GB3U7HSjdmsHF9xWUGwi4QkO-57SjjNnORWUJ07oJ1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, dev <dev@enovance.com>

Hello Yehuda,

Sorry this was actually directed to you (florian actually told me you were the go to person for row).

I am not totally familiar with s3  how does a single namespace ensure a accounts/user don't have access to the resource of the others ?

Glad to know you are tackling the multi-tenancy for swift/s3, let me know if i can help for reviews.

Thanks,
Chmouel.


On 4 Jun 2013, at 17:04, Yehuda Sadeh <yehuda@inktank.com> wrote:

> (resending due to formatting)
> 
> I'm not Florian, but I think I can help here.
> 
> The radosgw user-tenant model is (currently) different from the swift
> one. It's more like the S3 model, where users live in a single
> namespace. So the current Swift user mapping is not perfect. We
> created 'subusers' to emulate that, but in the end all accounts reside
> under the same tenant (in the swift jargon).
> That been said, I've prototyped a real multi-tenancy solution not too
> long ago that will encapsulate both the swift and the S3 user cases
> (wip-5073-2 for the brave ones). It might still be missing some
> pieces, but most of it is there. I also have a new blueprint on my
> to-do list.
> 
> Yehuda
> 
> On Tue, Jun 4, 2013 at 2:44 AM, Chmouel Boudjnah <chmouel@enovance.com> wrote:
>> Hello Florian,
>> 
>> I was wondering how the Keystone integration with ceph, I have been
>> reading the documentation of the way it shows how to configure the
>> keystone endpoints here :
>> 
>> http://ceph.com/docs/next/radosgw/config/
>> 
>> and I don't see how the part :
>> 
>> keystone endpoint-create --service-id <id> --publicurl
>> http://radosgw.example.com/swift/v1 \
>>        --internalurl http://radosgw.example.com/swift/v1 --adminurl
>> http://radosgw.example.com/swift/v1
>> 
>> would work with multiple tenancies since user a or user b putting an
>> object called bar in container foo would always end up with the same
>> URL like :
>> 
>> http://radosgw.example.com/swift/v1/foo/bar
>> 
>> The way we do that in Swift is to have in keystone this type of URL :
>> 
>> --publicurl 'http://192.168.206.130:8888/v1/AUTH_%(tenant_id)s' \
>> 
>> and the keystoneauth make sure the token validated match the
>> %(tenant_id) in URL, i.e:
>> 
>> https://github.com/openstack/swift/blob/master/swift/common/middleware/keystoneauth.py#L204
>> 
>> am I totally off track or the keystone support support only a single tenant?
>> 
>> digging into the code I don't see any trickeries to make this works
>> properly it just check for the roles assigned to the user/tenant
>> matching the configuration (which is good) but don't do much more
>> after that :
>> 
>> https://github.com/ceph/ceph/blob/master/src/rgw/rgw_swift.cc#L500
>> 
>> Let me know what do you think.
>> 
>> Cheers,
>> Chmouel.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

