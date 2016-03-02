From: Jai <jai_97@rediffmail.com>
Subject: Re: make error while building ceph
Date: Wed, 2 Mar 2016 08:29:20 +0530
Message-ID: <CAPpuMWw6dO9SMwKciX-_GmnzbzU-jUh2RsjH1gjpWd_YvdikKA@mail.gmail.com>
References: <CAPpuMWyW6jzG2TE=FRLdGAxP-OOBg3=WyCcw72DU79StsM2G7A@mail.gmail.com>
 <56D2D089.7090109@dachary.org> <CAPpuMWx9Or8ETDKtzFsUUkF0wSDnPEjiKhOSuVT=VrVYiUNohg@mail.gmail.com>
 <56D2D55C.7060603@dachary.org> <CAPpuMWyePM_TvmO1MHFRF=jQMw5KRqyy4FA3+QRU2pAq97UwSw@mail.gmail.com>
 <56D460AD.9070806@dachary.org> <CAPpuMWxo-qSeMyiv2eMNhbM-5=dp-+eQOxqvH_yZUNCenfDQUg@mail.gmail.com>
 <56D59D02.1050808@redhat.com> <CAPpuMWzZHMLSTRuWcvwbQLQ9hSj2+BufYLB5BTAys+0_KDHh4g@mail.gmail.com>
 <56D5F871.2040901@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34486 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbcCBC7m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2016 21:59:42 -0500
Received: by mail-lf0-f50.google.com with SMTP id l13so14292911lfb.1
        for <ceph-devel@vger.kernel.org>; Tue, 01 Mar 2016 18:59:41 -0800 (PST)
In-Reply-To: <56D5F871.2040901@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: dang@redhat.com, Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

I ve got 8G on my laptop - so I can retry with something less than
that for the VM. Ive reinstalled Centos7 and gone back to gcc 4.8.5
which is the default on centos 7.
cmake - I ve tried it, got errors here too.
--
Jai

On Wed, Mar 2, 2016 at 1:45 AM, Nathan Cutler <ncutler@suse.cz> wrote:
> On 03/01/2016 03:39 PM, Jai wrote:
>>
>> I saw one report of a RAM issue.
>> I have 2G on the VM - and  it was hung for > half a day.
>
>
> I've found that compiling Ceph requires at least 8GB of RAM - anything less
> is a recipe for failure. I have not tried using cmake, though.
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
