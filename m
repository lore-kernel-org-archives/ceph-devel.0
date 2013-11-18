From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Could ceph-deploy handle unknown or custom distribution? (Was:
 Mourning the demise of mkcephfs)
Date: Mon, 18 Nov 2013 19:15:51 +1300
Message-ID: <5289B097.4020509@catalyst.net.nz>
References: <5281192D.4090707@bob-the-boat.me.uk> <CANtztVwJyK7C5LS1G3YCLh-0T0VODCsUuWE1ADz_PupJe4nAAQ@mail.gmail.com> <5282F309.2030104@catalyst.net.nz> <5289AE12.6020102@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:35284 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab3KRGPx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Nov 2013 01:15:53 -0500
In-Reply-To: <5289AE12.6020102@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <alfredo.deza@inktank.com>, "Dave (Bob)" <dave@bob-the-boat.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 18/11/13 19:05, Mark Kirkwood wrote:

> Anyway I have attached a log of me getting a system of 2 Archlinux nodes
> up. These were KVM guests built identically and ceph (0.72) was compiled
> from src and installed.
>

Blast - forgot to edit the top of the log to reflect the effect of the 
osd and ceph-disk patches, should say:

State:

- monitors created and start ok
- osd created ok
- osd started ok via 'activate' after patching ceph-disk
