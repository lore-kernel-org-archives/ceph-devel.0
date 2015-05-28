From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: preparing v0.80.11
Date: Thu, 28 May 2015 12:10:42 +0200
Message-ID: <5566E9A2.9020401@suse.cz>
References: <5562DEEC.5060602@dachary.org> <5564D772.9080909@suse.cz> <55669F5B.8050309@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34647 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752769AbbE1KKr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 06:10:47 -0400
In-Reply-To: <55669F5B.8050309@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

> Would it be possible to backport this as well to 0.80.11:
>
> http://tracker.ceph.com/issues/9792#change-46498
>
> And I think this commit would be the easiest to backport:
> https://github.com/ceph/ceph/commit/6b982e4cc00f9f201d7fbffa0282f8f3295f2309
>
> This way we add a simple safeguard against pool removal into Firefly as
> well.

Hi Wido:

Thanks for this suggestion. I have cherry-picked the commit you quoted 
and it will soon be in firefly-backports. The backport tracker issue is:

http://tracker.ceph.com/issues/11801

Regards,
Nathan



