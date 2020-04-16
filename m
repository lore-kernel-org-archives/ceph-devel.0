From: David Howells <dhowells@redhat.com>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Thu, 16 Apr 2020 11:15:19 +0100
Message-ID: <127743.1587032119@warthog.procyon.org.uk>
References: <CAH2r5mvj7GF3i8AE6E=+5f_Vigtb3uw=665F2uuBOgGzUhHObQ@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk> <e751977dac616d93806d98f4ad3ce144bb1eb244.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAH2r5mvj7GF3i8AE6E=+5f_Vigtb3uw=665F2uuBOgGzUhHObQ@mail.gmail.com>
Content-ID: <127742.1587032119.1@warthog.procyon.org.uk>
Sender: netdev-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> > 10 mins sounds like a reasonable default to me.
> 
> I would lean toward slightly longer (20 minutes?) but aren't there
> usually different timeouts for 'static' vs. 'dynamic' DNS records (so
> static records would have longer timeouts)?

Unfortunately, getaddrinfo() doesn't give me that information.

David
