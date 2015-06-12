From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Rados multi-object transaction use cases
Date: Fri, 12 Jun 2015 18:21:07 -0400 (EDT)
Message-ID: <1019086990.13871273.1434147667441.JavaMail.zimbra@redhat.com>
References: <1235935092.20915764.1434147302334.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:48641 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbFLWVI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 18:21:08 -0400
In-Reply-To: <1235935092.20915764.1434147302334.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Samuel Just" <sjust@redhat.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Friday, June 12, 2015 3:15:02 PM
> Subject: Rados multi-object transaction use cases
> 
> In the Infernalis CDS, we had a session on RADOS multi-object transactions.
> I'd like to continue the discussion at the upcoming Jewel CDS.  I thought
> I'd prime the discussion by asking: if librados supported multi-object read
> and write transactions, what would you use them for?  Some idea of use cases
> would be valuable when considering things like deadlock coping strategies.

Here are a few for rgw:
 - update bucket index when creating / modifying / deleting an object
 - store multiple metadata objects atomically: e.g., user info + user access keys + user email (currently not atomic)
 - store bucket entry point + bucket instance info atomically
 - creating a bucket and adding it to the user's list of buckets

Yehuda
