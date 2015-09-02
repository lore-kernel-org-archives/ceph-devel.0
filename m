From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Multi-tenancy in radosgw
Date: Wed, 2 Sep 2015 11:35:19 -0600
Message-ID: <20150902113519.50a2a8b5@guren.zaitcev.lan>
References: <CA+H5UW2=yzXfRcuRHDW99b80GjuhUaqihkAYUV_fnUj-PXhXKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59147 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbbIBRfV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 2 Sep 2015 13:35:21 -0400
In-Reply-To: <CA+H5UW2=yzXfRcuRHDW99b80GjuhUaqihkAYUV_fnUj-PXhXKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, zaitcev@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Sep 2015 14:23:33 +0200
Radoslaw Zarzynski <rzarzynski@mirantis.com> wrote:

> What is the current status of multi-tenancy support in radosgw?
> I saw branch wip-ymt-5073 which looks really nice.

That branch is actually an clone of wip-5073-3, only I made it build on the
current code (about 9.0.2 level) and pass "make check". I also streamlined
a couple of things, like the confusing maze of assignments between tenant
and user_id.tenant in radosgw-admin (rgw_admin.cc). Oh, and we settled on
using '/' as the syntax separator for buckets in tenant namespace. The
original wip-5073-3 have not yet come to that decision.

> What is missing? What do we need to implement?
> I guess I would have time to help with this.

Well... In theory everything is in place. In practice, nothing works. :-)
If you want to create buckets within a non-default tenant, you have to
have a user sited under a non-default tenant. But if you try to create
one, this happens:

$ LD_LIBRARY_PATH=/q/zaitcev/ceph/ceph-tip/src/.libs /q/zaitcev/ceph/ceph-tip/src/.libs/radosgw-admin  user create --tenant=prodtx --uid=prodt --subuser=prodt:prod1 --display-name="Prod Tenant T" --key-type=swift --access=full --email=prodt@zaitcev.lan
{
    "user_id": "prodtx:prodt",
    "display_name": "Prod Tenant T",
    "email": "prodt@zaitcev.lan",
    "suspended": 0,
    "max_buckets": 1000,   
    "auid": 0,
    "subusers": [
        {
            "id": "prodtx:prodt:prod1",
            "permissions": "full-control"
        }
    ],
    "swift_keys": [
        {
            "user": "prodtx:prodt:prod1",
            "secret_key": "rfJdJIDxCypUVgld2OUPpjgOUQ6R2UycHpqxuQyP"
        }
    ],
.................
}

As you can see, tenant leaks _everywhere_. It's a real pest.
In addition, Yehuda chose to use a struct rgw_user as a vehicle to carry
the tenant. That has important advantages, the biggest being that you
let gcc to point out all the place where conversion may be needed.
However, per above the serialization into JSON relies onto to_str(),
and then you cannot tell if there's actually a tenant field set
correctly in RGWUserInfo or it's just a colon leaked into user.

As far as where you are best to apply, I honestly have no clue.
This is not easy to decompose further into tasks. Maybe you could
just take over :-)

-- Pete
