From: Gregory Farnum <greg@gregs42.com>
Subject: Re: libcrush.so
Date: Thu, 7 May 2015 21:37:19 -0700
Message-ID: <CAC6JEv-+-rQzDaMCmb1Nx8f+QtDToDp0EZD3g5T=gQOZ+BkwMA@mail.gmail.com>
References: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36481 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbEHEhV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 00:37:21 -0400
Received: by iecnq11 with SMTP id nq11so55499890iec.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 21:37:21 -0700 (PDT)
Received: from mail-ig0-f175.google.com (mail-ig0-f175.google.com. [209.85.213.175])
        by mx.google.com with ESMTPSA id n9sm4395459igy.2.2015.05.07.21.37.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 21:37:20 -0700 (PDT)
Received: by igbyr2 with SMTP id yr2so11809563igb.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2015 21:37:19 -0700 (PDT)
In-Reply-To: <06681238D8946F44A60AA400760A1CBF01F60F19@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Cohen, David E" <david.e.cohen@intel.com>, "Yu, Zhidong" <zhidong.yu@intel.com>

On Thu, May 7, 2015 at 6:29 PM, Zhou, Yuan <yuan.zhou@intel.com> wrote:
> Ceph use crush algorithm to provide the mapping of objects to OSD servers. This is great for clients so they could talk to with these OSDs directly. However there are some scenarios where the application needs to access the crush map, for load-balancing as an example.
>
> Currently Ceph doesn't provides any API to render the layout. If your application needs to access the crush map you'll going to rely on the command 'ceph osd map pool_name obj_name'. With this libcrush.so we could let the application to choose which nodes to access. The other advantage is we could provide some other bindings(python, go) based on this also.
>
> From the git log we find libcrush was there before but removed out since Argonaut. Can anyone kindly share us the background of this change?

I don't think there was ever a libcrush that was friendly for external
use. There was a makefile-level "libcrush" but it got merged into
libcommon, presumably for ease of maintenance. The interfaces we use
around CRUSH are just not very clean, IIRC; the C interface is opaque
and the C++ CrushWrapper bits are...well, C++, and not easy to change
into something separable from the OSDMap, either. :/

That said, if somebody wanted to rework the code interfaces to be
nicer, PRs are always welcome. ;)
