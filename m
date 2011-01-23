From: John Leach <john@brightbox.co.uk>
Subject: desperados: a Ruby library for RADOS
Date: Sun, 23 Jan 2011 18:41:53 +0000
Message-ID: <1295808113.24826.17.camel@dogen>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp201.iad.emailsrvr.com ([207.97.245.201]:33606 "EHLO
	smtp201.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab1AWSml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Jan 2011 13:42:41 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp40.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 8800E350270
	for <ceph-devel@vger.kernel.org>; Sun, 23 Jan 2011 13:41:55 -0500 (EST)
Received: by smtp40.relay.iad1a.emailsrvr.com (Authenticated sender: john-AT-brightbox.co.uk) with ESMTPSA id 28CC43501DE
	for <ceph-devel@vger.kernel.org>; Sun, 23 Jan 2011 13:41:55 -0500 (EST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I've just made the first release of my RADOS Ruby library, desperados.

It's dead easy to use:

  pool = Rados::Pool.create("mypool")
  o = pool.objects.new("mykey")
  o.write("Once upon")
  o.write(" a time")
  o.seek(0)
  o.read == "Once upon a time"
  o = pool.objects.find("mykey")
  o.seek(5)
  o.read == "upon a time"

I've been using it to read and write thousands of pool and millions of
objects whilst load testing ceph and it's behaved well.

Behind the scenes it just uses librados (via the Ruby FFI).

The code is on github: https://github.com/johnl/desperados

Documentation here: http://rdoc.info/gems/desperados/0.1/frames

And there is a gem available: https://rubygems.org/gems/desperados

You can file bugs or feature requests on github too:
https://github.com/johnl/desperados/issues

Bug reports and contributions are welcomed!

Thanks,

John.
--
http://beta.brightbox.com/

