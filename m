From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: subdir-objects
Date: Wed, 21 Aug 2013 23:01:57 +0200
Message-ID: <CAN04cT74h7QjWhOCQqc3e7HM__qaw+BrbaCy3NW_ZzC1xzX4Kg@mail.gmail.com>
References: <CAN04cT5zbp2oe9QvcbnQ4W=7ByA1UybzPEGGWvngjLogsqFaWA@mail.gmail.com>
	<CA+Hcz5-uxiNMQiNXKfbETiQG0D6-nUrbV5oGpmMqn8oWi4DwGw@mail.gmail.com>
	<alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58449 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab3HUVB5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Aug 2013 17:01:57 -0400
Received: by mail-oa0-f46.google.com with SMTP id j10so1924468oah.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Aug 2013 14:01:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1308211340020.28981@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Aug 21, 2013 at 10:41 PM, Sage Weil <sage@inktank.com> wrote:
> Yes, the Makefile.am is in dire need of from TLC from someone who knows a
> bit of autotools-fu.  It is only this way because in the beginning I
> didn't know any better.

Well, my average knowledge of autotools could at least fix this
particular issue and clean up a bit more. It's a start I guess and
helps me to continue my RGW things.

I'll send out a pull request when I've found some time to implement
and test this.

Roald
