From: Ben Boeckel <me-QTASWB020EJSV923RJcDwA@public.gmane.org>
Subject: Re: [PATCH] dns: Apply a default TTL to records obtained from
 getaddrinfo()
Date: Tue, 19 May 2020 12:24:52 -0400
Message-ID: <20200519162452.GA3010828@erythro.dev.benboeckel.internal>
References: <20200519141432.GA2949457@erythro.dev.benboeckel.internal>
 <20200518155148.GA2595638@erythro.dev.benboeckel.internal>
 <158981176590.872823.11683683537698750702.stgit@warthog.procyon.org.uk>
 <1080378.1589895580@warthog.procyon.org.uk>
 <1512927.1589904409@warthog.procyon.org.uk>
Reply-To: me-QTASWB020EJSV923RJcDwA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1512927.1589904409-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
Sender: linux-nfs-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-afs-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Tue, May 19, 2020 at 17:06:49 +0100, David Howells wrote:
> Okay, how about this incremental change, then?  If fixes the typo, only prints
> the "READ CONFIG" line in verbose mode, filters escape chars in the config
> file and reduces the expiration time to 5s.

Thanks! Looks good to me.

Reviewed-by: Ben Boeckel <me-QTASWB020EJSV923RJcDwA@public.gmane.org>

--Ben
