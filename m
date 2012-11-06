From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Cleaning up CephFS pool
Date: Tue, 06 Nov 2012 20:29:42 +0100
Message-ID: <50996526.2010100@ledeuns.net>
References: <5099631F.6090802@ledeuns.net> <CAPYLRziv=4a-oETkSLnAkXV=oUjZ5vEZFmSr626Km-NbNBLdLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:21602 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2KFT3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 14:29:44 -0500
In-Reply-To: <CAPYLRziv=4a-oETkSLnAkXV=oUjZ5vEZFmSr626Km-NbNBLdLw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Le 06/11/2012 20:24, Gregory Farnum a =E9crit :
> Deleting files on CephFS doesn't instantaneously remove the underlyin=
g
> objects because they could still be in use by other clients, and
> removal takes time proportional to the size of the file. Instead the
> MDS queues it up to be removed asynchronously. You should see the
> number of objects counter going down over time.
> -Greg
>

Thank you for that fast answer Greg.
If I'm the only user,  is there a way to speedup this process ?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
