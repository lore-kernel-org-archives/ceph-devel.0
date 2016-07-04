From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: Cmake, Clang and plugins
Date: Mon, 4 Jul 2016 15:54:17 +0300
Message-ID: <20160704125415.GA14833@gmail.com>
References: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35925 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561AbcGDMyU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2016 08:54:20 -0400
Received: by mail-lf0-f47.google.com with SMTP id q132so116671032lfe.3
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2016 05:54:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 04, 2016 at 01:09:15PM +0200, Willem Jan Withagen wrote:
> Hi,
> 
> I'm being pestered by:
>  dlopen(/home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so):
> /home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so: Undefined
> symbol "ceph_arch_neon"
> if I try to run anything that want as plugin.
> 
> Now the question is: what extra bui;ding/linker  options would this
> require to actually fix this?

If I recall it right, in automake it is fixed by this:

if LINUX
liberasure_code_la_LIBADD = -ldl
endif # LINUX

-- 
Mykola Golub
