From: Faidon Liambotis <paravoid@debian.org>
Subject: Re: Seg Fault on rgw 0.61.1 with cluster in 0.61
Date: Tue, 14 May 2013 15:16:01 +0300
Message-ID: <51922B01.5060900@debian.org>
References: <367CC0B0FC02EE47BF7482398BD623C55E230EFF@DB3PRD0311MB416.eurprd03.prod.outlook.com> <CABBk=J_QaRUFmq_gPHeywkkRSJaaAzMz0eM8jZ15+FQKuQo5Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from scrooge.tty.gr ([62.217.125.135]:47955 "EHLO mail.tty.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756861Ab3ENM7y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 May 2013 08:59:54 -0400
In-Reply-To: <CABBk=J_QaRUFmq_gPHeywkkRSJaaAzMz0eM8jZ15+FQKuQo5Bw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Yann ROBIN <yann.robin@youscribe.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/10/13 19:02, Yehuda Sadeh wrote:
> Sounds to me like package versioning mismastch. Could it be that one
> of the ceph packages was on a different version (e.g., librados).

I attempted to install and run radosgw 0.61.1 on a system with a 0.56.4 
librados and it segfaulted with the same backtrace as the one in this 
thread.

If a newer radosgw can't work with an older librados, this should be 
reflected on the package relationships -- hopefully without nasty 
Breaks/Conflicts, but with a proper librados SONAME bump that will allow 
coinstability between librados2 and e.g. librados3. Or symbol versioning 
could be employed to provide backwards compatibility.

This installed-but-segfaulting combination of packages shouldn't be 
allowed by apt to exist on the system. FWIW, if these were packages in 
Debian (and, presumably, Ubuntu), that would be a severity: 
serious/release critical bug.

It'd also be nice to be able to do things like mixing newer radosgw 
while also keeping the old librados2 on the system. My use case is that 
I have monitors and radosgw on the same boxes and I'd like to keep 
monitors on bobtail, while at the same time use some of the much needed 
radosgw cuttlefish features.

Regards,
Faidon
