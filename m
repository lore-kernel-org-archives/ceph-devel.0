From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: config on mons
Date: Mon, 13 Nov 2017 11:27:23 +1100
Message-ID: <CA+2bHPYhJ8eGQje_YyDL0QMrjmy09ff2DkXor4_VF6KcxA7dmQ@mail.gmail.com>
References: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:55571 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKMA1z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Nov 2017 19:27:55 -0500
Received: by mail-qk0-f182.google.com with SMTP id d125so3331898qkc.12
        for <ceph-devel@vger.kernel.org>; Sun, 12 Nov 2017 16:27:55 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1711101521180.23234@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Nov 11, 2017 at 2:30 AM, Sage Weil <sweil@redhat.com> wrote:
> - What about ceph.conf?  My thought here is to mark which options are
> legal for bootstrap (i.e., used during the initial connection to mon to
> authenticate and fetch config), and warn on anything other than that in
> ceph.conf.  But what about after you connect?  Do these options get reset
> to default?

Perhaps we should deprecate ceph.conf and mandate an alternate
bootstrap file for connecting to the mons.

-- 
Patrick Donnelly
