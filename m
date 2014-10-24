From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: krbd blk-mq support ?
Date: Fri, 24 Oct 2014 12:41:13 +0400
Message-ID: <CALFYKtATV2FsoSz=a_eizfTwbu4jO8z-i+W1ks5nHvOhxXOeUA@mail.gmail.com>
References: <9894b2d1-b7c6-4a17-9747-d8a41ec208a4@mailpro>
	<7a39f49a-2e11-48d6-90ce-e88dd652f6b9@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:48490 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbaJXIlP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Oct 2014 04:41:15 -0400
Received: by mail-qc0-f182.google.com with SMTP id m20so275669qcx.41
        for <ceph-devel@vger.kernel.org>; Fri, 24 Oct 2014 01:41:14 -0700 (PDT)
In-Reply-To: <7a39f49a-2e11-48d6-90ce-e88dd652f6b9@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

On Fri, Oct 24, 2014 at 11:54 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
> Hi,
>
> I would like to known if it's planned to add blk-mq (block multiqueue from kernel 3.17)  support to krbd ?
>
> I think it could help single threaded workload (including qemu) to reach more iops.
>
> I find some small discussion about it here:
> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/20584
>
> But no news since then.

There are no concrete plans as of now.  For 3.19 and 3.20 the main goal
is to get fancy striping (support for custom striping modes) in and
then get rid of "kernel layering is EXPERIMENTAL!" warning.

krbd is a network block device, so I don't think we will gain anything
significant in the performance department.  blk-mq was mentioned
because it lifts some of the implementation restrictions the current
infrastructure imposes on drivers.

Thanks,

                Ilya
