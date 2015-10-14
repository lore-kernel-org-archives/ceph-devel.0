From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph/osd_client: add support for CEPH_OSD_OP_GETXATTR
Date: Wed, 14 Oct 2015 19:57:46 +0200
Message-ID: <CAOi1vP8V7xX0zT+npnNz=EDhVfGdABZvetbdjngDadRpatMZoQ@mail.gmail.com>
References: <1444401789-17396-1-git-send-email-ddiss@suse.de>
	<1444401789-17396-2-git-send-email-ddiss@suse.de>
	<20151014193740.40e7238f@plati.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35964 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182AbbJNR5t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Oct 2015 13:57:49 -0400
Received: by wicgb1 with SMTP id gb1so240973488wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2015 10:57:47 -0700 (PDT)
In-Reply-To: <20151014193740.40e7238f@plati.site>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Mike Christie <mchristi@redhat.com>, Josh Durgin <jdurgin@redhat.com>

On Wed, Oct 14, 2015 at 7:37 PM, David Disseldorp <ddiss@suse.de> wrote:
> On Fri,  9 Oct 2015 16:43:09 +0200, David Disseldorp wrote:
>
>> Allows for xattr retrieval. Response data buffer allocation is the
>> responsibility of the osd_req_op_xattr_init() caller.
>
> Ping, any feedback on the patch?

The patch itself looks OK, except for the part where you rename a local
variable for no reason, AFACT.

We've discussed some of this last week.  As it is, all rbd image
properties are stored in omap, so PR info strings stored in xattrs is
something different, but it should be fine for now.  I'd rather not
merge any kernel patches related to rbd-target work until we see
a complete patchset though.  There's been a lot of back and forth
between Mike, Christoph and target people and the general approach had
changed at least twice, so I'd like to wait for things to settle down.

Thanks,

                Ilya
