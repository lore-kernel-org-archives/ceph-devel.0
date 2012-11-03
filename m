From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: Need CRYPTO_CXXFLAGS with latest master?
Date: Fri, 2 Nov 2012 23:31:19 -0700
Message-ID: <18BB8BEE-0A64-42CB-9E6F-06941D9AC04A@inktank.com>
References: <CAPrxi59wW8EgQerDbY4E=i7RYMQy-Tb24AaSeEXJZhVehX0=1w@mail.gmail.com> <CAPrxi59u69dhunXv1PcwTeQJBvNKZ1X2JSYcsVr-sULFJ3ZzAA@mail.gmail.com> <591CE14B-3A97-41C0-B04A-01EBE0CEE3D4@inktank.com> <CAPrxi5_MTtcNnKd13YtzFCAgapi1s=f=wBA7u1G-_8a=Eii=rg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:51856 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab2KCGbY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 02:31:24 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2889965pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 23:31:23 -0700 (PDT)
In-Reply-To: <CAPrxi5_MTtcNnKd13YtzFCAgapi1s=f=wBA7u1G-_8a=Eii=rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Digging a little bit deeper, there is actually a comment in common/ceph_crypto.h that when using libnss you need the CRYPTO_CXFLAGS.  Since the pk11 headers are installed, I'm not sure there is problem we could detect.

This may be related to dmick's question about include paths.  Someone who knows more history will have to answer that.

Cheers,
Gary



On Nov 2, 2012, at 7:21 PM, Noah Watkins wrote:

> On Fri, Nov 2, 2012 at 6:04 PM, Gary Lowell <gary.lowell@inktank.com> wrote:
>> Looks like the complaints come from a small number of newish programs that are compiled only when the --with-debug flag is given.  When building against cryptpp (--with-cryptpp) the pk11 headers are found implicitly and  when building agains libnss (--with-nss) they are not.
>> 
>> So we probably need the changes in your wip-make-crypto-flags branch.
> 
> Ahh that makes sense. Now I can reproduce it. The branch is up at
> wip-crypto-flags. Seems like we should have ./configure blow up too if
> it can't find this stuff?
> 
> - Noah

