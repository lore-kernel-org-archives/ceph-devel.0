From: Wido den Hollander <wido@42on.com>
Subject: Re: Linking libraries into librados
Date: Mon, 16 Feb 2015 14:08:54 +0100
Message-ID: <54E1EBE6.1010500@42on.com>
References: <CAApbOGp44pvpTUZd2FMxiJJjLG_ckKLQ+Xyqpo2nudc8x3Qb3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43658 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755183AbbBPNI5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 16 Feb 2015 08:08:57 -0500
In-Reply-To: <CAApbOGp44pvpTUZd2FMxiJJjLG_ckKLQ+Xyqpo2nudc8x3Qb3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rafael Shuker <k.z.shuker@gmail.com>, ceph-devel@vger.kernel.org

On 15-02-15 06:15, Rafael Shuker wrote:
> Hey guys,
> 
> This is my first time posting to this list, and I am a newbie in Ceph
> development.
> 
> I am trying to write new functions into librados.cc and call external
> libraries from that very function.
> 
> My problem is that I can't get my head around this build system when
> using ./run-make-check.sh and adding a new <some-library-path>.a to
> the src/librados/Makefile.am is giving me a headache.
> 
> I have successfully adjusted librados.cc and librados.h to do some
> what I wanted, but whenever I reference a function in my external
> library I get a undefined reference exception during compilation. I
> have assumed that this is because I am not linking the library
> correctly and would like to know what the correct way to link a .a
> library for librados.cc.
> 
> TLDR: What is the correct way to add a library for librados.cc?
> 

To understand this correctly. You are not using librados, but you are
trying to modify librados by adding a external library in there?

> Thank you all for your help, please tell me if I can provide any more
> information.
> 
> Cheers
> 
> Rafa.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
