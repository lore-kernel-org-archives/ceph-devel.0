From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Quota function of radosgw
Date: Fri, 27 May 2011 09:13:50 -0700
Message-ID: <BANLkTikaeMSQ1PVoAopSxeqB5pmELuzGow@mail.gmail.com>
References: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:55872 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab1E0QNw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 12:13:52 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 6A36CC47B
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 09:13:52 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 16D31C458
	for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 09:13:51 -0700 (PDT)
Received: by eyx24 with SMTP id 24so713781eyx.19
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2011 09:13:50 -0700 (PDT)
In-Reply-To: <BANLkTikpoxS6ZzPJ6q9iUD9etawm24rApQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylar Shen <kimulaaa@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 27, 2011 at 9:06 AM, Sylar Shen <kimulaaa@gmail.com> wrote:
> Hi developers,
> Recently I am testing radosgw about its functions.
> Then I am curious that will radosgw implement the function or API of
> quota in the future?
> I've checked the mail archives and found that the quota issue had been
> discussed.
> And also, I know this may affect the performance of write ability.
> But in most cases, administrator may want to set the quota of a bucket
> for every user.
> So would this function be implemented in the future?
We're unlikely to implement quotas in the gateway. It's an
S3-compatible implementation and S3 has no concept of limits -- the
more space users take up, the more money the provider can charge them!
;)
Previous discussions of quotas have centered more on the full
filesystem, which is technically challenging for a number of reasons,
although I think the Tcloud guys have done some work on that.
I don't think it would be too difficult to implement a working
solution for the *gateway* layer on your own, though...


> On another hand, I know that the kernel of Ceph upgrades gradually.
> I would like to know that will the performance of Ceph client and
> re-exporting NFS become better if I upgrade the kernel to the latest
> version?
The kernel client hasn't gone through a lot of updating lately, but
the current rc release will be faster than recent kernels since it
re-enables local dentry lookups (at last!).
NFS re-export is getting more attention lately so it's better than it
used to be, but there aren't a lot of users yet and there are still
some weird performance issues that you'll run across in any version of
it.
-Greg
