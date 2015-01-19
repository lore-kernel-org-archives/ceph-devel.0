From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: ./os/ObjectStore.h: 598: FAILED assert(op->oid < om.size())
Date: Tue, 20 Jan 2015 00:07:51 +0800
Message-ID: <CAMm-wcLbqVoFZD81R=Sn7b0Q65U56bt1nxeot3VVr1QTV66uPw@mail.gmail.com>
References: <alpine.DEB.2.00.1501190739500.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:50421 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbASQHw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Jan 2015 11:07:52 -0500
Received: by mail-vc0-f180.google.com with SMTP id im6so10460852vcb.11
        for <ceph-devel@vger.kernel.org>; Mon, 19 Jan 2015 08:07:51 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501190739500.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes, I am working on it since last week.

This seems the same problem which I fix in the ReplicatedPG. So I try
to fix it following the same way which I did in the ReplicatedPG, but
it break the make_check test_erasure_code.sh.

Now I am working on the test case, but unfortunately I am not familiar
with the impl of EC, so it will take me more time.

On 19 January 2015 at 23:41, Sage Weil <sweil@redhat.com> wrote:
> Hi,
>
> This has come up a couple times in QA since we merged the fast transaction
> code.  Can you take a look?
>
>         http://tracker.ceph.com/issues/10517
>
> Ping me if it will help to get access to the test cluster.  Haomai has
> access, and you can get the logs via http (linked from pulpito.ceph.com),
> but it is less convenient.
>
> Thanks!
> sage



-- 
Dong Yuan
Email:yuandong1222@gmail.com
