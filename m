From: Chmouel Boudjnah <chmouel@enovance.com>
Subject: RGW and Keystone
Date: Tue, 4 Jun 2013 11:44:43 +0200
Message-ID: <CAPeWyqwZO6E8qtc9teerxY9ZyYg+Qe_46kw6UHkwVD98Uk7ctA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:41327 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab3FDKGU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 06:06:20 -0400
Received: from zimbra.enovance.com (94-143-114-250.enovance.net [94.143.114.250])
	by mxi1.enovance.com (Postfix) with ESMTP id 6DBA01272A
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jun 2013 11:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.enovance.com (Postfix) with ESMTP id 6900946D2505
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jun 2013 11:45:06 +0200 (CEST)
Received: from zimbra.enovance.com ([127.0.0.1])
	by localhost (zimbra.enovance.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmakeDppyBxh for <ceph-devel@vger.kernel.org>;
	Tue,  4 Jun 2013 11:45:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.enovance.com (Postfix) with ESMTP id 0D55246D251F
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jun 2013 11:45:06 +0200 (CEST)
Received: from zimbra.enovance.com ([127.0.0.1])
	by localhost (zimbra.enovance.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zUPR5X68AM5v for <ceph-devel@vger.kernel.org>;
	Tue,  4 Jun 2013 11:45:05 +0200 (CEST)
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com [209.85.216.180])
	by zimbra.enovance.com (Postfix) with ESMTPSA id 4366646D2505
	for <ceph-devel@vger.kernel.org>; Tue,  4 Jun 2013 11:45:05 +0200 (CEST)
Received: by mail-qc0-f180.google.com with SMTP id a10so2789496qcx.11
        for <ceph-devel@vger.kernel.org>; Tue, 04 Jun 2013 02:45:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Florian,

I was wondering how the Keystone integration with ceph, I have been
reading the documentation of the way it shows how to configure the
keystone endpoints here :

http://ceph.com/docs/next/radosgw/config/

and I don't see how the part :

keystone endpoint-create --service-id <id> --publicurl
http://radosgw.example.com/swift/v1 \
        --internalurl http://radosgw.example.com/swift/v1 --adminurl
http://radosgw.example.com/swift/v1

would work with multiple tenancies since user a or user b putting an
object called bar in container foo would always end up with the same
URL like :

http://radosgw.example.com/swift/v1/foo/bar

The way we do that in Swift is to have in keystone this type of URL :

 --publicurl 'http://192.168.206.130:8888/v1/AUTH_%(tenant_id)s' \

and the keystoneauth make sure the token validated match the
%(tenant_id) in URL, i.e:

https://github.com/openstack/swift/blob/master/swift/common/middleware/keystoneauth.py#L204

am I totally off track or the keystone support support only a single tenant?

digging into the code I don't see any trickeries to make this works
properly it just check for the roles assigned to the user/tenant
matching the configuration (which is good) but don't do much more
after that :

https://github.com/ceph/ceph/blob/master/src/rgw/rgw_swift.cc#L500

Let me know what do you think.

Cheers,
Chmouel.
