From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: Re: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 14:05:25 -0500
Message-ID: <56730775.3070906@umiacs.umd.edu>
References: <5672EB1F.9070209@umiacs.umd.edu>
 <CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from homsar.umiacs.umd.edu ([128.8.120.251]:53985 "EHLO
	homsar.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbbLQTF1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 14:05:27 -0500
In-Reply-To: <CADRKj5Ru=HhbhYGXq829oKPiB6Wr+9b8qgxjtmCn207xfCdc0Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: derek@umiacs.umd.edu, Ceph Development <ceph-devel@vger.kernel.org>

On 12/17/15 1:09 PM, Yehuda Sadeh-Weinraub wrote:
>> Bug? Design?
> 
> Somewhat a bug. The whole subusers that use s3 was unintentional, so
> when creating the subuser api, we didn't think of needing the access
> key. For some reason we do get the key type. Can you open a ceph
> tracker issue for that?
> 
> You can try using the metadata api to modify the user once it has been
> created (need to get the user info, add the s3 key to the structure,
> put the user info).
> 

This will actually create a subuser and the S3 keys correctly (but not
let you specify the access_key and secret_key).

DEBUG:requests.packages.urllib3.connectionpool:"PUT
/admin/user?subuser&format=json&uid=-staff&subuser=test3&key-type=s3&access=read&generate-secret=True
HTTP/1.1" 200 87

I know about a 'GET /admin/metadata/user?format=json' to get the list of
users from the adminops.  I see I can do things like 'radosgw-admin
metadata get user:cephtest' but I can't seem to get something like this
to work.

DEBUG:requests.packages.urllib3.connectionpool:"GET
/admin/metadata/get?format=json&key=user%3Acephtest HTTP/1.1" 404 20
ERROR:rgwadmin.rgw:{u'Code': u'NoSuchKey'}


-- 
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
