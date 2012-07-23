From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [rados] Asynchronous operations
Date: Mon, 23 Jul 2012 09:07:20 -0700
Message-ID: <500D76B8.1070705@inktank.com>
References: <jsecti$m2u$1@dough.gmane.org> <Pine.LNX.4.64.1206270821040.18530@cobra.newdream.net> <jujscq$sug$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41696 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab2GWQHX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jul 2012 12:07:23 -0400
Received: by ghrr11 with SMTP id r11so5614368ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jul 2012 09:07:23 -0700 (PDT)
In-Reply-To: <jujscq$sug$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On 07/23/2012 08:59 AM, Rutger ter Borg wrote:
> On 06/27/2012 05:22 PM, Sage Weil wrote:
>>
>> There is a get_return_value() method on the AioCompletion that gives you
>> bytes read (for reads).  For write operations, it is always 0
>> (success) or
>> an error code.
>>
>
> Thanks for the info. Maybe a bit of a newbie question, but in that case,
> how do I detect a read error, given an AioCompletion object?

It's the same as with writes - if there's an error, get_return_value
will give you the negative error code (i.e. -ENOENT, -EPERM, etc).

