From: Samuel Just <sjust@redhat.com>
Subject: Re: new async messenger crash
Date: Mon, 18 Jul 2016 09:37:03 -0700
Message-ID: <CAN=+7FWg8n7CAF3kKajZ3SdyFrxiiG9xHC6nGXm5zch=LWw_3g@mail.gmail.com>
References: <CAN=+7FUY4QD+119vMYHpkb99x_NWgO9BxdJ_sHVcUWNpwK503g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33266 "EHLO
	mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbcGRQiD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 12:38:03 -0400
Received: by mail-qt0-f173.google.com with SMTP id w38so94742340qtb.0
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 09:38:02 -0700 (PDT)
In-Reply-To: <CAN=+7FUY4QD+119vMYHpkb99x_NWgO9BxdJ_sHVcUWNpwK503g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Also a recursive lock crash: http://tracker.ceph.com/issues/16715
-Sam

On Mon, Jul 18, 2016 at 9:25 AM, Samuel Just <sjust@redhat.com> wrote:
> I'm seeing a new async messenger segfault: http://tracker.ceph.com/issues/16714
> -Sam
