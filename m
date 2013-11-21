From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Intel 520/530 SSD for ceph
Date: Thu, 21 Nov 2013 09:36:07 +0100
Message-ID: <528DC5F7.6040104@profihost.ag>
References: <528A1862.7010601@profihost.ag> <20131118225146.GA1043@soma.private.linuxbox.com> <528B1B21.1060203@profihost.ag> <20131121002936.GA15558@soma.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:51222 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3KUIgK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 03:36:10 -0500
In-Reply-To: <20131121002936.GA15558@soma.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mdw@linuxbox.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi,

Am 21.11.2013 01:29, schrieb mdw@linuxbox.com:
> On Tue, Nov 19, 2013 at 09:02:41AM +0100, Stefan Priebe wrote:
> ...
>>> You might be able to vary this behavior by experimenting with sdparm,
>>> smartctl or other tools, or possibly with different microcode in the drive.
>> Which values or which settings do you think of?
> ...
> 
> Off-hand, I don't know.  Probably the first thing would be
> to compare the configuration of your 520 & 530; anything that's
> different is certainly worth investigating.
> 
> This should display all pages,
> 	sdparm --all --long /dev/sdX
> the 520 only appears to have 3 pages, which can be fetched directly w/
> 	sdparm --page=ca --long /dev/sdX
> 	sdparm --page=co --long /dev/sdX
> 	sdparm --page=rw --long /dev/sdX
> 
> The sample machine I'm looking has an intel 520, and on ours,
> most options show as 0 except for
>   AWRE        1  [cha: n, def:  1]  Automatic write reallocation enabled
>   WCE         1  [cha: y, def:  1]  Write cache enable
>   DRA         1  [cha: n, def:  1]  Disable read ahead
>   GLTSD       1  [cha: n, def:  1]  Global logging target save disable
>   BTP        -1  [cha: n, def: -1]  Busy timeout period (100us)
>   ESTCT      30  [cha: n, def: 30]  Extended self test completion time (sec)
> Perhaps that's an interesting data point to compare with yours.
> 
> Figuring out if you have up-to-date intel firmware appears to require
> burning and running an iso image from
> https://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=18455
> 
> The results of sdparm --page=<whatever> --long /dev/sdc
> show the intel firmware, but this labels it better:
> smartctl -i /dev/sdc
> Our 520 has firmware "400i" loaded.

Firmware is up2date and all values are the same. I expect that the 520
firmware just ignores CMD_FLUSH commands and the 530 does not.

Greets,
Stefan
