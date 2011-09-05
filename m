From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: projects
Date: Sun, 4 Sep 2011 19:15:02 -0700
Message-ID: <CAB2gnbXvRv66OFH7TXtuqkv9P_+ZykekNZUHRwgDntPggwDQ=A@mail.gmail.com>
References: <Pine.LNX.4.64.1108291206370.14548@cobra.newdream.net>
	<Pine.LNX.4.64.1109031532190.12865@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62773 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1IECPD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Sep 2011 22:15:03 -0400
Received: by vws1 with SMTP id 1so3618948vws.19
        for <ceph-devel@vger.kernel.org>; Sun, 04 Sep 2011 19:15:02 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109031532190.12865@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

> * Clean java libceph bindings. There are some basic libceph Java bindings
> in src/client/hadoopclient that are used by the current hadoop shim. These
> should be cleaned up a bit, moved, and packaged properly to provide
> generic libceph java bindings (of which the hadoop shim would be just one
> user). See http://tracker.newdream.net/issues/814.

Are you thinking that these should live in a new tree?

-Noah
