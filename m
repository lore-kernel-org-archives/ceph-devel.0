From: Gregory Farnum <greg@inktank.com>
Subject: Re: Files disappearing
Date: Mon, 17 Sep 2012 12:40:26 -0700
Message-ID: <CAPYLRzgj7VUovj08rjz_GiNOvwSKcTOZ9YSheTA1QwYz2M3aUA@mail.gmail.com>
References: <2083014.9EhmjNYb6C@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45493 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536Ab2IQTk1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 15:40:27 -0400
Received: by iahk25 with SMTP id k25so5554515iah.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Sep 2012 12:40:26 -0700 (PDT)
In-Reply-To: <2083014.9EhmjNYb6C@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Mon, Sep 17, 2012 at 6:59 AM, Sz=E9kelyi Szabolcs <szekelyi@niif.hu>=
 wrote:
> Hi,
>
> I have a problem that newly copied files disappear from the FS after =
a few
> minutes. The only suspicious log entries look like this:
>
> 2012-09-17 15:45:40.251610 7f7024f25700  0 mds.0.server missing
> 10000000818 #1/vmdir/2414/images/deployment.0 (mine), will load later
>
> I see messages like this when the (only) active MDS is shut down and =
the
> backup (standby replay) takes over (and vice versa).
>
> I know cephfs is not the main focus of development, but if there's a =
quick
> solition, then please let me know.

Hrm. That message is output during client reconnect when the client is
referencing a file the MDS hasn't loaded into cache yet. It's legal
but not very common, so it could definitely be an indicator of where
the problem is.

Unfortunately, I don't think we've seen this issue before, so I can't
offer a quick fix. Can you make a bug in the tracker with all the
detail that's available to you? We've made a few hires in this area
recently and should be dusting off MDS development in not too much
longer! (Hurray!)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
