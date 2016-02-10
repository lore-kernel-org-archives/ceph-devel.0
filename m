From: Haomai Wang <haomai@xsky.com>
Subject: Re: NVMEDevice.cc fails to build
Date: Wed, 10 Feb 2016 21:07:41 +0800
Message-ID: <CACJqLya53aoZcEO9=cxHPZRd94ernO+4aLekaeHAf7mbBVVFew@mail.gmail.com>
References: <CAJE9aOPODHBXtUJfxY9YF6s5-0=yJey3BBm=gYJds5v-e8+yPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0094.outbound.protection.outlook.com ([104.47.125.94]:28680
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751335AbcBJNH4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 08:07:56 -0500
Received: by mail-ig0-f179.google.com with SMTP id xg9so13132864igb.1
        for <ceph-devel@vger.kernel.org>; Wed, 10 Feb 2016 05:07:51 -0800 (PST)
In-Reply-To: <CAJE9aOPODHBXtUJfxY9YF6s5-0=yJey3BBm=gYJds5v-e8+yPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, haomai@xsky.org

sure, I had a local branch which has a refactor after vacation.

On Wed, Feb 10, 2016 at 8:07 PM, kefu chai <tchaikov@gmail.com> wrote:
> hi haomai,
>
> the build WITH_SPDK fails after
> bd694d4a6d6367c29c1935c906fe8059dd1368dc and
> b62318ea16d5830bb2b23b1a95ca39a5310fac34, could you update the
> NVMEDevices accordingly?
>
> thanks,
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
