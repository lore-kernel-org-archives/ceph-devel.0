From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel client OSD message version
Date: Thu, 19 Nov 2015 10:28:58 +0100
Message-ID: <CAOi1vP-YjiTA7WBYKLM63Sx0GGzg28HMj+R4nws7VY1ySe+Kcw@mail.gmail.com>
References: <90EABA838E32E141BC06296A2C40520A1A653D55@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34871 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115AbbKSJ27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Nov 2015 04:28:59 -0500
Received: by wmdw130 with SMTP id w130so232021156wmd.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2015 01:28:58 -0800 (PST)
In-Reply-To: <90EABA838E32E141BC06296A2C40520A1A653D55@IRSMSX108.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lakis, Jacek" <jacek.lakis@intel.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 19, 2015 at 10:04 AM, Lakis, Jacek <jacek.lakis@intel.com> wrote:
> Hi Cephers!
>
> Recently, the version of OSDOp in Ceph increased to version 7 (in master, 6 in infernalis). Kernel client still encoding version 4.
> Should we consider upstreaming patches to the client?

Is it the split encoding that you are after or are there other issues
involved?

Thanks,

                Ilya
