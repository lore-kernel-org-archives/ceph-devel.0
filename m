From: Matt Benjamin <mbenjamin@redhat.com>
Subject: rgw: using aws4 auth with boto
Date: Thu, 2 Jun 2016 12:07:43 -0400 (EDT)
Message-ID: <1112504184.45552234.1464883663435.JavaMail.zimbra@redhat.com>
References: <1051461959.45549645.1464883404364.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:34883 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbcFBQHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Jun 2016 12:07:44 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u52G7huF022922
	for <ceph-devel@vger.kernel.org>; Thu, 2 Jun 2016 12:07:43 -0400
In-Reply-To: <1051461959.45549645.1464883404364.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Hi,

Some random notes on using aws4 signatures with boto S3 client.

.boto:


[Boto]
debug = 2

[s3]
use-sigv4 = True

With use-sigv4 enabled, I had issues with boto--what error you see may depend on the method used to create an S3Connection--use connect_s3 in my tests,
and found I was able to run if I added an initializer for the class member self.region_name to the S#HmacAuthV4Handler ctor:

class S3HmacAuthV4Handler(HmacAuthV4Handler, AuthHandler):
    """
    Implements a variant of Version 4 HMAC authorization specific to S3.
    """
    capability = ['hmac-v4-s3']

    def __init__(self, *args, **kwargs):
        super(S3HmacAuthV4Handler, self).__init__(*args, **kwargs)
        self.region_name = ""

This was against a pip-installed boto.

Matt

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
