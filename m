From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: RBD layering needs to work across pools
Date: Fri, 16 Dec 2011 15:40:35 -0800
Message-ID: <CAORUGqAudf68yWzQhgFND1Dh1sxM2ArUitbn_s16acsS2W29wQ@mail.gmail.com>
References: <CAORUGqBWQ5Sm1npyq4Jh0eoEHCmNz+Rb1jE+mOrT8KGM+A=CwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38026 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1LPXk6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 18:40:58 -0500
Received: by wgbdr13 with SMTP id dr13so7030678wgb.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2011 15:40:57 -0800 (PST)
In-Reply-To: <CAORUGqBWQ5Sm1npyq4Jh0eoEHCmNz+Rb1jE+mOrT8KGM+A=CwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <josh.durgin@dreamhost.com>

On Fri, Dec 16, 2011 at 14:48, Tommi Virtanen
<tommi.virtanen@dreamhost.com> wrote:
> To support this, we'd need to make sure the RBD layering we're
> building is able to use base images in a separate pool. (And handle
> the ugly case where after a misconfiguration the client can't access
> the base image anymore...)
>
> Josh, can you say whether that falls in line with what's been planned
> for the layering?

Nevermind, I see parent_{pool, image_id, snap_id} in
http://tracker.newdream.net/issues/1772

Just keep that in mind as a hard requirement.
