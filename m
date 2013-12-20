From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: Building Ceph using CMake
Date: Fri, 20 Dec 2013 08:58:56 -0600
Message-ID: <CA+Hcz58WWEqkWjO-rX230JvQLRL=6LepLdE0WLBCCfqA1RoszQ@mail.gmail.com>
References: <1417102805.191.1385512980002.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1045611233.81.1387310943871.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:50007 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab3LTO65 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Dec 2013 09:58:57 -0500
Received: by mail-qc0-f179.google.com with SMTP id i8so2254833qcq.24
        for <ceph-devel@vger.kernel.org>; Fri, 20 Dec 2013 06:58:56 -0800 (PST)
In-Reply-To: <1045611233.81.1387310943871.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <ali@linuxbox.com>
Cc: "Matt W. Benjamin" <matt@linuxbox.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On Tue, Dec 17, 2013 at 2:09 PM, Ali Maredia <ali@linuxbox.com> wrote:
>
> Most of the speedup can be attributed to the fact that libtool is compiling both PIC and non-PIC versions of every source file. CMake just builds everything with -fPIC. We don't have an opinion on the matter, but you may want to consider doing the same with the autotools build.
>
> Many source files are compiled into several targets causing them to be built multiple time. With the CMake build I was able to pull them into static libraries and link them into the targets that needed them.

In the latest round of automake clean-ups I know some of the
compilation redundancy was removed, but I dont' recall if it was all
taken care of. If you happen to know have a list of the redundant
stuff you found that would be helpful for improving automake.
