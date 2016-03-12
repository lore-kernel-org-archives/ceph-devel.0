From: Giridhar Yasa <giridhar.yasa@flipkart.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Sun, 13 Mar 2016 01:37:17 +0530
Message-ID: <CAKP7xVyMGJO-8YjkqhhFPoiY_608ByKY8+c_Y=7W-tcmDBADsg@mail.gmail.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
	<alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36576 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbcCLUHS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Mar 2016 15:07:18 -0500
Received: by mail-ob0-f173.google.com with SMTP id m7so143122779obh.3
        for <ceph-devel@vger.kernel.org>; Sat, 12 Mar 2016 12:07:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Shehbaz Jaffer <shehbazjaffer007@gmail.com>, ceph-devel@vger.kernel.org

On Fri, Mar 11, 2016 at 8:20 PM, Sage Weil <sweil@redhat.com> wrote:
>
> On Fri, 4 Mar 2016, Shehbaz Jaffer wrote:
>
> > 2) Will scope of project be to build an allocator on a simulator for
> > SMR Drives? Or will I get actual HDDs to work with? In case of
> > simulators, will the project involve building a simulator on disksim?
>
> I seem to remember hearing something about a dm module that simulated SMR,
> but I'm not sure.  We may also be able to get some SMR disks to play
> with--I'll reach out to our drive vendor friends.

Would that be https://github.com/hgst/libzbc from HGST?

Giridhar

--
Giridhar Yasa | Flipkart Engineering | http://www.flipkart.com/
