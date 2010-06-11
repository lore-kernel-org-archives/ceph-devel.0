From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: 2.6.34 soft lockup - CPU#1 stuck for 61s!
Date: Thu, 10 Jun 2010 17:11:14 -0700
Message-ID: <AANLkTil5rDlFX56U8ohpLxBfVyiXJXl3PaYnKgwESRnU@mail.gmail.com>
References: <4C110BBD.7070402@watson.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64273 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759924Ab0FKALP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jun 2010 20:11:15 -0400
Received: by pwi1 with SMTP id 1so150923pwi.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jun 2010 17:11:15 -0700 (PDT)
In-Reply-To: <4C110BBD.7070402@watson.wustl.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Weil <mweil@watson.wustl.edu>
Cc: ceph-devel@vger.kernel.org

That usually happens when there's some pending request that waits too
long. It's really hard to tell what exactly happened from this log as
for some reason we don't see the expected backtrace.

Yehuda

On Thu, Jun 10, 2010 at 8:58 AM, Matt Weil <mweil@watson.wustl.edu> wrote:
> anyone seen this?
>
> ceph client
>
