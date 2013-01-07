From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 7 Jan 2013 13:21:28 +0100
Message-ID: <CAF6-1L7h62R60gmn+=yvNP1JqfknqWKw6WX4wO79v0xCQVKB7Q@mail.gmail.com>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
	<CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com>
	<CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
	<CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
	<50EAAC93.3070308@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38312 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab3AGM04 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 07:26:56 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so17730771oag.17
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 04:26:55 -0800 (PST)
In-Reply-To: <50EAAC93.3070308@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hi,

> As far as I know relying on SCRIPT_URI is rather dangerous since it's not
> always there.
>
> There better should be an if/else-satement surrounding that code having it
> defaulting to something else if SCRIPT_URI isn't available.

I've opened a bug and proposed a patch setting the default value to ""

http://tracker.newdream.net/issues/3735

Cheers,

    Sylvain
