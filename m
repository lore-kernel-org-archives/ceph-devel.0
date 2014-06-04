From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW: Multi part upload - Attributes not copied from the upload
 object to the final meta object
Date: Wed, 4 Jun 2014 09:15:31 -0700
Message-ID: <CABBk=J_ZrA6iprZEAUsAf3Nfa7UA2KFZE+XSN13wpALYZiq7KQ@mail.gmail.com>
References: <CAF6-1L4rcN+P21sN2-ofrXdjqsLLbT4VYEMWzuu-1-evWBs9Yw@mail.gmail.com>
	<CABBk=J9AaxABAYR9VkY1GavfzMtYop8+0xxbfXcQRdPhAoJz2w@mail.gmail.com>
	<CAF6-1L5uvDfs_tkAVu8QB35G8eHsNQbHLQA-WUg89OY+9iG7XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:55511 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbaFDQPc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 12:15:32 -0400
Received: by mail-vc0-f180.google.com with SMTP id hq11so6873210vcb.39
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 09:15:31 -0700 (PDT)
In-Reply-To: <CAF6-1L5uvDfs_tkAVu8QB35G8eHsNQbHLQA-WUg89OY+9iG7XQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 4, 2014 at 9:07 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
>> This is a known issue (8452). We have a fix for that and we'll get it
>> to firefly.
>
> Ok, great. Somehow my search didn't turn that up.
>
>
> Looking at the patch, shouldn't the
>
> meta_obj.set_in_extra_data(true);
>
> be moved as well ?

Yeah, it should. Thanks!

Yehuda
