From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: gcov/lcov
Date: Tue, 1 Feb 2011 09:35:29 -0800
Message-ID: <AANLkTi=DFYO9N62v2bpmPVVmpAq17q0H6W6XdWGcizy7@mail.gmail.com>
References: <Pine.LNX.4.64.1101312121050.8040@cobra.newdream.net>
	<20110201172740.GA13828@dreamer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:37112 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab1BARfc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 12:35:32 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4764D27DE8
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 09:35:32 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id ED65CC063
	for <ceph-devel@vger.kernel.org>; Tue,  1 Feb 2011 09:35:31 -0800 (PST)
Received: by ewy5 with SMTP id 5so3269092ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 09:35:30 -0800 (PST)
In-Reply-To: <20110201172740.GA13828@dreamer>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Tue, Feb 1, 2011 at 9:27 AM, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> That has been in the plans from day one. Line & branch coverage are
> awesome tools.
The first time I used Clover I think my team and I spent 2 hours
picking our jaws up off the floor. They don't really discuss that kind
of thing too much in an academic setting, but damn is it useful. I
didn't realize there are any open-source versions that are any good.

> Just focusing on system-level testing right now.. Please write unit
> tests, because otherwise the first coverage reports are going to be
> really disappointing ;)
I think they're going to be disappointing anyway. :/ I wrote unit
tests for the one "unit" that I changed, but I think part of the
appeal of using a tool like this will be helping us decide where in
our old code we should concentrate our efforts.
-Greg
