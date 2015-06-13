From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: Rados multi-object transaction use cases
Date: Sat, 13 Jun 2015 10:42:25 +0800
Message-ID: <557B9891.7040706@ubuntukylin.com>
References: <1235935092.20915764.1434147302334.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:33224 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbbFMCmd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 22:42:33 -0400
In-Reply-To: <1235935092.20915764.1434147302334.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Samuel,
   We have made significant progress towards this implementation,
we submitted a BP at 
http://tracker.ceph.com/projects/ceph/wiki/Rados_-_multi-object_transaction_support 
several days ago, so far it is just a
place holder, I will post our detailed progress soon, and great to hear 
your comments.

Cheers,
Li Wang

On 2015/6/13 10:06, Samuel Just wrote:
> In the Infernalis CDS, we had a session on RADOS multi-object transactions.  I'd like to continue the discussion at the upcoming Jewel CDS.  I thought I'd prime the discussion by asking: if librados supported multi-object read and write transactions, what would you use them for?  Some idea of use cases would be valuable when considering things like deadlock coping strategies.
> -Sam
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
