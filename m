From: Wido den Hollander <wido@widodh.nl>
Subject: Re: moving towards release criteria
Date: Tue, 29 Nov 2011 20:14:04 +0100
Message-ID: <4ED52EFC.2090903@widodh.nl>
References: <4ED3DA82.7030506@dreamhost.com> <CAORUGqDLasFGN=OH_RuU2W37H6_K54AS3zYC6kxMuLfWp1djGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:37215 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab1K2TOH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Nov 2011 14:14:07 -0500
In-Reply-To: <CAORUGqDLasFGN=OH_RuU2W37H6_K54AS3zYC6kxMuLfWp1djGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Mark Kampe <mark.kampe@dreamhost.com>, ceph-devel@vger.kernel.org

Hi,

On 11/29/2011 01:38 AM, Tommi Virtanen wrote:
> On Mon, Nov 28, 2011 at 11:01, Mark Kampe<mark.kampe@dreamhost.com>  wrote:
>> Does this seem like the right general form for our release criteria? What
>> changes would you suggest?
>
> As long as we're blue-skying ;) -- at some point we should automate
> tests for upgrades.
>

You could try to couple this to a specific version?

> Simple first iteration: install previous release, add data, upgrade,
> test functionality, test previous data is accessible
> (multiply by access method: rados, rgw, rbd, cephfs fuse, cephfs kernel client)
>

Starting with version 0.40

> Later:
> To release x.y, upgrades from x.(y-1) and x.0 must work.

Version 0.60 and later

> To release x.0, upgrades from (x-1).0 and (x-1).latest must work.

Version 0.80 and later

> If these upgrades are not supported, release notes must say so.
>
> Even later:
> Test functionality *during* the upgrade.
>

Version 0.90 and later

> Even more laterer:
> Test extended cross-version compatibility, as in old-osd talks to
> new-mon, or don't upgrade clients at all, etc..

Version 1.0

Since v1.0 would become the "stable" version you might expect users 
upgrading while maintaining their data.

Does this seem reasonable?

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
