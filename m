From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Debug messages of osd_ping and ping_reply
Date: Thu, 30 Oct 2014 09:31:11 -0700
Message-ID: <CAC6JEv8YJi_kEv5t7TzcKi_+vpnLyXdWsoNy-jaPv_7vwJ7ohA@mail.gmail.com>
References: <C226B0AB34511445928D9882AA519F6009AD6940@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:39018 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047AbaJ3QbP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 12:31:15 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so4078506wgh.25
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 09:31:13 -0700 (PDT)
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com. [209.85.212.179])
        by mx.google.com with ESMTPSA id q5sm22735904wiy.16.2014.10.30.09.31.12
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 Oct 2014 09:31:12 -0700 (PDT)
Received: by mail-wi0-f179.google.com with SMTP id h11so7921762wiw.6
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 09:31:12 -0700 (PDT)
In-Reply-To: <C226B0AB34511445928D9882AA519F6009AD6940@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 30, 2014 at 1:26 AM, Varada Kari <Varada.Kari@sandisk.com> wrote:
> Hi all,
>
> We have a test cluster with ~500 OSD's. This cluster has multiple rbd images mapped to multiple client machines. But from past two days, only one rbd image was serving the IO's rest of the images were not used.
> We are running the cluster with debug 1/1 for most of the sub modules. But the logs of OSD's are filled with the following messages.
> ----------------
> 2014-10-30 12:11:52.430542 7ff431032700  1 -- 10.242.42.172:6919/2601499 --> 10.242.42.178:0/44638 -- osd_ping(ping_reply e24581 stamp 2014-10-30 12:12:54.457189) v2 -- ?+0 0x77b32a0 con 0x1c3563c0
> 2014-10-30 12:11:52.430613 7ff42f82f700  1 -- 10.242.42.172:6915/2601499 <== osd.462 10.242.42.178:0/44638 337603 ==== osd_ping(ping e24581 stamp 2014-10-30 12:12:54.457189) v2 ==== 47+0+0 (2159846856 0 0) 0x27020ee0 con 0x1949db20
> 2014-10-30 12:11:52.430669 7ff42f82f700  1 -- 10.242.42.172:6915/2601499 --> 10.242.42.178:0/44638 -- osd_ping(ping_reply e24581 stamp 2014-10-30 12:12:54.457189) v2 -- ?+0 0x1d61ef00 con 0x1949db20
> ---------------
>
> Looking at the code, these messages are coming from DispatchQueue::pre_dispatch and SimpleMessenger::_send_message. And these messages are at debug level 1 for debug_ms and approximately 200MB-400MB is occupied for these messages from each osd log.
>
> Is there any reason these messages are present at level 1?  Can we move to debug level 5 or above?

The messages being passed around are the most basic unit of
information about what the messenger is doing that could be helpful
for much of anything, so they're at level one. In particular, this is
information that we want when diagnosing almost any other problem that
involves more than one process, so we like to have it on by default.
You could turn down the messenger debugging if it really mattered to
you, but the data should compress well with log rotation so I'm not
sure there's much point.
-Greg
