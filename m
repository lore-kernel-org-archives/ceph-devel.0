From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Mon, 20 Jun 2016 16:32:22 +1000
Message-ID: <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl> <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33133 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbcFTGcn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jun 2016 02:32:43 -0400
Received: by mail-vk0-f50.google.com with SMTP id d185so183842775vkg.0
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jun 2016 23:32:42 -0700 (PDT)
In-Reply-To: <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Wade Holler <wade.holler@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On 20 June 2016 at 09:21, Blair Bethwaite <blair.bethwaite@gmail.com> wrote:
> slow request issues). If you watch your xfs stats you'll likely get
> further confirmation. In my experience xs_dir_lookups balloons (which
> means directory lookups are missing cache and going to disk).

Murphy's a bitch. Today we upgraded a cluster to latest Hammer in
preparation for Jewel/RHCS2. Turns out when we last hit this very
problem we had only ephemerally set the new filestore merge/split
values - oops. Here's what started happening when we upgraded and
restarted a bunch of OSDs:
https://au-east.erc.monash.edu.au/swift/v1/public/grafana-ceph-xs_dir_lookup.png

Seemed to cause lots of slow requests :-/. We corrected it about
12:30, then still took a while to settle.

-- 
Cheers,
~Blairo
