From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Usable Space
Date: Wed, 6 Mar 2013 15:59:54 +0100
Message-ID: <CAF6-1L7CDsbW8jW1-DuV9-8ZpUSStpFAhY5iEBhSvB1gtk5B3Q@mail.gmail.com>
References: <CAP8Oy=JrQiNYcwPNTqdyDzDk1A4LBEcSFzwLAqcgSFcUu-WhJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:34818 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab3CFO74 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 09:59:56 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so348888bkc.11
        for <ceph-devel@vger.kernel.org>; Wed, 06 Mar 2013 06:59:55 -0800 (PST)
In-Reply-To: <CAP8Oy=JrQiNYcwPNTqdyDzDk1A4LBEcSFzwLAqcgSFcUu-WhJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Patrick McGarry <patrick@inktank.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>, a.iwanowski@ogicom.pl

> Total Space: X / Y  ||  Usable Space: A / B

> Would it be possible to add this in at some point? Seems like a great
> addition to go with some of the other 'usability enhancements' that
> are planned.  Or would this get computationally sticky based on having
> many pools with different replication levels?

How would you even compute it ?

I mean if the underlying storage is shared between several pools with
different replication level, the "usable space" will depend in which
space you actually put your data in ...

You could do it "per pool" but even then I think it can get tricky
because the CRUSH map could very well distribute the data in a pool on
a subset of OSD so you'd need to take that into account as well.

Cheers,

   Sylvain
