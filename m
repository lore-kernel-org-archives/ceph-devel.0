From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Braindump: multiple clusters on the same hardware
Date: Thu, 18 Oct 2012 09:47:04 -0700
Message-ID: <CADvuQRF-3ThfrLtDm5fxFBMxa=C1vei3iseMnpBPpw-_sz==Yg@mail.gmail.com>
References: <sfid-H20121017-203541-+031.28-1@marduk.tchpc.tcd.ie>
 <CADvuQREhkrqxm1dMo3XXFpwhtCzC7SM7cK_7+r5HnACGbCnJLw@mail.gmail.com>
 <4F329E1D-EACC-497E-B9E4-445992BA4F35@tchpc.tcd.ie> <A91A18BC-9B52-45E6-953F-7A13B6716275@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:47941 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756258Ab2JRQrZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Oct 2012 12:47:25 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2986979qcr.19
        for <ceph-devel@vger.kernel.org>; Thu, 18 Oct 2012 09:47:24 -0700 (PDT)
In-Reply-To: <A91A18BC-9B52-45E6-953F-7A13B6716275@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: ceph-devel@vger.kernel.org, John Wilkins <john.wilkins@inktank.com>

On Thu, Oct 18, 2012 at 7:40 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> What I actually meant to ask was, is it possible to copy objects or pools from one ceph cluster to another (for disaster recovery reasons) and if this feature is planned or even considered?

That's the "async replication for disaster recovery" feature that has
been mentioned every now and then.

You could build it as "read from one cluster, write to another"
yourself, the client libraries are perfectly able to talk to two
clusters at once. Ceph itself doesn't have that feature currently, but
might in the future. It's definitely on the roadmap, and asked for a
lot.

This has nothing to do with the "many clusters on the same hardware"
feature this thread is about..
