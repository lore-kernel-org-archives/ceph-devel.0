From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Queries on RGW Multitenancy
Date: Wed, 20 Apr 2016 18:14:36 +0200
Message-ID: <87shyggsur.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60409 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbcDTQOk (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 20 Apr 2016 12:14:40 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

A few questions on URLs behaviour after enabling multitenancy.

Are there any changes in the way bucket and object urls are used by
clients after creating a user with a tenant? My understanding so far ha=
s
been that the urls look the same for clients, and based on the
credentials passed in, we determine the tenant for requests. Is this
correct?

Also on making a bucket/object public the urls follow a format like:
`<host>/<tenant>:<bucket>`

Is there an equivalent s3 vhost style url for the above? Trying any of
tenant.bucket.host combos mostly gave  404s

And similarly for swift making a bucket public, the only url that seeme=
d
accessible was the above mentioned `<host>/<tenant>:<bucket>` format an=
d
there is no swift url of the format
`<host>/swift/v1/<tenant>/<container>` etc? Is this also the expected
behaviour?

Thanks
Abhishek
--
Abhishek Lekshmanan
SUSE Linux GmbH,
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, HRB 21284 (AG=
 N=C3=BCrnberg)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
