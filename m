From: Rafael Shuker <k.z.shuker@gmail.com>
Subject: Linking libraries into librados
Date: Sun, 15 Feb 2015 18:15:33 +1300
Message-ID: <CAApbOGp44pvpTUZd2FMxiJJjLG_ckKLQ+Xyqpo2nudc8x3Qb3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:61495 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbBOFPf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Feb 2015 00:15:35 -0500
Received: by mail-lb0-f173.google.com with SMTP id n10so22036623lbv.4
        for <ceph-devel@vger.kernel.org>; Sat, 14 Feb 2015 21:15:33 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hey guys,

This is my first time posting to this list, and I am a newbie in Ceph
development.

I am trying to write new functions into librados.cc and call external
libraries from that very function.

My problem is that I can't get my head around this build system when
using ./run-make-check.sh and adding a new <some-library-path>.a to
the src/librados/Makefile.am is giving me a headache.

I have successfully adjusted librados.cc and librados.h to do some
what I wanted, but whenever I reference a function in my external
library I get a undefined reference exception during compilation. I
have assumed that this is because I am not linking the library
correctly and would like to know what the correct way to link a .a
library for librados.cc.

TLDR: What is the correct way to add a library for librados.cc?

Thank you all for your help, please tell me if I can provide any more
information.

Cheers

Rafa.
