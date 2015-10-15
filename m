From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph/osd_client: add support for CEPH_OSD_OP_GETXATTR
Date: Thu, 15 Oct 2015 11:21:20 +0200
Message-ID: <CAOi1vP9mM4FcgFDOCQyw-OoQELPJQK26EtRwkNYg5J7u17No5g@mail.gmail.com>
References: <1444401789-17396-1-git-send-email-ddiss@suse.de>
	<1444401789-17396-2-git-send-email-ddiss@suse.de>
	<20151014193740.40e7238f@plati.site>
	<CAOi1vP8V7xX0zT+npnNz=EDhVfGdABZvetbdjngDadRpatMZoQ@mail.gmail.com>
	<20151015005150.6bd85b48@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38755 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbbJOJVV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 05:21:21 -0400
Received: by wicll6 with SMTP id ll6so9510457wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 02:21:20 -0700 (PDT)
In-Reply-To: <20151015005150.6bd85b48@plati.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>, Josh Durgin <jdurgin@redhat.com>

On Thu, Oct 15, 2015 at 12:51 AM, David Disseldorp <ddiss@suse.de> wrote:
> On Wed, 14 Oct 2015 19:57:46 +0200, Ilya Dryomov wrote:
>
>> On Wed, Oct 14, 2015 at 7:37 PM, David Disseldorp <ddiss@suse.de> wrote:
> ...
>> > Ping, any feedback on the patch?
>>
>> The patch itself looks OK, except for the part where you rename a local
>> variable for no reason, AFACT.
>
> Thanks for the feedback Ilya. I presume you're referring to the pagelist
> -> req_pagelist rename - I'll drop that change and send an update.

Also, the prefix for net/ceph patches is libceph.

>
>> We've discussed some of this last week.  As it is, all rbd image
>> properties are stored in omap, so PR info strings stored in xattrs is
>> something different, but it should be fine for now.  I'd rather not
>> merge any kernel patches related to rbd-target work until we see
>> a complete patchset though.  There's been a lot of back and forth
>> between Mike, Christoph and target people and the general approach had
>> changed at least twice, so I'd like to wait for things to settle down.
>
> I understand the desire to wait on any RBD-target changes until upstream
> consensus has been reached, but I'd argue that this change is isolated,
> and complementary to the existing SETXATTR / CMPXATTR support.

That's true, but we already have a bunch of unused code in net/ceph,
which was added using precisely this reasoning, so I'm a bit hesitant.

Thanks,

                Ilya
