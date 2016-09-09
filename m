From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: reply: rename PR
Date: Fri, 9 Sep 2016 12:39:28 -0400 (EDT)
Message-ID: <1854074380.83755406.1473439168860.JavaMail.zimbra@redhat.com>
References: <SG2PR02MB1198C040AE2CC5270488E028C6FA0@SG2PR02MB1198.apcprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:54176 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbcIIQja (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2016 12:39:30 -0400
In-Reply-To: <SG2PR02MB1198C040AE2CC5270488E028C6FA0@SG2PR02MB1198.apcprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?B?6ZmI5pWP?= <chenmin@xsky.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

thanks for the more detailed info, inline

----- Original Message -----
> From: "陈敏" <chenmin@xsky.com>
> To: "Matt Benjamin" <mbenjamin@redhat.com>
> Cc: "The Sacred Order of the Squid Cybernetic" <ceph-devel@vger.kernel.org>
> Sent: Friday, September 9, 2016 12:05:37 PM
> Subject: reply: rename PR
> 
> Hi Matt
> 
> 	I have noticed rgw file rename is not POSIX strictly, because src file and
> 	dest file own different inode number (hash of bucket + object).I have not
> 	tested on nfs-ganesha upstream for some reason, and will checkout to master
> 	to test FSAL_RGW later.
> 	For NFS scaling, the main problem is that different NFS-ganesha server keep
> 	its inode cache in local memory and there is no global view of inode
> 	cache(directory tree) in the NFS-ganesha cluster connectted to the same rgw
> 	bucket.

the idea is that there should be no need to do so, with the intended/current update strategy--the file id strategy actually helps with this;  broadly, we see the RGW NFS interface as intentionally divergent from POSIX, but with some room for flexibility as regards just how;  certainly, in the namespace, we don't want to chase Unix semantics badly

 For I have tested NFS-ganesha HA with pacemaker+corosync wachted
> 	and found inode cache cannot be shared between primary and backup.

I think the invalidate changes substantially address this, but we're actually going to be validating/working on HA next, so we'll be able to dig more into it and don't have specifics yet

 For
> 	NFSv4, session state and lock state should be persist to storage, so the
> 	NFS-ganesha cluster can share them.

a bunch of choices there;  currently, we don't support lock operations, and the primary reason was that again, currently, the only update strategy RGW supports is atomic overwrite;  we have speculated on opening up other options and even pNFS, but that's pretty blue sky;]

the current ganesha ha options keep track of most protocol state (e.g., sessions), and don't expose it to the fsals (whereas locks can);  it might be helpful if you joined the nfs-ganesha-devel mailing list to discuss further?

as regards file locking...

> 	In addition, what is the plan of flock in rgw file, for it is important to
> 	NFS cluster.

it's pretty simple to implement (and materialize) locks the way we do other attrs;  are they useful in the current atomic update model--and if so, which ones (whole-file?), and with what semantics (e.g., would such locks be mandatory [permitted in NFSv4.1+], and would they block renames?));  btw, on that point, I have little interest in implementing the messy edges of NFS vs. posix semantics, in general;

xattrs ARE coming too, as there is an IETF draft and prototype implementation of protocol xattrs which would use it;  on the xattr topic, while we're on it, at least one nfs-s3 implementation I'm aware of does things with attributes with an extra-protocol mechanism--we haven't thought really at all about that, have you folks?

> 
> Chen Min
> 
> -----邮件原件-----
> 发件人: Matt Benjamin [mailto:mbenjamin@redhat.com]
> 发送时间: 2016年9月9日 22:17
> 收件人: 陈敏 <chenmin@xsky.com>
> 抄送: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>
> 主题: rename PR
> 
> Hi Chen,
> 
> I wanted to let you know, I merged your exact-match PR.  Now, I suspect that
> you're also not running a recent-enough version of nfs-ganesha, because I
> think that the rename issue you fixed wouldn't easily reproduce if you were.
> 
> A key point I wanted to highlight is that it's part of the scaling (and ha,
> and...) strategy that our nfs file handles are name-stable, rather than
> arbitrary values.  One implication of that is that when a file is renamed,
> the renamed object has a different file id and hence NFS file handle value
> than it did before the rename.  We use the parent directory's change
> attribute to ensure that clients that had the vnode cached see an
> invalidate.  (Nothing in your PR contradicts that, of course.)
> 
> Another strategic decision we made is, we don't rename directories (just
> stating it for posterity). :)
> 
> Cheers,
> 
> Matt
> 
> --
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
> 
> http://www.redhat.com/en/technologies/storage
> 
> tel.  734-707-0660
> fax.  734-769-8938
> cel.  734-216-5309
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
