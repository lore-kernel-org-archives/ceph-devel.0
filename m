From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] ceph: simplify+fix atomic_open
Date: Tue, 07 Aug 2012 19:39:53 +0200
Message-ID: <871uji61p2.fsf@tucsk.pomaz.szeredi.hu>
References: <alpine.DEB.2.00.1207301831520.3171@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64052 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab2HGRid (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 13:38:33 -0400
Received: by wgbfm10 with SMTP id fm10so2607359wgb.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 10:38:32 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207301831520.3171@cobra.newdream.net> (Sage
	Weil's message of "Mon, 30 Jul 2012 18:39:34 -0700 (PDT)")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Sage Weil <sage@inktank.com> writes:

> Hi Miklos,
>
> I've updated the ceph code to take better advantage of the new 
> ->atomic_open(), but ran into several bumps understanding the new 
> interface.  If you don't mind, can you make sure I got it right?
>
> Basically:
>
>  - on success,
> 	return finish_open(original file, original dentry, ...)

Yes.

>  - on symlink,
> 	return finish_no_open(original file, original dentry)

That should be "return finish_no_open(original file, NULL)"

>  - if we have to splice in a different dentry (e.g., d_splice_alias()),
> 	return finish_no_open(original file, existing dentry)

Yes.

>  - on ENOENT,
>  	return finish_no_open(original file, original negative dentry)

Again, NULL indicates "original dentry".

>
> Basically, give finish_no_open whatever ->lookup() would have returned.  
> Is that right?

Yes, exactly.

Thanks,
Miklos
