From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rbd and Metaserver
Date: Thu, 5 May 2011 10:19:02 -0700
Message-ID: <2000619B57A3492DBDFCA82B0843792D@gmail.com>
References: <4DC2DB6E.9010500@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40961 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1EERTH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2011 13:19:07 -0400
Received: by pzk9 with SMTP id 9so1056272pzk.19
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2011 10:19:06 -0700 (PDT)
In-Reply-To: <4DC2DB6E.9010500@ufm.su>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Nope, the MDS is only required for the POSIX-compliant Ceph layer.
-Greg
On Thursday, May 5, 2011 at 10:16 AM, Fyodor Ustinov wrote: 
> Hi!
> 
> If I only want to use rbd - requires metaserver?
> 
> WBR,
>  Fyodor.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 

