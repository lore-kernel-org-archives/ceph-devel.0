From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: libceph: get_reply unknown tid
Date: Thu, 26 May 2011 22:30:41 +0300
Message-ID: <4DDEAA61.5030201@ufm.su>
References: <4DD681C8.1060003@ufm.su> <BANLkTimva3_LFr5q3T9UvpfOysS69VzrYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:41042 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758454Ab1EZTao (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 15:30:44 -0400
In-Reply-To: <BANLkTimva3_LFr5q3T9UvpfOysS69VzrYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org

On 05/26/2011 08:37 PM, Gregory Farnum wrote:
> That means something in the messaging layers got a bit busted, and you
> should generally respond by filing bug reports.:)  What version are
> you on right now? I think we fixed some issues with this a couple
> weeks ago.
[72845.480649] libceph: get_reply unknown tid 475665 from osd0
[72845.481518] libceph: get_reply unknown tid 475622 from osd0
[72845.482140] libceph: get_reply unknown tid 475618 from osd0
[72845.482725] libceph: get_reply unknown tid 475592 from osd0
[72845.483164] libceph: get_reply unknown tid 475587 from osd0
[72845.483753] libceph: get_reply unknown tid 475570 from osd0
[72846.838239] libceph: get_reply unknown tid 475660 from osd4
[72846.839034] libceph: get_reply unknown tid 475649 from osd4
[72846.840702] libceph: get_reply unknown tid 475610 from osd4
[72846.841548] libceph: get_reply unknown tid 475608 from osd4
[72846.842243] libceph: get_reply unknown tid 475598 from osd4


Ie it happens regularly.

Messages on client (kernel) 2.6.29
ceph - 0.28.1

WBR,
     Fyodor.
