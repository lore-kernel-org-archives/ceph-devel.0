From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: why index (collectionIndex) need a lock?
Date: Tue, 30 Sep 2014 16:36:09 -0700
Message-ID: <CA+Hcz5-6=yLTm+niJGp1TJHmPGjAZtsf9Li9iHj=eGe-mCATdA@mail.gmail.com>
References: <CALZt5jwhBNifcagmsGBZiEC99Q0TvDFPy45f05hidVZedKEK-w@mail.gmail.com>
	<CAPYLRzg=y1YKsZAACdwT08UiSVf_wZ8G1TFa7MYLOu8xV-fZyw@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2784E092@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:43816 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaI3XgK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 19:36:10 -0400
Received: by mail-qc0-f182.google.com with SMTP id i17so19299qcy.41
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 16:36:09 -0700 (PDT)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2784E092@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Gregory Farnum <greg@inktank.com>, Nicheal <zay11022@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 10:42 AM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Also, I don't think this lock has big impact to performance since it is already sharded to index level. I tried with reader/writer implementation of this lock (logic will be somewhat similar to your state concept) and not getting any benefit .

If there is interest in identifying locks that are introducing latency
it might useful to add some tracking features to Mutex and RWLock. A
simple thing would be to just record maximum wait times per lock and
dump this via admin socket.
