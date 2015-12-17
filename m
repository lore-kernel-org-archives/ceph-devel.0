From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: rgw subuser create and admin api
Date: Thu, 17 Dec 2015 12:04:31 -0500
Message-ID: <5672EB1F.9070209@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pompom.umiacs.umd.edu ([128.8.120.254]:41435 "EHLO
	pompom.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbLQRTU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 12:19:20 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: derek@umiacs.umd.edu

I am having an issue with the 'radosgw-admin subuser create' command
doing something different than the '/{admin}/user?subuser&format=json'
admin API.  I want to leverage subusers in S3 which looks to be possible
in my testing for bit more control without resorting to ACLs.

radosgw-admin subuser create --uid=-staff --subuser=test1
--access-key=aaaaaaaaa --secret=zzzzzzzzz --access=read

This command will work and create a both a subuser -staff:test1 with
permission read and a s3 key with the the correct access and secret key set.

The Admin API will not allow me to do this it would seem as the
following is accepted and a subuser is created however a swift_key is
created instead.

DEBUG:requests.packages.urllib3.connectionpool:"PUT
/admin/user?subuser&format=json&uid=-staff&subuser=test2&access-key=bbbbbbbbb&secret-key=cccccccccc&access=read
HTTP/1.1" 200 130

The documentation for the admin API[0] does not seem to indicate that
access-key is accepted at all.  Also if you pass key-type=s3 it will
return a 400 with InvalidArgument although the documentation says it
should accept the key type s3.

Bug? Design?

One other issue is that a command that uses the --purge-keys from
radosgw-admin seems to have no effect.  The following command removes
the subuser and leaves the swift keys it has (but also any s3 keys too).

radosgw-admin subuser rm --uid=-staff --subuser=test2 --purge-keys


[0] - http://docs.ceph.com/docs/master/radosgw/adminops/#create-subuser


-- 
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
