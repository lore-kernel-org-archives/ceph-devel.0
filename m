From: Loic Dachary <loic@dachary.org>
Subject: Re: crush: straw is dead, long live straw2
Date: Fri, 27 Jan 2017 01:26:37 +0100
Message-ID: <a5b1d1dc-d9b8-8916-b677-13f37afd4fb1@dachary.org>
References: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34746 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbdA0A1W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Jan 2017 19:27:22 -0500
In-Reply-To: <alpine.DEB.2.00.1412081516010.18281@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi Sage,

On 12/09/2014 12:48 AM, Sage Weil wrote:
> The new straw2 bucket works like this:
> 
>  max_x = -1
>  max_item = -1
>  for each item:
>     x = random value from 0..65535
>     x = ln(x / 65536) / weight
>     if x > max_x:
>        max_x = x
>        max_item = item
>  return item
> 
> That ln() is a natural log (well, a 16-bit fixed-point approximation of 
> it) and as you can see it's a simple function of the weight of that item.  
> That means that changing one item's weight won't have any effect on the 
> straw lengths for other items, so a change will either make the item win 
> or not win but won't change who the other winner is in the not-win case.
> 
> Somewhat embarassingly, I stumbled onto this solution half by accident.  
> Sam found the underlying principle that makes it work:
> 
>  http://en.wikipedia.org/wiki/Exponential_distribution#Distribution_of_the_minimum_of_exponential_random_variables

I dont' understand what that works :-) Is there some documentation I could read to better understand the principle ?

Cheers

[1] bucket_straw2_choose http://libcrush.org/main/libcrush/blob/master/crush/mapper.c#L309

-- 
Loïc Dachary, Artisan Logiciel Libre
