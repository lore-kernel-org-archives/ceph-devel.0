From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Problem running make check
Date: Thu, 14 May 2015 13:55:41 -0700
Message-ID: <CAC6JEv9s1fSk7X5XSp8CtYN6Qr3SR5+XRD-Lu51YDJw0RGdRNA@mail.gmail.com>
References: <CAEFDAA5BroNoMvR8Yyvf+nj_0RJa20gkCUhJo3zrbvYNYa5w1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34146 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339AbbENUzm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 16:55:42 -0400
Received: by iecmd7 with SMTP id md7so71557027iec.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 13:55:42 -0700 (PDT)
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com. [209.85.223.177])
        by mx.google.com with ESMTPSA id o2sm42151igr.9.2015.05.14.13.55.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2015 13:55:41 -0700 (PDT)
Received: by iebgx4 with SMTP id gx4so71330810ieb.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 13:55:41 -0700 (PDT)
In-Reply-To: <CAEFDAA5BroNoMvR8Yyvf+nj_0RJa20gkCUhJo3zrbvYNYa5w1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michal Jarzabek <stiopa@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 14, 2015 at 1:24 PM, Michal Jarzabek <stiopa@gmail.com> wrote:
> Hi,
>
> After cloning ceph repo and then running:
> ./autogen.sh
> ./configure
> make -j 8
> make check
>
> make check always hangs after following lines:
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: unittest_texttable
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: unittest_on_exit
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: unittest_readahead
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: unittest_tableformatter
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: unittest_bit_vector
> LD_PRELOAD=liblttng-ust-fork.so
> PASS: ceph-detect-init/run-tox.sh
> LD_PRELOAD=liblttng-ust-fork.so
>
> Any idea what might be a problem?

You can try building without lttng, which has helped some users, and
you can check if you have high enough ulimit settings. The defaults on
my box were not high enough; I bumped both files and processes up to
16k and rebooted before I could get it working properly.
-Greg
