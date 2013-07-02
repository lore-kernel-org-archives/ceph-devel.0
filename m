From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH] ceph: Add FScache support
Date: Tue, 2 Jul 2013 15:20:12 -0400
Message-ID: <CANP1eJGQqiijOVsX+sz1WY6CwViYweh3fo0N0VUznmTGVQCJzQ@mail.gmail.com>
References: <20130629035155.GA7975@gmail.com>
	<CANP1eJGJ4eAn1BtXSnKLu5egDAtK5DFAX9S1nWtBFnbLKWDtJA@mail.gmail.com>
	<CANP1eJGouH+_FXEbaRsrqt1QMY5HEPj6bLV2Pw7LhY5v37Hapw@mail.gmail.com>
	<11954.1372792498@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44260 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab3GBTUO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jul 2013 15:20:14 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so13174973ieb.38
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jul 2013 12:20:13 -0700 (PDT)
In-Reply-To: <11954.1372792498@warthog.procyon.org.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-cachefs@redhat.com

David,

I just looked and saw that it's been pulled a couple hours ago.

Can I also trouble you into looking at my patches for Ceph for the
FSCache? We're using it (in production starting today actually); we're
not able to find any bugs with the current iteration. But it's always
nice to have an extra pair of eyes (esp from the maintainer of
FSCache).

Thanks for everything David,
-- Milosz

On Tue, Jul 2, 2013 at 3:14 PM, David Howells <dhowells@redhat.com> wrote:
> Milosz Tanski <milosz@adfin.com> wrote:
>
>> Now that 3.10 is out I hope that David Howell's fscache improvement
>> branch will go into the next kernel.
>
> It has just been pulled.
>
> David
