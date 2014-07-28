From: John Spray <john.spray@redhat.com>
Subject: Re: wip-objecter
Date: Tue, 29 Jul 2014 00:23:59 +0100
Message-ID: <CAGd4Wr0JvxUg37cHdvVT+qQ+bDjp2DDn36QW-nDwZ2MddeYtng@mail.gmail.com>
References: <alpine.DEB.2.00.1407251727430.5027@cobra.newdream.net>
	<CAGd4Wr17ds-r8u4ZZfSwptsCV9LV43s206=c_uee5Lp4R7ex3A@mail.gmail.com>
	<alpine.DEB.2.00.1407281437030.4962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:47199 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaG1XX7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 19:23:59 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10756815pdb.27
        for <ceph-devel@vger.kernel.org>; Mon, 28 Jul 2014 16:23:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407281437030.4962@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 28, 2014 at 10:48 PM, Sage Weil <sweil@redhat.com> wrote:
> Anyway, I rebased and resolved conflicts and pushed a new
> wip-objecter-rebased which looks like it has the right diff between the
> old and new versions.
>
> Take a look?  The main change is that the set data pool virtual xattrs do
> objecter->wait_for_latest_osdmap() and the flawed MDS::request_osdmap()
> helper is now gone.

Yep, looks right.  I was going to do about the same squashup once
things were passing unit tests, but I had missed the leak of the
contexts.

John
