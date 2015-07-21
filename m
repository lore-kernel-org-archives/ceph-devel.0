From: Milan Broz <mbroz@redhat.com>
Subject: Re: dmcrypt with luks keys in hammer
Date: Tue, 21 Jul 2015 16:25:40 +0200
Message-ID: <55AE5664.9070809@redhat.com>
References: <CAGbvivJH4UJtkcHmgvA7c88YJ6hgmm86fArqJJOszrtBh=kgrg@mail.gmail.com>	<alpine.DEB.2.00.1507201419330.8878@cobra.newdream.net>	<CAGbviv+2O1z-=9WWSFAFzox=B5dgsASNpYpi5jinmgPW=VTVVw@mail.gmail.com>	<alpine.DEB.2.00.1507201521000.8878@cobra.newdream.net> <20150721131429.472492bf@g21.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33871 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360AbbGUOZn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jul 2015 10:25:43 -0400
In-Reply-To: <20150721131429.472492bf@g21.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>, Sage Weil <sage@newdream.net>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.com>

On 07/21/2015 01:14 PM, David Disseldorp wrote:

>>> A race condition (or other issue) with udev seems likely given that
>>> its rather random which ones come up and which ones don't
>>
>> A race condition during creation or activation?  If it's activation I 
>> would expect ceph-disk activate ... to work reasonably reliably when 
>> called manually (on a single device at a time).

I still do not understand completely how the dmcrypt activation
in Ceph is designed, but there are clear problems in the current design.

Activation of another device-mapper inside udev rules (here LUKS or
plain dmcrypt device) is broken by design, it can work with only
with ugly workarounds.

The first reason is correctly mentioned in your mentioned wip branch
(udev RUN is intended for short-running commands. For example,
I think if you increase iteration count in LUKS device, the whole Ceph udev
rules fails completely because udev thread processing will kill it on timeout...)
(Unlocking can take even minutes when you move encrypted disk to a very slow machine)

The second reason is even more serious - cryptsetup itself uses udev
(through libdevmapper) to create nodes and must synchronize with
some other device-mapper udev rules. So here it is a race by design...
udev waits for another udev process. Ditto for creating /dev/by* links
(created by udev rule as well).

(And add to mix +watch rules, which reacts on close-on-write on every
node by running another udev rule blkid scan. If you see some leftover
temporary-cryptsetup* devices, something is really wrong. These
devices are internal to libcryptsetup and maps keyslots only, there are never
keep open in correct operation.)

So moving activation outside of the udev rules is the correct solution here,
only processing of device nodes should be there and rest should be
offloaded after udev rules run.

> We encountered similar issues on a non-dmcrypt firefly deployment with
> 10 OSDs per node.
> 
> I've been working on a patch set to defer device activation to systemd
> services. ceph-disk activate is extended to support mapping of dmcrypt
> devices prior to OSD startup.

Well, using systemd service is one option. But then it should handle all
cryptsetup device activations.

Milan

