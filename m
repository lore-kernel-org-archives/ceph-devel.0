From: David Howells <dhowells@redhat.com>
Subject: Re: What's a good default TTL for DNS keys in the kernel
Date: Sun, 19 Apr 2020 09:37:52 +0100
Message-ID: <927453.1587285472@warthog.procyon.org.uk>
References: <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com> <3865908.1586874010@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH2r5mv5p=WJQu2SbTn53FeTsXyN6ke_CgEjVARQ3fX8QAtK_w@mail.gmail.com>
Content-ID: <927452.1587285472.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, linux-nfs <linux-nfs@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org, keyrings@vger.kernel.org, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, fweimer@redhat.com
List-Id: ceph-devel.vger.kernel.org

Steve French <smfrench@gmail.com> wrote:

> For SMB3/CIFS mounts, Paulo added support last year for automatic
> reconnect if the IP address of the server changes.  It also is helpful
> when DFS (global name space) addresses change.

What happens if the IP address the superblock is going to changes, then
another mount is made back to the original IP address?  Does the second mount
just pick the original superblock?

David
