From: Tommi Virtanen <tv@inktank.com>
Subject: Re: problems with ceph.init / etc/hosts and ceph.conf
Date: Wed, 20 Jun 2012 09:39:40 -0700
Message-ID: <CADvuQRHGoXx4aMMfvyYeLpVKp2Vh7kyzZ1qWjhBSfrs8AMasTQ@mail.gmail.com>
References: <4FE1910A.3020708@profihost.ag> <4FE1943B.5060806@widodh.nl> <4FE195DE.50108@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:52556 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab2FTQkB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jun 2012 12:40:01 -0400
Received: by dady13 with SMTP id y13so10053487dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 20 Jun 2012 09:40:00 -0700 (PDT)
In-Reply-To: <4FE195DE.50108@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 20, 2012 at 2:20 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
>> What does hostname | cut -d . -f 1 say?
>
> It says ssdstor000i as the machine defaults to it's public IP.
>
> Whouldn't it make sense to go through all aliases set in /etc/hosts which
> point to a local IP?

Actually, the short hostname of the machine is completely unrelated to
what IP addresses etc it has. The hostname is a configurable string.
We treat it as such -- it's just expected to be a unique identifier
for the host.

There's no nice, reliable way to look up aliases that point to a local
IP. /etc/hosts is meant to be accessed through a library that also
uses DNS, and you really don't want to tie your daemon startup to DNS
availability and functioning.
