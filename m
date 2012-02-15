From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Size of monitor data dir
Date: Wed, 15 Feb 2012 13:35:59 +0100
Message-ID: <4F3BA6AF.1080308@widodh.nl>
References: <CA+jddaODnwadRXpXaCNzzmDB5h7dK_+Y82y_+zpBKF0zkTgJNQ@mail.gmail.com> <Pine.LNX.4.64.1202141818560.3836@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:40668 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036Ab2BOMgF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 07:36:05 -0500
In-Reply-To: <Pine.LNX.4.64.1202141818560.3836@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mandell Degerness <mandell@pistoncloud.com>, ceph-devel@vger.kernel.org

On 02/15/2012 03:20 AM, Sage Weil wrote:
> On Tue, 14 Feb 2012, Mandell Degerness wrote:
>> How big can the monitor data directory grow?  Is there a rule of thumb
>> that can be used?
>
> Right now the monitor dir include teh cluster log files (log and log.*),
> which grow indefinitely unless you rotate them.  The other directories
> are mostly trimmed by the monitor itself and should stay pretty small (few
> hundred megs at most?).  The lingering exception is the mdsmap dir, which
> isn't yet trimmed, but you guys won't be using that anyway (and the maps
> are small).
>
> Maybe Wido or someone else who has a long running cluster can see how big
> it is?

I just took a look at my oldest cluster, which has been running for 
about 4 months now with a single monitor.

This cluster has 6 OSD's and is running two virtual machines with RBD. 
The monitor directory is 29M right now.

On my larger cluster, which I had to re-install, the monitor directories 
are about 400M.

The logm directory is however trimmed? My oldest messages are from 
February 14th on both clusters.

I'd however advice somewhere around 5GB at at least. I'm running my 
monitors on ext4 and I've ran out of inodes a couple of times. But if 
all directories are trimmed, you are not likely to run into that.

You should however be careful with the log.* files, they can grow 
quickly. We could provide a standard logrotate script in the deb's / 
rpm's for those?

Wido
