From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Contribution
Date: Wed, 10 Jul 2013 09:08:56 -0700
Message-ID: <CABBk=J9UvLqtxgz2S=NXN6S=q2LdDQSrESxT2uRoC9hQCrjSKw@mail.gmail.com>
References: <CAA8043idUL1qbWfrBffhYXL8JX0LZ+WsMseUypatret7PrxBGw@mail.gmail.com>
	<CABBk=J9-hrMgGJ6ofvR0uuzX_gTfKJhH_TFCS4fR6m6gD=UBmg@mail.gmail.com>
	<CAA8043g_vkZvx_ErHZbF8eq12T2bvvXGWA_u=NRdwEWnmaqaug@mail.gmail.com>
	<CAA8043iF3GFwQLonGvCY=A=_mKWYX1zAXEYFFMJ1cyuw1ZOspw@mail.gmail.com>
	<CABBk=J812X6RKR0cBo1mPF2Xm4agHHJrRMjgqpOEn9uosBt6-Q@mail.gmail.com>
	<CAA8043gZQFHNONx1dQsOYUtBRN-khc0JaWd4LbMsRNuQn0=byA@mail.gmail.com>
	<CABBk=J_qLgOnCnn24j68CgK-rmv6+E68ox7taiLMcPgV=VDtcw@mail.gmail.com>
	<CAA8043jpFRc3M-+WpO=rqvGJUXF7-FyXk04bRFLemWYfDmnTBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:55977 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3GJQI5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 12:08:57 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so6074719vea.30
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 09:08:56 -0700 (PDT)
In-Reply-To: <CAA8043jpFRc3M-+WpO=rqvGJUXF7-FyXk04bRFLemWYfDmnTBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

On Wed, Jul 10, 2013 at 8:24 AM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
> Hi,
>
> Thanks for pointing out more tasks to me.
>
> I have lately worked on theses tasks.
>
> #Issue #1779:
>
> I updated this issue so it can be closed, as you told it does not need
> backporting.

Well, I pushed it to cuttlefish and we resolved the issue.

>
> Issue #3074:
>
> This one should be closed by now.

Done.

>
> Issue #5416:
>
> Now that radosgw also has --help supports, i would be able to add
> --rgw-zone and --rgw-region
> in help.
>
> Btw, should we had some help text near the options in help? If so,
> what should it be?

--rgw-region specifies the region in which the radosgw instance will run
--rgw-zone specifies the zone in which the radosgw instance will run

>
> Issue #5374:
>
> I updated my pull request as you commented on it.
> It now uses JSONFormatter to create the JSON data.

I'll take a look.

>
> S3 Keystone Issue #5506:
>
> I got the main idea about this issue. But i'm lacking documentation on
> how keystone
> authenticate user with S3 credentials. Do you have any link on documentation?

Nope. I had to dig quite a bit in order to get that working. In
essence, you'd need to add ec2 keys, and use these somehow with S3
authentication.

>
> temp URLs:
>
> I've been looking at the code of rgw_rest_s3.cc.
> Does the S3 temp url implementation relies in this file, in the
> RGW_Auth_S3::authorize method?

Yes, it's just part of the regular auth, just takes a different path
(uses the request params data instead of the relevant http headers).

>
> Issue #4365:
>
> As i asked on the issue, should we had wilcard support in role
> definition ('*-service', 'adm-*', etc.) or a generic wildcard role,
> which one allows any role from keystone? If so, how sould we define it?
> (option, '*' role name, other?)

I'd say we can have a simple wildcard support. The '*' symbol would be
used, and it could either be used as a catch-all ("*"), or to specify
a prefix ("foo*"), or a suffix ("*bar").

Thanks,
Yehuda
