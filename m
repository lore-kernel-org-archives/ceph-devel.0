From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [PATCH] rbd: don't zero-fill non-image object requests
Date: Wed, 27 Mar 2013 17:26:15 +0100
Message-ID: <CABZ+qqkVnj3qrKyhOmOX=vAn67Xjq1oKUFcPyCruT591qthYYQ@mail.gmail.com>
References: <5153020B.7050403@inktank.com> <alpine.DEB.2.00.1303270909380.20593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:51825 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3C0Q1B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Mar 2013 12:27:01 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so16040755lab.29
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 09:26:59 -0700 (PDT)
Received: by mail-la0-f51.google.com with SMTP id fo13so16063594lab.10
        for <ceph-devel@vger.kernel.org>; Wed, 27 Mar 2013 09:26:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303270909380.20593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Mar 27, 2013 at 5:10 PM, Sage Weil <sage@inktank.com> wrote:
> Does this only affect the current -rc or is this problem older than that?

The BUG I reported that triggered this was on 3.8.4.
--
Dan
