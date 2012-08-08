From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: simplify __rbd_init_snaps_header()
Date: Tue, 07 Aug 2012 18:27:11 -0700
Message-ID: <5021C06F.2050600@inktank.com>
References: <502002D4.6070701@inktank.com> <5021A462.2030603@inktank.com> <5021BAD9.5000501@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58208 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab2HHB1O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 21:27:14 -0400
Received: by pbbrr13 with SMTP id rr13so570983pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 18:27:13 -0700 (PDT)
In-Reply-To: <5021BAD9.5000501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/07/2012 06:03 PM, Alex Elder wrote:
>>> +            __rbd_remove_snap_dev(snap);
>>> +
>>> +            /* Done with this list entry; advance */
>>> +
>>> +            links = next;
>>
>> This could just be links = links->next like you have later.
>
> I just used "next" because I had it available here but not
> below.  I do like consistency though so I'll make your
> suggested change.

After looking at it again, I don't think you're right.

The reason is that __rbd_remove_snap_dev() actually unlinks
the "snap" from the list that contains it, and "links" at
this point is referring to &snap->node, which is modified
by the list deletion.

The assignment I had originally, which uses a saved copy
of links->next, is the correct one.  So I'll be committing
with my original version of this section of code.

					-Alex
