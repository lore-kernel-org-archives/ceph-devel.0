From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: [ceph-users] Opensource plugin for pulling out cluster recovery
 and client IO metric
Date: Fri, 28 Aug 2015 12:07:39 +0100
Message-ID: <CAJ4mKGbOm8DMyPCzi_NFKVYBrnSW4UvGWuWB_EBp69Oc4tdSaQ@mail.gmail.com>
References: <CALL4jwPkeHemknEWypgTzAE7kSa9F+pyZZQUWJwYFY6OQWTFbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32912 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbbH1LHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 07:07:40 -0400
Received: by wieo17 with SMTP id o17so11729789wie.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2015 04:07:39 -0700 (PDT)
In-Reply-To: <CALL4jwPkeHemknEWypgTzAE7kSa9F+pyZZQUWJwYFY6OQWTFbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vickey Singh <vickey.singh22693@gmail.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, ceph-users <ceph-users@ceph.com>, ceph-devel@vger.kernel.org

On Mon, Aug 24, 2015 at 4:03 PM, Vickey Singh
<vickey.singh22693@gmail.com> wrote:
> Hello Ceph Geeks
>
> I am planning to develop a python plugin that pulls out cluster recovery IO
> and client IO operation metrics , that can be further used with collectd.
>
> For example , i need to take out these values
>
> recovery io 814 MB/s, 101 objects/s
> client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s
>
>
> Could you please help me in understanding how ceph -s  and ceph -w outputs
> prints cluster recovery IO and client IO information.
> Where this information is coming from. Is it coming from perf dump ? If yes
> then which section of perf dump output is should focus on. If not then how
> can i get this values.
>
> I tried ceph --admin-daemon /var/run/ceph/ceph-osd.48.asok perf dump , but
> it generates hell lot of information and i am confused which section of
> output should i use.

This information is generated only on the monitors based on pg stats
from the OSDs, is slightly laggy, and can be most easily accessed by
calling "ceph -s" on a regular basis. You can get it with json output
that is easier to parse, and you can optionally set up an API server
for more programmatic access. I'm not sure on the details of doing
that last, though.
-Greg
