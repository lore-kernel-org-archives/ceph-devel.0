From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] ceph zstd not for bluestor due to performance
 reasons
Date: Thu, 26 Oct 2017 11:59:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710261159150.22592@piezo.us.to>
References: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag> <alpine.DEB.2.11.1710251940520.22592@piezo.us.to> <5cf6f721-05ea-4e38-a6b9-04cff5d6aad3@profihost.ag> <CACJqLyYsJ8WeWOdu4M2K7bnCbQ=fh8jQ=MP=msa64jo5=fic0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:35537 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdJZL7e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 07:59:34 -0400
In-Reply-To: <CACJqLyYsJ8WeWOdu4M2K7bnCbQ=fh8jQ=MP=msa64jo5=fic0w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, ceph-devel@vger.kernel.org, ceph-users@lists.ceph.com

On Thu, 26 Oct 2017, Haomai Wang wrote:
> in our test, lz4 is better than snappy

Let's switch the default then?

sage
