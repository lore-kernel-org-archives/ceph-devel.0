From: kefu chai <tchaikov@gmail.com>
Subject: Re: 9.0.2 test/perf_local.cc on non-x86 architectures
Date: Sat, 25 Jul 2015 00:42:15 +0800
Message-ID: <CAJE9aOO41GjqWTtSE=c-5hOq-VDDGb725zuXChoRV9r+3E3A1g@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91669B9E68@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36084 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbGXQmQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2015 12:42:16 -0400
Received: by qkdv3 with SMTP id v3so17595760qkd.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2015 09:42:15 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669B9E68@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 22, 2015 at 12:34 AM, Deneau, Tom <tom.deneau@amd.com> wrote:
> I was trying to do an rpmbuild of v9.0.2 for aarch64 and got the following error:
>
> test/perf_local.cc: In function 'double div32()':
> test/perf_local.cc:396:31: error: impossible constraint in 'asm'
>                           "cc");
>
> Probably should have an if defined (__i386__) around it.

Tom,

hopefully https://github.com/ceph/ceph/pull/5342 will address it.

thanks,
