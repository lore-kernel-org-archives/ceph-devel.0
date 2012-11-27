From: brady <brady@lamphost.com>
Subject: Re: Character limit for rbd block device
Date: Tue, 27 Nov 2012 13:32:54 -0800
Message-ID: <50B53186.1040807@lamphost.com>
References: <50B404DA.50805@lamphost.com> <50B40ED5.7050307@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tux2.lamphost.net ([69.43.195.67]:45216 "EHLO tux2.lamphost.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754788Ab2K0Vdr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Nov 2012 16:33:47 -0500
In-Reply-To: <50B40ED5.7050307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/26/2012 04:52 PM, Josh Durgin wrote:
> On 11/26/2012 04:10 PM, brady wrote:
>> Hello,
>>      I have a general question. Is there a specific character limit for
>> rbd block devices? In attempting to map a block device with a name that
>> is 36 characters or more, I am getting the following error:
>>
>> rbd map (36+ character name) --user admin --secret /etc/ceph/keyring.key
>> add failed: (2) No such file or directory
>>
>>      When using the same command to map a device with 35 characters or
>> less, the device is mapped as expected. Any insight into this issue
>> would be greatly appreciated.
>>
>> -Brady
>
> Which kernel version are you using?
>
> A year ago there was a 40-char limit on objects names in the kernel's
> libceph module, hence the failure at 36 char rbd image names (36 char
> name + ".rbd" is the format 1 header object name).
>
> This was extended to a 96-char limit in linux 3.2. There's no real limit
> in userspace still (http://tracker.newdream.net/issues/1701).
>
> Josh
>
Thanks, Josh. This information was exactly what we were looking for. 
Looks like a version issue that we will need to work around. Thanks again!

Brady
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

