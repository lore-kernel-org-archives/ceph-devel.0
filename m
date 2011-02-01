From: Henry Chang <henry.cy.chang@gmail.com>
Subject: Re: some thoughts about scrub
Date: Tue, 1 Feb 2011 17:20:34 +0800
Message-ID: <AANLkTimkx4CuZqE2dHgS-9iKy9F=B-C+QDjQO_qAOnB8@mail.gmail.com>
References: <AANLkTi=zk=cHU1YDDrFqq2gUmiDcxWpAX+mn3U-dP4fW@mail.gmail.com>
	<20110131215819.f0537c57.ctpm@ist.utl.pt>
	<AANLkTinJ7q5tFzQfoJaSvopaJpHrqxoBbKoxNMgKD70n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36868 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868Ab1BAJUg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Feb 2011 04:20:36 -0500
Received: by ewy5 with SMTP id 5so2977371ewy.19
        for <ceph-devel@vger.kernel.org>; Tue, 01 Feb 2011 01:20:34 -0800 (PST)
In-Reply-To: <AANLkTinJ7q5tFzQfoJaSvopaJpHrqxoBbKoxNMgKD70n@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

2011/2/1 Gregory Farnum <gregf@hq.newdream.net>:
> I don't think scrub is ever going to go away. It can't do much to fix
> errors right now, and it can't be certain about correctness, but all
> these things can be added to it. It shouldn't be considered much more
> than a stub right now; that was certainly what we said when we wrote
> the code that exists right now. We will eventually add checksumming
> (so we can make sure that files of the same size have the same data,
> etc) and other features to make it more useful than it is right now.
> -Greg

Yeah. I expect that scrub can both detect disk errors and check data
integrity (based on the checksum) in the background. For disk errors,
I would like CEPH to mark the OSD down/failed and notify the sys
admin immediately. For data errors, I expect that CEPH can repair
them automatically (by fetching a right copy from other replicas).

-- 
Henry Chang
