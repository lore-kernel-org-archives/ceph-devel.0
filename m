From: Shinji Matsumoto <shinji.matsumoto@us.sios.com>
Subject: Re: Question about librados notification
Date: Wed, 26 Mar 2014 01:59:04 +0900
Message-ID: <CAJ58760Gj8xiDtVECwuf6z-PChMVOAu_S5eKvPYPn3WJVP+6Ng@mail.gmail.com>
References: <CAJ58763WbS3dhnu572w7pwSVY2iywXmVwstu_bpRY=cR5K-+iQ@mail.gmail.com>
	<CAPYLRzi-tiJ_9D7KiGSb8uP-6EquSUXuA3LRNUJ+frDTXv1T2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:59950 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbaCYQ7G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 12:59:06 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so682977iec.4
        for <ceph-devel@vger.kernel.org>; Tue, 25 Mar 2014 09:59:04 -0700 (PDT)
In-Reply-To: <CAPYLRzi-tiJ_9D7KiGSb8uP-6EquSUXuA3LRNUJ+frDTXv1T2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Greg,

Your answer is what I wanted to know.
Thank you.

Shinji Matsumoto
SIOS technology, Inc.

On Wed, Mar 26, 2014 at 12:56 AM, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, Mar 25, 2014 at 5:50 AM, Shinji Matsumoto
> <shinji.matsumoto@us.sios.com> wrote:
>> Hello all,
>>
>> I have a question about Ceph notification mechanism.
>> http://ceph.com/docs/master/architecture/#object-watch-notify
>>
>> Scenario:
>>
>> (1) 3 clients (client1, client2, client3) have interests on a Ceph
>> object (object A). Each client calls rados_watch() to register
>> notification callback on the object..
>>
>> (2) Client1 calls rados_notify()  on object A. On client1 and client2,
>> the notification is delivered and processed successfully within a
>> timeout period.
>>
>> (3) However on client3, the notification is delivered, but it doesn't
>> complete within a timeout period for a temporary reason, such as
>> temporarily busy process for instance.
>>
>> (4) On client1, rados_notify() returns a status of timeout.
>>
>> (5) On client3, the temporary reason goes away and the notification is
>> processed.
>>
>> (6) Then, client3 attempts to read from object A by a call to rados_read().
>>
>> Question:
>>
>> Will the call to rados_read() attempted at step (6) always succeed,
>> always fail or is the behavior unpredictable, which is, it's affected
>> by the factors that are not defined in this scenario?
>
> The success of the read is not impacted by the notify timeout -- you
> can order reads using watch-notify, but issues in the watch-notify
> framework won't impact reads. Watch-notify is a voluntary thing. IIRC
> the OSD involved might kill client3's connection, but it'll just
> establish a new one transparently.
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
