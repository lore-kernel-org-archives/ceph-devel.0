From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel client OSD message version
Date: Thu, 19 Nov 2015 13:34:22 +0100
Message-ID: <CAOi1vP_+tc9U8XurVj4TOd=yOANmFv7QOussTvcyOEt+5jzMiA@mail.gmail.com>
References: <90EABA838E32E141BC06296A2C40520A1A653D55@IRSMSX108.ger.corp.intel.com>
	<CAOi1vP-YjiTA7WBYKLM63Sx0GGzg28HMj+R4nws7VY1ySe+Kcw@mail.gmail.com>
	<90EABA838E32E141BC06296A2C40520A1A653DE9@IRSMSX108.ger.corp.intel.com>
	<CAOi1vP_r2racUXVh5-0Q80dZh15CEN35kWqWfQRt4uvY=o3mEg@mail.gmail.com>
	<90EABA838E32E141BC06296A2C40520A1A653E31@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37438 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbKSMeX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 07:34:23 -0500
Received: by wmww144 with SMTP id w144so114481506wmw.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 04:34:22 -0800 (PST)
In-Reply-To: <90EABA838E32E141BC06296A2C40520A1A653E31@IRSMSX108.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lakis, Jacek" <jacek.lakis@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 19, 2015 at 1:09 PM, Lakis, Jacek <jacek.lakis@intel.com> wrote:
> Ok, thanks.
> Coming back to the splitted decoding you mentioned:
> This change, except the reordering, causes some performance improvement so the need arises.
> It's also not included in the stable release yet. So, it's good to contribute the patches?

Well, that's why I asked what the motivation was - the split change was
the only thing I could think of there.  The code that encodes MOSDOp
messages is in ceph_osdc_build_request() and is tied to the rest of
osd_client code (there is no separate MOSDOp message struct, so it's
encoded inline).  osd_client is in the middle of a major rework for
kernel 4.5 so there is no stable ground to base patches on.

Since the change is trivial, I can just do it myself and include it in
the osd_client patchset.

Thanks,

                Ilya
