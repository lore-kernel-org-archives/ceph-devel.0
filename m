From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Status of cephfs / multiple mds
Date: Wed, 22 Jun 2016 13:19:43 -0700
Message-ID: <CAJ4mKGbu9msZSGwyr24cmw=MwUeJ4chVAA2P=BDY=j+abnt2Tw@mail.gmail.com>
References: <576A1B71.6030300@wyraz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35616 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFVUUM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 16:20:12 -0400
Received: by mail-vk0-f54.google.com with SMTP id j2so77455856vkg.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 13:19:45 -0700 (PDT)
In-Reply-To: <576A1B71.6030300@wyraz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Wyraz <michael@wyraz.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 21, 2016 at 10:00 PM, Michael Wyraz <michael@wyraz.de> wrote:
> Hello,
>
> I'm curious what is the current state of the stability of cephfs when
> using multiple mds and/or snapshots. It seems that the "Early Adaptors"
> documentation has not changed since hammer, about 1 year ago. We have 2
> major releases and many releases meanwhile. SO probably things have
> changed and there is more experience. Is it save now to run cephfs with
> more than 1 active mds?

It hasn't materially changed since that documentation was created.
We've been focusing on repair tools and single-MDS stability since
that time. We're working on doing some comprehensive planning for the
future, and it looks like multi-MDS is going to be our next big
thing...but we're not done yet and that could change. In the
meanwhile, we've actually locked multi-mds down much more so you can't
turn it on by mistake, or hide that you've done so in debugging. :P

If it *is* our next big thing, we're hoping to be ready for Luminous
beginning-mid next year, but we really don't know if that's realistic
or not.
-Greg
