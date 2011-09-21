From: Martin Mailand <martin@tuxadero.com>
Subject: Re: RDB Performance
Date: Wed, 21 Sep 2011 23:54:23 +0200
Message-ID: <4E7A5D0F.7070806@tuxadero.com>
References: <4E7A4D9E.3070305@tuxadero.com> <Pine.LNX.4.64.1109211354360.22692@cobra.newdream.net> <4E7A5477.1080105@tuxadero.com> <Pine.LNX.4.64.1109211419520.22692@cobra.newdream.net>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:41716 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1IUVyb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 17:54:31 -0400
In-Reply-To: <Pine.LNX.4.64.1109211419520.22692@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
the performance improvment is quite impressive. Now I get around 90MB/s 
from within the vm.
Thanks.

Best Regards,
  martin

Sage Weil schrieb:
> On Wed, 21 Sep 2011, Martin Mailand wrote:
>> Hi Sage,
>> good to hear that you are working on this issue. I tried qemu-kvm with the rbd
>> block device patch, which I think uses librbd, but I couldn't measure any
>> performance improvements.
>>
>> Which versions do I have to use, and do I have to activate the writeback
>> window or is it default on?
> 
> In the qemu rbd: line, include an option like ":rbd_writeback_window=81920000",
> where the size of the window is specified in bytes.  (It's off by 
> default.)
> 
> Also, keep mind that unless you're using the latest qemu upstream (or our 
> repo), the flush aren't being passed down properly, and your data won't 
> quite be safe.  (That's the main reason why we're leaving it off by 
> default for the time being.)
> 
> sage
> 
