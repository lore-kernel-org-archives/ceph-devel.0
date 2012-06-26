From: Tommi Virtanen <tv@inktank.com>
Subject: Re: reproducable osd crash
Date: Tue, 26 Jun 2012 09:05:22 -0700
Message-ID: <CADvuQRGS4xCyxbYVPNNPVyc4dZQVgnDXbHcTkKf0ZbscPCjewA@mail.gmail.com>
References: <4FE319DF.3020106@profihost.ag> <B37E1F82-25E3-4ED4-B3E9-59BC2EC44CB6@profihost.ag>
 <4FE4F806.1080501@inktank.com> <CA+4uBUb9WVk7-htq_qBNF-T_8i4-3KEsJePhTYoAHXuXfyOuKA@mail.gmail.com>
 <7855C271-3A73-4090-9F5F-2F4FB12C4E73@profihost.ag> <B8C4CA17-911D-4BA4-BE1D-4E81168A4212@inktank.com>
 <4FE89DB0.1080606@profihost.ag> <4FE8D1BF.3090108@inktank.com>
 <4FE8D5B5.8050902@profihost.ag> <4FE8FE36.6080001@inktank.com>
 <7F6C4684-EE9F-419D-B812-DFF1C498C36B@profihost.ag> <0F9BBB6D-F537-4C17-8E05-91931D89199D@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63099 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866Ab2FZQFq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 12:05:46 -0400
Received: by pbbrp8 with SMTP id rp8so255201pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 09:05:46 -0700 (PDT)
In-Reply-To: <0F9BBB6D-F537-4C17-8E05-91931D89199D@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Dan Mick <dan.mick@inktank.com>, Sam Just <sam.just@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 25, 2012 at 10:48 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Strange just copied /core.hostname and /usr/bin/ceph-osd no idea how this
> can happen. For building I use the provided Debian scripts.

Perhaps you upgraded the debs but did not restart the daemons? That
would make the on-disk executable with that name not match the
in-memory one.
