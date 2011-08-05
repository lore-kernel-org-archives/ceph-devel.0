From: Sage Weil <sage@newdream.net>
Subject: Re: ceph native client for windows
Date: Fri, 5 Aug 2011 09:09:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108050908300.12301@cobra.newdream.net>
References: <CAHtqZOf_O9vWeT7Qve=zwsozf37TN0f0OB0sNtWXMCaPPUavfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35641 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753623Ab1HEQFA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Aug 2011 12:05:00 -0400
In-Reply-To: <CAHtqZOf_O9vWeT7Qve=zwsozf37TN0f0OB0sNtWXMCaPPUavfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Qian Wei <hzqianwei@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 5 Aug 2011, Qian Wei wrote:
> Hi friends
>    Anyone has plan to develop a CEPH native client for  Windows, or
> give effective way to provide stroage to Windows user,if you do,
> please share your idea how to design it with us.It's very  meaningful
> to promote ceph developing, and can attract more people to use ceph.
> I'm  really interested in this field, and strive to make it true.

There are patches pending that link samba directly to libceph, allowing 
you to share with windows clients with a clean stack (no kernel 
requirements).  This is your best bet.

sage
