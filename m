From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cmake, Clang and plugins
Date: Tue, 5 Jul 2016 14:43:07 +0200
Message-ID: <39f4b63c-4722-8726-400c-5c6ef2bb903b@digiware.nl>
References: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:46624 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975AbcGEMnZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Jul 2016 08:43:25 -0400
Received: from [192.168.10.67] (opteron [192.168.10.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.digiware.nl (Postfix) with ESMTPSA id 11A6515340A
	for <ceph-devel@vger.kernel.org>; Tue,  5 Jul 2016 14:43:14 +0200 (CEST)
In-Reply-To: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 4-7-2016 13:09, Willem Jan Withagen wrote:
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
> Symbol analysis is below.

Right,

Many Variable/option combinations further down the line:
  set(CMAKE_EXE_LINKER_FLAGS "-Wl,-export-dynamic")
was my friend.

And not things like:
  CMAKE_LINKER_FLAGS
Those flags do not end up on the commandline when linking an executable.

And the dynamic table needs to be atleast on the executable.

--WjW




