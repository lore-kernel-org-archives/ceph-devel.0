From: Martin Mailand <martin@tuxadero.com>
Subject: Re: crushmap errors
Date: Mon, 14 Nov 2011 15:12:59 +0100
Message-ID: <4EC121EB.10101@tuxadero.com>
References: <4EBD9F62.20709@tuxadero.com> <Pine.LNX.4.64.1111111444490.30348@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:45272 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab1KNONE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 09:13:04 -0500
In-Reply-To: <Pine.LNX.4.64.1111111444490.30348@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Hi Sage,
1. The crushtool grammer fix is working for me. Thanks.

2. I think if an admin puts the extra rack info into the ceph.conf file, 
than it should do what expected. I understand your worries but on the 
other end ceph is not an end user tool, and people should know what they 
do and balance there racks evenly.
Just my two cents.

-martin


Am 11.11.2011 23:51, schrieb Sage Weil:
> On Fri, 11 Nov 2011, Martin Mailand wrote:
>> Hi,
>> I used in ceph v0.38 the host and rack feature in the conf during an mkcephfs.
>> Now I have to problems with the crushmap
>>
>> 1. I cannot compile a ceph genearated crushmap.
>> crushtool -c file.txt -o file
>> file.txt:4 error: parse error at '.0'
>
> Whoops, will push a patch to stable shortly.  The grammer wasn't
> recognizing '.' as a legal character.
>
>> 2. Why are 2 racks are not enough for 2 failure domains?
>>  From the commit:
>> If there are>2 racks, separate across racks.
>
> Well, technically they are.  My worry is that it's more likely that racks
> will have significantly vary capacity (i.e. crush weight) due to, say, 1
> full rack and a second 1/2 rack.  If the policy forces replicas be placed
> across racks things won't balance well.
>
> I suppose there should be an argument like --min-racks that controls that
> threshold?
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

