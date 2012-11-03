From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Fri, 2 Nov 2012 19:21:52 -0700
Message-ID: <CAPrxi5_MTtcNnKd13YtzFCAgapi1s=f=wBA7u1G-_8a=Eii=rg@mail.gmail.com>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com>
	<CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com>
	<591CE14B-3A97-41C0-B04A-01EBE0CEE3D4@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55116 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab2KCCVx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 22:21:53 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so4335736vcb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 19:21:53 -0700 (PDT)
In-Reply-To: <591CE14B-3A97-41C0-B04A-01EBE0CEE3D4@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Nov 2, 2012 at 6:04 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
> Looks like the complaints come from a small number of newish programs that are compiled only when the --with-debug flag is given.  When building against cryptpp (--with-cryptpp) the pk11 headers are found implicitly and  when building agains libnss (--with-nss) they are not.
>
> So we probably need the changes in your wip-make-crypto-flags branch.

Ahh that makes sense. Now I can reproduce it. The branch is up at
wip-crypto-flags. Seems like we should have ./configure blow up too if
it can't find this stuff?

- Noah
