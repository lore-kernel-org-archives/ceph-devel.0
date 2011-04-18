From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Suicide
Date: Mon, 18 Apr 2011 14:21:07 -0700
Message-ID: <CB9E56C259C44656B7B9DD670A548B8A@gmail.com>
References: <4DA85AA6.8050707@provocation.net>
 <3704E18884CB47E081E09984151ACC7B@gmail.com>
 <4DA8C8FB.5050106@provocation.net>
 <161F0A2E50F1465996C6A9075A508C85@gmail.com>
 <4DA8D4EF.8090006@provocation.net>
 <25103BE141804650A169B6444F0D6D21@gmail.com>
 <4DAA2B38.1090706@provocation.net>
 <BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:48175 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab1DRVVL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 17:21:11 -0400
Received: by pxi2 with SMTP id 2so3676116pxi.10
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 14:21:10 -0700 (PDT)
In-Reply-To: <BANLkTi=rdcyUu_7PwFc0nRbYs-V=tr+V8Q@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

I looked through your logs a bit and noticed that the OSD on node01 is crashing due to high latencies on disk access (I think the defaults for this case are it asserts out if there's no progress after 10 minutes or something). 

Based on that, I pretty much have to guess that there's just too much stress on your disk and it's going to cause problems. You can try loosening the various configurable timeouts to let it run longer but it seems like really you just need beefier disks for the amount of stuff you're doing to them. IIRC you're running a monitor and an OSD on the same 2.5" physical disk, which means they're colliding on stuff like sync() calls.

This general slowness doesn't explain the mds log corruption, although it might be one of the trigger conditions. I added another assert in the Journaler code which might have caused the problem (though I don't think it could have) but don't have any other new ideas.
-Greg



