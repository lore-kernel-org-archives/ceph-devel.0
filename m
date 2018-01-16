From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: mon config commands
Date: Tue, 16 Jan 2018 09:14:36 -0700
Message-ID: <AF55FDB3-3330-4504-A151-34A5CB608188@redhat.com>
References: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pl0-f51.google.com ([209.85.160.51]:40929 "EHLO
        mail-pl0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750790AbeAPQOj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jan 2018 11:14:39 -0500
Received: by mail-pl0-f51.google.com with SMTP id g18so902548plo.7
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jan 2018 08:14:39 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801112044230.23413@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org


> On Jan 11, 2018, at 2:21 PM, Sage Weil <sage@redhat.com> wrote:
> 
> Hi everyone,
> 
> Here's the current state of the mon config commands for mimic.  These are 
> pretty close to being "done" so please review carefully!

Hi Sage,

Could we have a ‘ceph config search’ to do a substring search for a parameter name? Or could we have ‘ceph config show’ dump all substring matches if the argument isn’t an exact match for a parameter?

Cheers,
—Doug