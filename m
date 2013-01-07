From: Caleb Miles <caleb.miles@inktank.com>
Subject: Re: radosgw segfault in 0.56
Date: Mon, 7 Jan 2013 08:33:12 -0500
Message-ID: <CA+zLgM3mjSN5o3tpPgCqxszShmp=y43qmH_E0QkgChmYgb_xAg@mail.gmail.com>
References: <CAF6-1L5mV+nRt0yFu1CCZKH7rXiZPfxDYLi-ukmYWTSokQQbdQ@mail.gmail.com>
	<CAPHxCcQe3ghwv_QPoVp=9jtCoprYcWFUprhxKzhg4eOmTzKeRA@mail.gmail.com>
	<CAF6-1L4eYaVD5_MMdgX+pOOBzq1aZ==S9E9zO+HXrG-SDqnerw@mail.gmail.com>
	<CAF6-1L6ojT6LciLN3x8wTPXJ7gxGvpYucPdM7jY6gP728P-j=w@mail.gmail.com>
	<50EAAC93.3070308@widodh.nl>
	<CAF6-1L7h62R60gmn+=yvNP1JqfknqWKw6WX4wO79v0xCQVKB7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:58231 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3AGNkm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jan 2013 08:40:42 -0500
Received: by mail-wg0-f41.google.com with SMTP id ds1so2280432wgb.0
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jan 2013 05:40:41 -0800 (PST)
In-Reply-To: <CAF6-1L7h62R60gmn+=yvNP1JqfknqWKw6WX4wO79v0xCQVKB7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi all,

Created branch wip-3735 to capture Sylvain's patch.

On Mon, Jan 7, 2013 at 7:21 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>> As far as I know relying on SCRIPT_URI is rather dangerous since it's not
>> always there.
>>
>> There better should be an if/else-satement surrounding that code having it
>> defaulting to something else if SCRIPT_URI isn't available.
>
> I've opened a bug and proposed a patch setting the default value to ""
>
> http://tracker.newdream.net/issues/3735
>
> Cheers,
>
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
