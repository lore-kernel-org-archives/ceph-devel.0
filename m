From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: RGW: Multi part upload - Attributes not copied from the upload
 object to the final meta object
Date: Wed, 4 Jun 2014 18:07:23 +0200
Message-ID: <CAF6-1L5uvDfs_tkAVu8QB35G8eHsNQbHLQA-WUg89OY+9iG7XQ@mail.gmail.com>
References: <CAF6-1L4rcN+P21sN2-ofrXdjqsLLbT4VYEMWzuu-1-evWBs9Yw@mail.gmail.com>
	<CABBk=J9AaxABAYR9VkY1GavfzMtYop8+0xxbfXcQRdPhAoJz2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59056 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaFDQHY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jun 2014 12:07:24 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so6259425pdi.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Jun 2014 09:07:24 -0700 (PDT)
In-Reply-To: <CABBk=J9AaxABAYR9VkY1GavfzMtYop8+0xxbfXcQRdPhAoJz2w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> This is a known issue (8452). We have a fix for that and we'll get it
> to firefly.

Ok, great. Somehow my search didn't turn that up.


Looking at the patch, shouldn't the

meta_obj.set_in_extra_data(true);

be moved as well ?


Cheers,

   Sylvain
