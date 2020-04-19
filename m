From: Steve French <smfrench@gmail.com>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Sat, 18 Apr 2020 23:53:57 -0500
Message-ID: <CAH2r5mth8Jc0dfAOP+hXTp-hJBHoNT4M=J8Ypcq+BhP4a_Wc6Q@mail.gmail.com>
References: <3865908.1586874010@warthog.procyon.org.uk> <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
 <87a738aclu.fsf@oldenburg2.str.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <87a738aclu.fsf@oldenburg2.str.redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Weimer <fweimer@redhat.com>
Cc: David Howells <dhowells@redhat.com>, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

commit 28eb24ff75c5ac130eb326b3b4d0dcecfc0f427d
Author: Paulo Alcantara <paulo@paulo.ac>
Date:   Tue Nov 20 15:16:36 2018 -0200

    cifs: Always resolve hostname before reconnecting

    In case a hostname resolves to a different IP address (e.g. long
    running mounts), make sure to resolve it every time prior to calling
    generic_ip_connect() in reconnect.
...

(Note that this patch may have some minor dependencies on a few other
DFS related patches that were merged immediately before it.
08744015492f cifs: Add support for failover in cifs_reconnect_tcon()
a3a53b760379 cifs: Add support for failover in smb2_reconnect()
23324407143d cifs: Only free DFS target list if we actually got one
e511d31753e3 cifs: start DFS cache refresher in cifs_mount()
93d5cb517db3 cifs: Add support for failover in cifs_reconnect()
4a367dc04435 cifs: Add support for failover in cifs_mount()
1c780228e9d4 cifs: Make use of DFS cache to get new DFS referrals

On Sat, Apr 18, 2020 at 1:11 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Steve French:
>
> >>> The question remains what the expected impact of TTL expiry is.  Will
> >>> the kernel just perform a new DNS query if it needs one?
> >
> > For SMB3/CIFS mounts, Paulo added support last year for automatic
> > reconnect if the IP address of the server changes.  It also is helpful
> > when DFS (global name space) addresses change.
>
> Do you have reference to the source code implementation?  Thanks.
>
> Florian
>


-- 
Thanks,

Steve
