From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: infernalis feature freeze
Date: Tue, 25 Aug 2015 09:54:17 -0700
Message-ID: <CADRKj5RF0BoaUCGQhp5unr5wrFxT=_mL3Oe2J9GvGR10AyVuZA@mail.gmail.com>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
	<robbat2-20150818T220440-454479178Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34241 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537AbbHYQyS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Aug 2015 12:54:18 -0400
Received: by oiey141 with SMTP id y141so104372130oie.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2015 09:54:17 -0700 (PDT)
In-Reply-To: <robbat2-20150818T220440-454479178Z@orbis-terrarum.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Can you send a pull request so that I can review it?

Thanks,
Yehuda

On Tue, Aug 18, 2015 at 3:52 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> On Wed, Aug 12, 2015 at 02:20:11PM -0700,  Sage Weil wrote:
>> The infernalis feature freeze is coming up Real Soon Now.
> How soon is RSN?
>
> I'm interested in trying to land the Static-Website code in Infernalis
> (has tests added in a fork of s3-tests as well), but the ErrorDoc
> handling part is being stubborn.
>
> I'll settle for getting the changes for RGWRegion (changing hostnames
> and endpoints to maps by type) and RGWBucketInfo (storing the actual
> WebsiteConfiguration data) into infernalis
>
> --
> Robin Hugh Johnson
> Gentoo Linux: Developer, Infrastructure Lead
> E-Mail     : robbat2@gentoo.org
> GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
