From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: moving towards release criteria
Date: Mon, 28 Nov 2011 16:38:55 -0800
Message-ID: <CAORUGqDLasFGN=OH_RuU2W37H6_K54AS3zYC6kxMuLfWp1djGg@mail.gmail.com>
References: <4ED3DA82.7030506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49081 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab1K2AjR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 19:39:17 -0500
Received: by eaak14 with SMTP id k14so2423109eaa.19
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2011 16:39:16 -0800 (PST)
In-Reply-To: <4ED3DA82.7030506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Nov 28, 2011 at 11:01, Mark Kampe <mark.kampe@dreamhost.com> wrote:
> Does this seem like the right general form for our release criteria? What
> changes would you suggest?

As long as we're blue-skying ;) -- at some point we should automate
tests for upgrades.

Simple first iteration: install previous release, add data, upgrade,
test functionality, test previous data is accessible
(multiply by access method: rados, rgw, rbd, cephfs fuse, cephfs kernel client)

Later:
To release x.y, upgrades from x.(y-1) and x.0 must work.
To release x.0, upgrades from (x-1).0 and (x-1).latest must work.
If these upgrades are not supported, release notes must say so.

Even later:
Test functionality *during* the upgrade.

Even more laterer:
Test extended cross-version compatibility, as in old-osd talks to
new-mon, or don't upgrade clients at all, etc..
