From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Possible bug in src/Makefile.am
Date: Mon, 08 Jul 2013 18:51:16 +1200
Message-ID: <51DA6164.6090304@catalyst.net.nz>
References: <51D8F96B.5040902@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:50329 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab3GHGvV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jul 2013 02:51:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id D50C433074
	for <ceph-devel@vger.kernel.org>; Mon,  8 Jul 2013 18:51:17 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5g+NYiFzVLqO for <ceph-devel@vger.kernel.org>;
	Mon,  8 Jul 2013 18:51:16 +1200 (NZST)
Received: from [192.168.1.64] (122-60-64-230.jetstream.xtra.co.nz [122.60.64.230])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id D765633073
	for <ceph-devel@vger.kernel.org>; Mon,  8 Jul 2013 18:51:16 +1200 (NZST)
In-Reply-To: <51D8F96B.5040902@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

It seems this has been noted previously (just...):

http://tracker.ceph.com/issues/5492

Blast, I was just a bit slow :-) , should have posted when I first 
noticed this a week or so ago!

Regards

Mark

On 07/07/13 17:15, Mark Kirkwood wrote:
> I noticed when building with prefix=/usr/local that the install step
> produced an usr/local/sbin hierarchy *under* /usr/local (i.e
> /usr/local/usr/local/sbin) with ceph_disk and friends (i.e
> ceph_sbin_SCRIPTS) therein. I am guessing that these should actually be
> installed in /usr/local/sbin (i.e prefix/sbin).
>
> The attached patch does this.
>
> Regards
>
> Mark

