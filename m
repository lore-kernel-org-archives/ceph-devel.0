From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: 0.55 crashed during upgrade to bobtail
Date: Tue, 1 Jan 2013 23:55:13 +0300
Message-ID: <CABYiri9vtqcEaKo1OA=wQgPL-B6AMf-7NdV2+H6NfY34dZ-cSQ@mail.gmail.com>
References: <CABYiri_pJynyL2DSRqErkAYp0H0sDmwg0HCAYfB84JUZ2dfczw@mail.gmail.com>
 <CABYiri-4uo03O8tGfd_mtRF5gXAHv63QRonHPqYHkXhPipYY=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55089 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3AAUzf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Jan 2013 15:55:35 -0500
Received: by mail-oa0-f51.google.com with SMTP id n12so12473159oag.38
        for <ceph-devel@vger.kernel.org>; Tue, 01 Jan 2013 12:55:34 -0800 (PST)
In-Reply-To: <CABYiri-4uo03O8tGfd_mtRF5gXAHv63QRonHPqYHkXhPipYY=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 2, 2013 at 12:16 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> On Tue, Jan 1, 2013 at 9:49 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> Hi,
>>
>> All osds in the dev cluster died shortly after upgrade (packet-only,
>> i.e. binary upgrade, even without restart running processes), please
>> see attached file.
>>
>> Was: 0.55.1-356-g850d1d5
>> Upgraded to: 0.56 tag
>>
>> The only one difference is a version of the gcc corresponding
>> libstdc++ - 4.6 on the buildhost and 4.7 on the cluster. Of course I
>> may do a rollback and problem will eliminate with high probability,
>> but seems there should be some fix. Also I have something simular in
>> the the testing env days ago -  packet upgrade inside 0.55 killed all
>> _windows_ guests_ and one of tens of linux guests running above rbd.
>> Unfortunately I have no debug sessions at this moment and I have only
>> tail of the log from qemu:
>>
>> terminate called after throwing an instance of 'ceph::buffer::end_of_buffer'
>>   what():  buffer::end_of_buffer
>>
>> I`m blaming ldconfig action from librbd because nothing else `ll cause
>> such case of destroy on the running processes - may be I`m wrong.
>>
>> thanks!
>>
>> WBR, Andrey
>
> Sorry, I`m not able to reproduce crash after rollback and traces was
> uncomplete due to lack of disk space on specified core location, so
> please don`t mind it.

Ahem, finally it seems that osd process stumbling on something on the
fs, because my other environments also was able to reproduce crash
once, but reproducing is not possible since new osd process started
over existing filestore(offline version rollback and another try to
online upgrade doing fine). And backtrace in first message is
complete, at least 1 and 2, despite of lack of space first time - I
have received a couple of coredumps which trace looks exactly the same
as 2.
