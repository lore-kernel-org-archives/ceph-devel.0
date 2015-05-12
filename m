From: Gregory Farnum <greg@gregs42.com>
Subject: Re: cephfs task: Extend file layout ceph_file_layout to specify a
 namespace id
Date: Tue, 12 May 2015 10:48:14 -0700
Message-ID: <CAC6JEv8gp-GAiFaOt1BFGnPMmd5F0OGNBwnV=9bUHZ8xAhgRow@mail.gmail.com>
References: <55523B95.9010005@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35651 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933003AbbELRsP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 13:48:15 -0400
Received: by igbyr2 with SMTP id yr2so115606676igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 10:48:15 -0700 (PDT)
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com. [209.85.223.171])
        by mx.google.com with ESMTPSA id rr5sm614160igb.7.2015.05.12.10.48.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 10:48:14 -0700 (PDT)
Received: by iecmd7 with SMTP id md7so8572167iec.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 10:48:14 -0700 (PDT)
In-Reply-To: <55523B95.9010005@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, jashank42@gmail.com, nishtha3rai@gmail.com

On Tue, May 12, 2015 at 10:42 AM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> Hi,
>
> The task mentioned in $SUBJECT is a part of the multi-tenancy cephfs
> project. Has someone taken the task as yet? If not, I am interested in
> working on the task.

We've got a few GSoC students who will be working on multi-tenancy
issues and we'd expected this to be one of the things they do, but I
don't think any work has started on it yet so if you wanted to claim
that feature it should be all good.
-Greg
