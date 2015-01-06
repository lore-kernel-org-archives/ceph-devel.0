From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: What to do when a parent RBD clone becomes corrupted
Date: Mon, 5 Jan 2015 17:47:54 -0700
Message-ID: <CAANLjFrVrfwGGQqo_CD8q_b1sys6_Bs8gZaw0CGNkR8oKvfNhA@mail.gmail.com>
References: <CAANLjFqeEqQWimV-A8rzFgAkBrtxRXu3_OUF6waPT7N6J7GL4g@mail.gmail.com>
	<CAANLjFqqPD9=91OYdYJ8bQrE88=+AOC0psD5gJUqV0n+JG5Xsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:58631 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849AbbAFArz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 19:47:55 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so4402978wiw.3
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 16:47:54 -0800 (PST)
In-Reply-To: <CAANLjFqqPD9=91OYdYJ8bQrE88=+AOC0psD5gJUqV0n+JG5Xsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 5:46 PM, Robert LeBlanc <robert@leblancnet.us> wrote:
> Now that the holidays are over, I'm going to bump this message to see if
> there are any good ideas on this.
>
> Thanks,
> Robert LeBlanc
>
> On Thu, Dec 18, 2014 at 2:21 PM, Robert LeBlanc <robert@leblancnet.us>
> wrote:
>>
>> Before we base thousands of VM image clones off of one or more snapshots,
>> I want to test what happens when the snapshot becomes corrupted. I don't
>> believe the snapshot will become corrupted through client access to the
>> snapshot, but some weird issue with PGs being lost or forced to be lost,
>> solar flares or alien invasions.
>>
>> My initial thought was to export a snapshot image and import it over the
>> top of the existing snapshot so that children would be preserved. No such
>> luck. I was hoping there would be a "i-really-really-want-to-do-this" option
>> that would let me restore the snapshot.
>>
>> Am I going about this the wrong way? I can see having to restore a number
>> of VM because of corrupted clone, but I'd hate to lose all the clones
>> because of corruption in the snapshot. I would be happy if the restored
>> snapshot would be flattened if it was a clone of another image previously.
>>
>> Thanks,
>> Robert LeBlanc
>
>
