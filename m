From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: libceph: get_reply unknown tid
Date: Thu, 26 May 2011 13:37:50 -0400
Message-ID: <BANLkTimva3_LFr5q3T9UvpfOysS69VzrYA@mail.gmail.com>
References: <4DD681C8.1060003@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:51562 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1EZRhw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 May 2011 13:37:52 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id AB675C3CB
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:37:52 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5CE92C3AE
	for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:37:52 -0700 (PDT)
Received: by eyx24 with SMTP id 24so371702eyx.19
        for <ceph-devel@vger.kernel.org>; Thu, 26 May 2011 10:37:51 -0700 (PDT)
In-Reply-To: <4DD681C8.1060003@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Fri, May 20, 2011 at 10:59 AM, Fyodor Ustinov <ufm@ufm.su> wrote:
> Hi!
>
> How should I respond to the message "libceph: get_reply unknown tid 68724
> from osd0" in syslog?

That means something in the messaging layers got a bit busted, and you
should generally respond by filing bug reports. :) What version are
you on right now? I think we fixed some issues with this a couple
weeks ago.
-Greg
