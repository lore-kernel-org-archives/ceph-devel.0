From: Simon Tian <aixt2006@gmail.com>
Subject: Re: snapshot of rbd
Date: Tue, 14 Jun 2011 10:35:13 +0800
Message-ID: <BANLkTikRCFCBoOm30eTCPUDq56dvm=ndVA@mail.gmail.com>
References: <BANLkTimpfh-oMyhVJLj6Pry74kFEKJG7nA@mail.gmail.com>
	<BANLkTikF2rO2Ot8wV6pRNsMLHcJ3NucfTg@mail.gmail.com>
	<BANLkTin8UmqhWD4nyDfKb4feRATagFEwow@mail.gmail.com>
	<BANLkTim0a_vrdfg=W0kJAhvARj3BmY1AAQ@mail.gmail.com>
	<BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40700 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab1FNCfO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2011 22:35:14 -0400
Received: by wya21 with SMTP id 21so3581898wya.19
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2011 19:35:13 -0700 (PDT)
In-Reply-To: <BANLkTik04D23tN9YZY-GJeJAy9gFB-z=eg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Yehuda,

    So I list a table which describe the VM status and time needed
during rbd snapshot operation:

operation  |   VM status                  |    time needed
-----------------------------------------------------------------------------------------------------------------------
create      |   could be running          |    instant
delete      |   could be running          |    instant
rollback    |   need to be shutdown   |    needs to go through all the objects
list           |   could be running          |    instant
set           |   need to be shutdown    |    instant

Could you check this table, hope to get your correction or supplement.
Thx very much!

Simon


2011/6/14 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Sun, Jun 12, 2011 at 10:43 PM, Simon Tian <aixt2006@gmail.com> wrote:
>> 2011/6/13 Yehuda Sadeh Weinraub <yehuda.sadeh@dreamhost.com>:
>>> Rollback is (currently) is in the order of the number of object of
>>> that image. It needs to go through all the objects and execute an
>>> explicit request of each. For very large images it can be quite long.
>>
>> When a VM is running based on rbd image, and need to rollback to S1.
>> During rollback, seem like that data written by the VM is not allowed?
>> Is there any way to rollback without affecting the user experience of the VM?
>>
> Data written by the vm to the image is not recommended as it'll most
> likely corrupt it. It is recommended that you unmount any relevant
> partition while doing it. Currently there's not much to do to avoid
> the relatively long rollback. We do have on our roadmap the layering
> feature that will allow having some sort of writable snapshots, but
> we're not there yet.
>
> Yehuda
>
