From: Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Sat, 18 Apr 2020 20:10:53 +0200
Message-ID: <87a738aclu.fsf@oldenburg2.str.redhat.com>
References: <3865908.1586874010@warthog.procyon.org.uk>
        <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Steve French's message of "Fri, 17 Apr 2020 18:23:53 -0500")
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve French <smfrench-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nfs <linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, CIFS <linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Network Development <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

* Steve French:

>>> The question remains what the expected impact of TTL expiry is.  Will
>>> the kernel just perform a new DNS query if it needs one?
>
> For SMB3/CIFS mounts, Paulo added support last year for automatic
> reconnect if the IP address of the server changes.  It also is helpful
> when DFS (global name space) addresses change.

Do you have reference to the source code implementation?  Thanks.

Florian
