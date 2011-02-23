From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: g_conf.id, g_conf.name, g_conf.type and friends
Date: Wed, 23 Feb 2011 14:46:50 -0800
Message-ID: <AANLkTikJKK32aK5EK7sk8-0ii9+AEn21EKo7v4nTGEhA@mail.gmail.com>
References: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59857 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab1BWWqw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2011 17:46:52 -0500
Received: by wwi17 with SMTP id 17so6015186wwi.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2011 14:46:50 -0800 (PST)
In-Reply-To: <AANLkTi=zwxN0RW-gjejEONnvpR+RyVUTdx4mWB1qh=En@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Feb 23, 2011 at 1:58 PM, Colin Patrick McCabe
<colin.mccabe@dreamhost.com> wrote:
>
> Questions:
> * Do we even need g_conf.name any more? We could just call
> g_conf.entity_name.to_str() and get the same thing. (Actually, a
> better thing.)

Yeah, we can either remove it completely or just set it to be the
result of g_con.entity_name.to_str()

> * Should we rename g_conf.type to g_conf.program_name? Program name is
> a clear and unambiguous concept; what we have now is not useful.
> * Should $type expand out to ceph_entity_type_name(g_conf.entity_name.type)?
> In practice, this would bring us back to $type being "auth", "mon",
> "osd", "mds", or "client", etc. again. This seems to be the original
> intention of the system.

I don't think we need g_conf.type anyway.

> * Allowing users to set id is great. Allowing them to set the program
> type seems wrong. Yet there is some evil code lurking in there that
> parses the id parameter and tries to use it to set g_conf.type.
>

I don't see the point of preventing users from changing the type. It
doesn't solve any security issue, and as long as they don't have a key
to match the program type (when cephx is used) it won't help them
much.

Yehuda
