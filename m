From: Gregory Farnum <greg@gregs42.com>
Subject: Re: RBD journal draft design
Date: Tue, 9 Jun 2015 15:30:45 -0700
Message-ID: <CAC6JEv_oYpWYd61t3w5MtLYEaw6cd91btffJQ1eP5DEmkoHzFg@mail.gmail.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com>
	<CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com>
	<1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com>
	<CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com>
	<1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com>
	<CAC6JEv8v9Wzx094E5pReJE47=d2wbP8rR=FJcU+BNJcT7H488w@mail.gmail.com>
	<810657134.11416115.1433464573115.JavaMail.zimbra@redhat.com>
	<CAC6JEv-RnsXqYZ215WZHcy8Fhyz2H7PPEJSjWVfj4P=gnTCP2A@mail.gmail.com>
	<838188530.13777348.1433876914558.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38843 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbFIWar convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 18:30:47 -0400
Received: by igblz2 with SMTP id lz2so21198622igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 15:30:47 -0700 (PDT)
Received: from mail-ie0-f170.google.com (mail-ie0-f170.google.com. [209.85.223.170])
        by mx.google.com with ESMTPSA id i7sm2073793igt.18.2015.06.09.15.30.46
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 15:30:46 -0700 (PDT)
Received: by iesa3 with SMTP id a3so22954589ies.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 15:30:45 -0700 (PDT)
In-Reply-To: <838188530.13777348.1433876914558.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jun 9, 2015 at 12:08 PM, Jason Dillaman <dillaman@redhat.com> wrote:
>> I must not be being clear. Tell me if this scenario is possible:
>>
>> * Client A writes to file foo many times and it is journaled to object set 1.
>> * Client B writes to file bar many times and it starts journaling to
>> object set 1, but hits the end and moves on to object set 2.
>> * Client A hits a synchronization point in its higher-level logic.
>> * Client A fsyncs file foo to object set 1 and then
>> * Client B hits the synchronization point, fsyncs file bar to object
>> set 2, and sends data back to Client A.
>> * Client A fsyncs the receipt of its data stream to object set 1, and
>> only then gets sent on to object set 2.
>> * The journal copier runs and migrates object set 1 to a remote data
>> center, then the data center explodes.
>> * In the remote data center they fail over and client A thinks it has
>> reached a synchronization point and gotten an acknowledgement that
>> client B has never heard of.
>>
>> Does that being a problem make sense? I don't think handling it is
>> overly complicated and it's kind of important.
>> -Greg
>
> Seems this case is solved if you delay the completion of client B's flush (fsync) until the "active set updated" notification is successfully delivered.  In that case, client A would know that it needs to re-read the active set collection and thus needs to now write to object set 2.  Thoughts?

Honestly at this point my head's a little wrapped around itself and
I'm not sure. :) I think that however it's set up we want to switch
from one object set to the next coherently (ie, no writing to object
set 2 for write N and object set 1 for write N+1) and that we force
each client to switch at the same point. I guess in general the
penalty for having to re-send ops when we find out late that the
object set is full probably wouldn't be a big deal? But I'm not sure
if if sending notifies on the objects is the best option or if
something else is.
-Greg
