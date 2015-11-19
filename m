From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel client OSD message version
Date: Thu, 19 Nov 2015 11:59:58 +0100
Message-ID: <CAOi1vP_r2racUXVh5-0Q80dZh15CEN35kWqWfQRt4uvY=o3mEg@mail.gmail.com>
References: <90EABA838E32E141BC06296A2C40520A1A653D55@IRSMSX108.ger.corp.intel.com>
	<CAOi1vP-YjiTA7WBYKLM63Sx0GGzg28HMj+R4nws7VY1ySe+Kcw@mail.gmail.com>
	<90EABA838E32E141BC06296A2C40520A1A653DE9@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35097 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbKSK77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 05:59:59 -0500
Received: by wmdw130 with SMTP id w130so235166490wmd.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 02:59:58 -0800 (PST)
In-Reply-To: <90EABA838E32E141BC06296A2C40520A1A653DE9@IRSMSX108.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lakis, Jacek" <jacek.lakis@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 19, 2015 at 11:27 AM, Lakis, Jacek <jacek.lakis@intel.com> wrote:
> Ilya, thank you for the quick reply.
>
> For example it's about split decoding. I'm asking not because of specific changes, I'm rather curious about when we should sync the kernel client encoding to the master (or stable versions).

It's usually done when the need arises, like if the kernel client
starts using a field that isn't in the old enconding.  We don't update
for each new ceph release.

Thanks,

                Ilya
