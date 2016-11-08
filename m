From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: master branch merges must pass unit tests
Date: Tue, 8 Nov 2016 16:56:06 -0500
Message-ID: <CA+2bHPY=GQ-mXi_GpanXRefTmtrZxAee_eMATUpO-W+QhRpSZw@mail.gmail.com>
References: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38367 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbcKHV4i (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 16:56:38 -0500
Received: by mail-it0-f42.google.com with SMTP id q124so235589962itd.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 13:56:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1611082147590.29278@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2016 at 4:49 PM, Sage Weil <sweil@redhat.com> wrote:
> I enabled the github check that the unit tests pass in order to merge to
> master.  These tests still aren't completely reliable, but they're close,
> and we'll make better progress if we start enforcing it now.
>
> Note that core developers can still override the check to merge if
> it's necessary, but I encourage you to avoid doing so!

Does this effect manual merges?

-- 
Patrick Donnelly
