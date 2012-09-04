From: Tommi Virtanen <tv@inktank.com>
Subject: Re: radosgw keeps dying
Date: Tue, 4 Sep 2012 09:07:59 -0700
Message-ID: <CADvuQRE5SPyiboP2W3mOx9S7u_=vOpukrobPeJBmna4sHZKP1A@mail.gmail.com>
References: <50430C8602000099000E95E5@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41244 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2IDQIU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 12:08:20 -0400
Received: by yenl14 with SMTP id l14so1270754yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 09:08:20 -0700 (PDT)
In-Reply-To: <50430C8602000099000E95E5@collaborate.seakr.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Sep 2, 2012 at 6:36 AM, Nick Couchman <Nick.Couchman@seakr.com> wrote:
> One additional piece of info...I did find the "-d" flag (documented in the radosgw-admin man page, but not in the radosgw man page) that keeps the daemon in the foreground and prints messages to stderr.  When I use this flag I get the following:
> [root@desktop-ceph ~]# radosgw -c /etc/ceph/ceph.conf -n client.radosgw.gateway -d
> 2012-09-02 07:35:27.495864 423d6940 -1 Initialization timeout, failed to initialize
>
> I'm not sure where it's timing out, though, what it's trying to contact that it cannot.  Any additional help in getting this going would be greatly appreciated!

Try putting in your ceph.conf:

[client.radosgw.gateway]
debug ms = 1

and see if that gives you more information.

The message you are seeing is because this chunk of code takes too long:
https://github.com/ceph/ceph/blob/v0.48.1argonaut/src/rgw/rgw_main.cc#L401-431
