From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Where I can find the definition/meanings of options parameter in /src/common/config.cc
Date: Thu, 7 Apr 2011 10:09:14 -0700
Message-ID: <BANLkTinJ2dbPLnp8yP6eS2tPDXNC0as7cw@mail.gmail.com>
References: <BANLkTi=WToqoND0BwkH-VMbC+muYSen3aQ@mail.gmail.com>
	<BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56504 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400Ab1DGRJP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Apr 2011 13:09:15 -0400
Received: by iwn34 with SMTP id 34so2657226iwn.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Apr 2011 10:09:14 -0700 (PDT)
In-Reply-To: <BANLkTikJXmVe08qzVDryXye9VAS71xwnsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: AnnyRen <annyren6@gmail.com>, ceph-devel@vger.kernel.org

On Thu, Apr 7, 2011 at 9:33 AM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
> Hi AnnyRen,
...
> Also, after using injectargs to change a setting related to logging,
> you must send the process a SIGHUP to get it to re-read its logging
> settings.

I assume this is a relatively new requirement? Usually you'd send HUP
signal to re-read the conf file. When using injectargs, one would
assume that the new configuration was already updated. Moreover,
sending HUP signal to all your osds/mds/mons is awfully inconvenient.
Maybe we can just send the HUP signal in the appropriate handlers?

Yehuda
