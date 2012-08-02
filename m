From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RADOSGW internals ?
Date: Thu, 2 Aug 2012 07:23:36 -0700
Message-ID: <CAC-hyiG0HvPG_cf0495z_0UnPLeKt475PfQMW+ao-e_3y0yyyA@mail.gmail.com>
References: <CAF6-1L6Yu-eFnV0uytwNoYBj1W7=MGJvOHvEwve4fCXGQx==dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43974 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab2HBOXh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Aug 2012 10:23:37 -0400
Received: by bkwj10 with SMTP id j10so4277740bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 02 Aug 2012 07:23:36 -0700 (PDT)
In-Reply-To: <CAF6-1L6Yu-eFnV0uytwNoYBj1W7=MGJvOHvEwve4fCXGQx==dA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Aug 2, 2012 at 6:49 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
>
> Hi,
>
>
> Is there a document explaining how radosgw maps things to rados ?

I was actually working on such a document. There are some general
architectural blog posts in ceph.com, however, some may have been
obsolete by now.

>
> My situation is that I'm currently running various failure scenarios
> to see how to recover. One of them includes the complete loss of a
> placement group and in my case this lead into a weirdly inconsistent
> bucket. I could still add and get object from it, but I couldn't do
> list or delete ... ( tracing the error, the cls_head call was failing
> in rgw_rados ).

Will need logs in order to say what happened exactly, if that's of any
interest. You removed some crucial data for the full operation of that
bucket. It may also be that some of the data was still cached so that
you were able to complete some operations but not the others.

>
> I also tried starting from scratch by stopping radosgw and deleting
> all .rgw .rgw.control .rgw.buckets pools ... and when I restarted, a
> 's3 -u list' _still_ showed the previous buckets names ?!?

.rgw.buckets pool holds all the objects data by default.
.rgw holds all the buckets meta information, aka 'head' (e.g., bucket
acls, bucket instance id)
.rgw.control holds a notification object that is being used for cache control

the users bucket index itself is in .users.uid, where it is kept under
an object named <uid>.buckets.

Hope that helps,
Yehuda
