From: Tommi Virtanen <tv@inktank.com>
Subject: Re: The cluster do not aware some osd are disappear
Date: Wed, 1 Aug 2012 08:57:49 -0700
Message-ID: <CADvuQRFHBG+kEvAndqDv5c12SYaMWs_z1GsZdUiXMkQiD+p25Q@mail.gmail.com>
References: <60E83269D669544E8069A09CB69135EA011D62@GDC-CLDMBX-P02.whq.wistron>
 <5018515D.7000909@inktank.com> <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60861 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab2HAP6K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 11:58:10 -0400
Received: by vbbff1 with SMTP id ff1so7111929vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 08:58:10 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA012278@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: josh.durgin@inktank.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On Tue, Jul 31, 2012 at 6:07 PM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Hi, Josh:
>
> I do not assign the crushmap by myself, I use the default setting.
> And after I reboot the server, I cannot reproduce this situation.
> The heartbeat check works fine when one of the server not available.

If you don't do anything to your crushmap, all yours osds are in a
flat tree, with no understanding of your failure domains. You really
should configure it. (We really should document it better!)

The newer upstart scripts (/etc/init/ceph-osd.conf instead of
/etc/init.d/ceph) at least set the hostname by default, but that still
ignores racks, rooms etc.
