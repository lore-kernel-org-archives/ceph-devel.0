From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: inject args and g_conf (was: "Where I can find the
 definition/meanings...")
Date: Thu, 7 Apr 2011 17:29:12 -0700
Message-ID: <3671D55061B844738AD8FCAC9B0D54AE@gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
 <BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
 <BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
 <BANLkTinZmtbDsGzGmtMgO-fgUta-Eyxr5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38839 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757140Ab1DHA3Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 20:29:16 -0400
Received: by iwn34 with SMTP id 34so2983699iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 17:29:15 -0700 (PDT)
In-Reply-To: <BANLkTinZmtbDsGzGmtMgO-fgUta-Eyxr5Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org


On Thursday, April 7, 2011 at 5:21 PM, Colin McCabe wrote:
> I'm also aware that injectargs changes configuration values that other
> threads may be reading, without using a lock or an atomic update. So
> far, this doesn't seem to have created any problems, but it is
> technically incorrect and a worry. Probably the best way to resolve
> it is to construct a full copy of the configuration, change what is
> required, and then do an atomic swap on the g_conf pointer.

I don't think this *can* cause any problems. There are no other writers to g_conf and, while I don't think we have nested checks (ie, branch based on g_conf, then assume g_conf remains static inside branch), even if we did then our single-dispatch mechanism means we're not going to have concurrent updates of that stuff. :) 
