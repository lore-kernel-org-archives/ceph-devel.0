From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD journal draft design
Date: Tue, 9 Jun 2015 15:08:34 -0400 (EDT)
Message-ID: <838188530.13777348.1433876914558.JavaMail.zimbra@redhat.com>
References: <1574383603.9391063.1433257824183.JavaMail.zimbra@redhat.com> <CAC6JEv98=49tW0S4g=QiT28Pffdji=6S95J4aNLUXUDB2BEs+A@mail.gmail.com> <1679134333.10270211.1433348013379.JavaMail.zimbra@redhat.com> <CAC6JEv_M5jKk+FSDZja15Rmyf3W2x5-yeg9LRukKCHLnYq-j+w@mail.gmail.com> <1628237419.11058538.1433430488520.JavaMail.zimbra@redhat.com> <CAC6JEv8v9Wzx094E5pReJE47=d2wbP8rR=FJcU+BNJcT7H488w@mail.gmail.com> <810657134.11416115.1433464573115.JavaMail.zimbra@redhat.com> <CAC6JEv-RnsXqYZ215WZHcy8Fhyz2H7PPEJSjWVfj4P=gnTCP2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:56300 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282AbbFITIh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 15:08:37 -0400
In-Reply-To: <CAC6JEv-RnsXqYZ215WZHcy8Fhyz2H7PPEJSjWVfj4P=gnTCP2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> I must not be being clear. Tell me if this scenario is possible:
> 
> * Client A writes to file foo many times and it is journaled to object set 1.
> * Client B writes to file bar many times and it starts journaling to
> object set 1, but hits the end and moves on to object set 2.
> * Client A hits a synchronization point in its higher-level logic.
> * Client A fsyncs file foo to object set 1 and then
> * Client B hits the synchronization point, fsyncs file bar to object
> set 2, and sends data back to Client A.
> * Client A fsyncs the receipt of its data stream to object set 1, and
> only then gets sent on to object set 2.
> * The journal copier runs and migrates object set 1 to a remote data
> center, then the data center explodes.
> * In the remote data center they fail over and client A thinks it has
> reached a synchronization point and gotten an acknowledgement that
> client B has never heard of.
> 
> Does that being a problem make sense? I don't think handling it is
> overly complicated and it's kind of important.
> -Greg

Seems this case is solved if you delay the completion of client B's flush (fsync) until the "active set updated" notification is successfully delivered.  In that case, client A would know that it needs to re-read the active set collection and thus needs to now write to object set 2.  Thoughts?
