From: Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 00/61] fscache, cachefiles: Rewrite the I/O
 interface in terms of kiocb/iov_iter
Date: Mon, 04 May 2020 13:54:33 -0400
Message-ID: <63498a6eedc7994b1e96a59d12468bfd15e15ef4.camel@redhat.com>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Trond Myklebust <trondmy-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org>, Anna Schumaker <anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org>, Steve French <sfrench-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2020-05-04 at 18:07 +0100, David Howells wrote:
> 
>  (3) Make NFS, CIFS, Ceph, 9P work with it.  I'm hoping that Jeff Layton will
>      do Ceph.  As mentioned, I'm having a crack at NFS, but it's evolved a bit
>      since I last looked at it and it might be easier if I can palm that off
>      to someone more current in the NFS I/O code.
> 
> 

[...]

This looks like a really nice overhaul. I particularly love the
diffstat. Net removal of ~4000 lines!

I'll plan to draft up a patch for Ceph in the near future. The new API
seems to be quite different, so I imagine this will more or less be a
rip and replace on the old code.
-- 
Jeff Layton <jlayton-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
