From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 11:01:17 -0800
Message-ID: <CAF3hT9Di1SNgSXa-z=Dsd8nNxaCyFofFPzYt4hHWpoF_36=CpA@mail.gmail.com>
References: <4ED10636.6070705@biodatomics.com>
	<4ED36701.3060107@widodh.nl>
	<4ED37271.8030504@biodatomics.com>
	<CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com>
	<4ED3BCBE.6000906@biodatomics.com>
	<CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
	<4ED3C64B.5060601@biodatomics.com>
	<CAF3hT9Cpbm1B7-fVw=AAia0F_7_Cuct1DtJDM_fAAtyY3yh2WQ@mail.gmail.com>
	<4ED3D9EE.5080302@biodatomics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35555 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1K1TBS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 14:01:18 -0500
Received: by ggnr5 with SMTP id r5so5541307ggn.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 11:01:18 -0800 (PST)
In-Reply-To: <4ED3D9EE.5080302@biodatomics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: max@biodatomics.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 28, 2011 at 10:58 AM, Maxim Mikheev <mikhmv@biodatomics.com> wrote:
> Hi Everyone,
>
> Thank you for suggestions.
> "ceph injectargs '--mon_osd_full_ratio 96'" did the job and allow me to get
> access to data.
> After almost an hour data distribution on hard drives was not changed after
> reweight.
> Looks like reweight is not working.
>
> Most terrible observation is data transfer for: rados -p data bench 10 write
> was low at beginning ~3.5MB/s
> after one hour it is drop to 0.14MB/s and continue dropping.
>
> How can I improve a performance?

For now, just get your data out. Your performance is probably low
because it's not actually writing any more (if you look at the "ops
completed" column) since it filled up the disk again...
Somebody will check into the reweighting but we're pretty busy today
so it might take a while.
-Greg
