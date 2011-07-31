From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Java-rados announcement (Version 2)
Date: Sat, 30 Jul 2011 20:58:15 -0700 (PDT)
Message-ID: <1372568026.24766.1312084695685.JavaMail.root@mail-01.cse.ucsc.edu>
References: <82250CCC-5986-4167-90D3-BBC0A2549872@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:60872 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1GaEIA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 31 Jul 2011 00:08:00 -0400
In-Reply-To: <82250CCC-5986-4167-90D3-BBC0A2549872@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org, Noah Watkins <jayhawk@cs.ucsc.edu>

Howdy,

Updated Java bindings (Version 2) for RADOS are
available in a standalone repository located at:

    git://github.com/noahdesu/java-rados.git

Java Docs for the API are available at:

    http://noahdesu.github.com/java-rados/

The bindings cover a large majority of the RADOS API,
and there are basic unit tests for the entire API.

----- Original Message -----
From: "Noah Watkins" <jayhawk@soe.ucsc.edu>
To: "Colin McCabe" <cmccabe@alumni.cmu.edu>

On Apr 26, 2011, at 4:22 PM, Colin McCabe wrote:

> PHPRados has its own wiki page and a separate repo. It's at:
> http://ceph.newdream.net/wiki/Phprados
>
> We should set up something similar for this, I think.

I'll add some info the Wiki.

> P.S. 
> functions. That's what ceph-pybind-test.py. Is it possible to make
> something like that for the Java and PHP bindings?

If you'd still like to integrate the bindings into any sort of automated
test harness, I'd be happy to work with you to get this going.

Thanks,
Noah Watkins
