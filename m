From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 20:06:35 +0200
Message-ID: <4E9C6EAB.7070003@tuxadero.com>
References: <4E974C87.2070204@tuxadero.com> <1318585099.2999.10.camel@wido-laptop> <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com> <4E99E68F.9090005@tuxadero.com> <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com> <4E9C37F8.9050601@tuxadero.com> <Pine.LNX.4.64.1110170820040.22381@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:50251 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1JQSGp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 14:06:45 -0400
In-Reply-To: <Pine.LNX.4.64.1110170820040.22381@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: chb@muc.de, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi Sage,
the hang was on a btrfs, I do not have a fix for that.

The 'filestore flusher = false' does fix the ext4 problems, which where 
reported from Christian, but this option has quite an impact of the osd 
performance.
The '-o noauto_da_alloc' option did not solve the fsck problem.

Best Regards,
  Martin


Sage Weil schrieb:
> On Mon, 17 Oct 2011, Martin Mailand wrote:
>> Am 17.10.2011 11:40, schrieb Christian Brunner:
>>> Our bugreport with RedHat didn't make any progress for a long time,
>>> but last week RedHat made two sugestions:
>>>
>>> - If you configure ceph with 'filestore flusher = false', do you see
>>> any different behavior?
>>> - If you mount with -o noauto_da_alloc does it change anything?
>> Hi,
>> after a quick test I think 'filestore flusher = false' did the trick.
>> What does it do?
> 
> It fixes your hang (previous email), or the subsequent fsck errors?
> 
> When filestore flusher = true (default), after every write the fd is 
> handed off to another thread that uses sync_file_range() to push the data 
> out to disk quickly before closing the file.  The purpose is to limit the 
> latency for the eventual snapshot or sync.  Eric suspected the handoff 
> between threads may be what was triggering the bug in ext4.
> 
> sage
