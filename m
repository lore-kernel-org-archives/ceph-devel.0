From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: OSD crashes
Date: Tue, 11 Oct 2011 11:09:25 -0700
Message-ID: <CAF3hT9DhMjW1c0px4S_CJFWokFd0Mp1TW_3nhj7FcmXTRCEaoQ@mail.gmail.com>
References: <CAO47_-8wgyvuYzB584WYCg-RArDAN=14_gp8wqEy2fUwuwELNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48303 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab1JKSJ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 14:09:26 -0400
Received: by iaek3 with SMTP id k3so1024908iae.19
        for <ceph-devel@vger.kernel.org>; Tue, 11 Oct 2011 11:09:26 -0700 (PDT)
In-Reply-To: <CAO47_-8wgyvuYzB584WYCg-RArDAN=14_gp8wqEy2fUwuwELNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 11, 2011 at 9:02 AM, Christian Brunner <chb@muc.de> wrote:
> Here is another one...
>
> I've now run mkcephfs and started importing all our data from a
> backup. However after two days, two of our OSDs are crashing right
> after the start again.
>
> It all started with a "hit suicide timeout". Now I can't start it any
> longer. Here is what I have in the logs. I'm sending the complete log
> because I' getting different messages.
This has a few interesting things, but it looks like it doesn't have
all the entries -- are you using syslog over UDP by any chance?
-Greg
