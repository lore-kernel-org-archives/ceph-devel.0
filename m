From: Constantinos Venetsanopoulos <cven@grnet.gr>
Subject: Re: Distributed Deduplication in a Cloud-based Object Storage System
Date: Tue, 23 Apr 2013 13:06:59 +0300
Message-ID: <51765D43.5040207@grnet.gr>
References: <51763308.6010704@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:17975 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753845Ab3DWKW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 23 Apr 2013 06:22:29 -0400
In-Reply-To: <51763308.6010704@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hello Loic,

On 04/23/2013 10:06 AM, Loic Dachary wrote:
> Hi,
>
> For later reference. Who knows ... ;)
>
> http://paulormg.files.wordpress.com/2012/08/thesis-paulo.pdf
>

that is very interesting! That was exactly what we were talking
about during the Ceph meeting @ FOSDEM'13.

We have been running a similar design in production for over
1.5 year now, with Synnefo [1], first over NFS and now over
RADOS. Specifically, the Storage Service of Synnefo, called
Pithos, stores content-addressable objects on the underlying
storage, allowing us to do file syncing with native clients, not
only for files but for VM Images, too.

We even have an extension for the OpenStack Object Storage
API (which is what we expose to the users), to allow us for
these advanced operations, the same way Paulo proposes.

If anyone is interested towards that direction, which we believe
allows for very interesting things to be done, please take a
look at the Pithos design and the corresponding OpenStack
API:

http://www.synnefo.org/docs/synnefo/latest/pithos.html#pithos-design
http://www.synnefo.org/docs/synnefo/latest/pithos-api-guide.html#the-pithos-api

The first document is somewhat outdated (sorry for that :)), but
the concepts are there and have been tested in production.

Again, we are very happy to see other people exploring those
paths in the cloud context too.

Kind Regards,
Constantinos


[1] http://www.synnefo.org
