From: Wido den Hollander <wido@42on.com>
Subject: Re: radosgw socket dir
Date: Mon, 14 Sep 2015 18:00:21 +0200
Message-ID: <55F6EF15.1090501@42on.com>
References: <alpine.DEB.2.00.1509140801270.7530@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:55292 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbbINQAZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 12:00:25 -0400
In-Reply-To: <alpine.DEB.2.00.1509140801270.7530@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, osynge@suse.com
Cc: ceph-devel@vger.kernel.org



On 14-09-15 17:05, Sage Weil wrote:
> radosgw now runs as ceph:ceph under systemd.  /run/ceph-rgw is 755 owned 
> as the web user.  I think this will break anybody using apache and 
> fastcgi.  That's not the default, but I don't think that combo 
> makes any sense anyway.
> 
> Should we...
> 
>  - make /run/ceph-rgw ceph:ceph 0755, make the sockets 770, and then make 
> the user add the web user to the ceph group?
> 
>  - make /run/ceph-rgw ceph:www 0755 + group sticky bit and then make the 
> sockets 770 so that the web user can open them?
> 
>  - get rid of /run/ceph-rgw entirely and let the admin do this on their 
> own if they want to do fastcgi instead of civetweb?
> 
> I like of like the last option...

I agree. I would not promote FastCGI in any way. Civetweb is easier and
faster.

So if anyone wants FastCGI, let them override the systemd service file
and add the socket.

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
