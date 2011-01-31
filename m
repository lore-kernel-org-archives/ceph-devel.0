From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: some thoughts about scrub
Date: Mon, 31 Jan 2011 14:57:24 -0800
Message-ID: <AANLkTimwr1c7fvC=qCPR-iGk8diCJy9Qgw9bVWTrqoMB@mail.gmail.com>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
	<1296511912.23762.205.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46087 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab1AaW50 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Jan 2011 17:57:26 -0500
Received: by fxm20 with SMTP id 20so6165897fxm.19
        for <ceph-devel@vger.kernel.org>; Mon, 31 Jan 2011 14:57:24 -0800 (PST)
In-Reply-To: <1296511912.23762.205.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 31, 2011 at 2:11 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Most drives have some spare sectors that they internally remap over
> bad sectors. =A0Such a bad sector can be "healed" by rewriting that
> LBA, because the drive will internally remap it. =A0You can use
> smartctl on drives that support it to learn how many sectors have
> had read errors, of both the recoverable and unrecoverable variety,
> I think, and also how many spare sectors are remaining.
>
> So one of the things I'd really like Ceph scrub to do when it is
> reading every one of its objects is rewrite the ones on which it
> gets read errors, by fetching one of its other copies. =A0Maybe it
> already does this?

Yeah, we should definitely check the return codes when we do scrub
operations on the filestore. If we get an error, we should fetch that
object from another replica.

This is something we're committed to doing in theory, but I don't
think any system tests exist yet that measure our progress towards
getting it right. Handling disk errors is tough because the normal use
cases don't really test it.

> If Ceph scrub works this way, then another
> thing I really want to do is learn to tell my disks to not try
> so hard to recover a sector, as I know I have at least one other
> copy I can use to repair it, and because that minimizes the time
> that osd is stalled.

Do you set these kind of timeouts through smartctl or hdparm?

> If such a bad sector is used for btrfs metadata, well, AFAIK
> btrfs duplicates its metadata by default (see mkfs.btrfs -m single).
> Presumably if it gets a metadata read failure it will rewrite the
> offending sectors using its other copy? =A0If not, we should try
> to convince the btrfs devs to do so.

Yeah, definitely.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
