From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph 0.23.2 Consolidated questions
Date: Tue, 18 Jan 2011 11:54:41 -0800
Message-ID: <AANLkTimrXeUnWTPpOGvNFVFRNv=jb9g=Yn3hK=cBYwst@mail.gmail.com>
References: <AANLkTi=Xhqo1ASC6ddN4VL2wcjr2HsT+a=utKwjBoqF-@mail.gmail.com>
	<AANLkTi=+L0EPKip8TuyeKGBAhEth8Fd-x0WPgfui_d+G@mail.gmail.com>
	<AANLkTim6KkUoPY-c_kbcKvc80raG+6gDU4ouu7WBcf9n@mail.gmail.com>
	<AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39024 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab1ARTym (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 14:54:42 -0500
Received: by eye27 with SMTP id 27so3512021eye.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jan 2011 11:54:41 -0800 (PST)
In-Reply-To: <AANLkTi=E5mLSxwv9bxYj+wXyGsSa_MDev5aLFMMqtm4B@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: DongJin Lee <dongjin.lee@auckland.ac.nz>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Jan 17, 2011 at 10:53 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Sun, Jan 16, 2011 at 8:04 PM, DongJin Lee <dongjin.lee@auckland.ac.nz> wrote:
>> I find that the journal sizes are consistent up to about 2040, after
>> things starts to get weird.
>> So this is what I get when I set journal size
>> size 1000 - 1 GB
>> size 2000 - 2 GB
>> size 2050 - 0 MB
>> size 2500 - 0 MB
>> size 3000 - 0 MB
>> size 4000 - 0 MB
>> size 5000 - 904 MB
>> size 10000 - 1.8 GB
>> when journal gets the 0 MB then I obviously get the 'unable to open
>> superblock' error.
> Hmmm, I'll try and look into this a bit, or get somebody else to do so.
Are you running on 32-bit machines? It looks like we're accidentally
overflowing a 32-bit value, but I don't have any 32-bit machines handy
to test it on. Please apply the patch at http://pastebin.com/yahTxRzQ,
recompile, and let me know if you still have journal size issues. :)
-Greg
