From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Collection of strange lockups on 0.51
Date: Thu, 13 Sep 2012 01:43:23 +0400
Message-ID: <CABYiri_ujogFa==21ty3eWhDGx7PMK-F4Rya0kJEF-RQTsBNQQ@mail.gmail.com>
References: <CABYiri8t9yXQ39WOW1+Rib5jxp8qUCUY8iSht=p2PSQZtn3ZEA@mail.gmail.com>
 <CADvuQRFMaGpH9MdFHDDworDMEePsj=vn1A6vbE0b0G6+oS41Lg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46654 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122Ab2ILVnp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 17:43:45 -0400
Received: by wibhi8 with SMTP id hi8so5914597wib.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Sep 2012 14:43:43 -0700 (PDT)
In-Reply-To: <CADvuQRFMaGpH9MdFHDDworDMEePsj=vn1A6vbE0b0G6+oS41Lg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 13, 2012 at 1:09 AM, Tommi Virtanen <tv@inktank.com> wrote:
> On Wed, Sep 12, 2012 at 10:33 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> Hi,
>> This is completely off-list, but I`m asking because only ceph trigger
>> such a bug :) .
>>
>> With 0.51, following happens: if I kill an osd, one or more neighbor
>> nodes may go to hanged state with cpu lockups, not related to
>> temperature or overall interrupt count or la and it happens randomly
>> over 16-node cluster. Almost sure that ceph triggerizing some hardware
>> bug, but I don`t quite sure of which origin. Also after a short time
>> after reset from such crash a new lockup may be created by any action.
>
> From the log, it looks like your ethernet driver is crapping out.
>
> [172517.057886] NETDEV WATCHDOG: eth0 (igb): transmit queue 7 timed out
> ...
> [172517.058622]  [<ffffffff812b2975>] ? netif_tx_lock+0x40/0x76
>
> etc.
>
> The later oopses are talking about paravirt_write_msr etc, which makes
> me thing you're using Xen? You probably don't want to run Ceph servers
> inside virtualization (for production).

NOPE. Xen was my choice for almost five years, but right now I am
replaced it with kvm everywhere due to buggy 4.1 '-stable'. 4.0 has
same poor network performance as 3.x but can be really named stable.
All those backtraces comes from bare hardware.

At the end you can see nice backtrace which comes out soon after end
of the boot sequence when I manually typed 'modprobe rbd', it may be
any other command assuming from experience. As soon as I don`t know
anything about long-lasting states in intel, especially of those which
will survive ipmi reset button, I think that first-sight complain
about igb may be not quite right. If there cards may save some of
runtime states to EEPROM and pull them back then I`m wrong.

>
> [172696.503900]  [<ffffffff8100d025>] ? paravirt_write_msr+0xb/0xe
> [172696.503942]  [<ffffffff810325f3>] ? leave_mm+0x3e/0x3e
>
> and *then* you get
>
> [172695.041709] sd 0:2:0:0: [sda] megasas: RESET cmd=2a retries=0
> [172695.041745] megasas: [ 0]waiting for 35 commands to complete
> [172696.045602] megaraid_sas: no pending cmds after reset
> [172696.045644] megasas: reset successful
>
> which just adds more awesomeness to the soup -- though I do wonder if
> this could be caused by the soft hang from earlier.
