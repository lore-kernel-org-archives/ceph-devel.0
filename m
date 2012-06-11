From: Florian Haas <florian@hastexo.com>
Subject: radosgw-admin: mildly confusing man page and usage message
Date: Mon, 11 Jun 2012 23:35:54 +0200
Message-ID: <4FD664BA.6040801@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:41732 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab2FKVf6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Jun 2012 17:35:58 -0400
Received: by wibhm6 with SMTP id hm6so3785608wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 11 Jun 2012 14:35:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

just noticed that radosgw-admin comes with a bit of confusing content in
its man page and usage message:

EXAMPLES
       Generate a new user:

       $ radosgw-admin user gen --display-name="johnny rotten"
--email=johnny@rotten.com

As far as I remember "user gen" is gone, and it's now "user create".
However:

radosgw-admin user create --display-name="test" --email=test@demo
user_id was not specified, aborting

... is followed by a usage message that doesn't mention user_id anywhere
(the option string is --uid). So conceivably the example could also use
a mention of --uid.

Also, is there a way to retrieve the "next available" user_id or just
tell radosgw-admin to use max(user_id)+1?

If one of the Ceph guys could provide a quick comment on this, I can
send a patch to the man page RST. Thanks.

Cheers,
Florian
