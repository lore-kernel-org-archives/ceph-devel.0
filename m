From: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Subject: Client Incarnation & librados documentation
Date: Wed, 8 Jan 2014 11:13:21 +0000
Message-ID: <3472A07E6605974CBC9BC573F1BC02E4AE6AF398@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx11.cern.ch ([188.184.36.50]:4207 "EHLO CERNMX11.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbaAHLN1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jan 2014 06:13:27 -0500
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi, 
I have a question concerning the variable used by "objecter->set_client_incarnation().."

What I have seen is that currently it is always set to 0.

Would it be possible to add this as a variable to an IoCtx and do "objecter->set_client_incarnation()" according to the context before each objecter->XXX call. I have seen that every call to the objecter is already locked with the client mutex, so that should be safe ?!?!?

What was the original purpose of this variable?

I want to use it to identify more fine grained clients using a shared librados instance and use it to authorize on server side object operations using an OSD plugin ... 

Is there any better (larger than int32)  existing available 'blob' to move something with each message from librados to an OSD plugin?

One small point concerning the librados documention ... we noticed when one uses seteuid(uid) together with librados all OSD connections get recreated after each seteuid call and one accumulates TIME_WAIT sockets ... maybe you can document this 'feature' ...

Thanks, Andreas.




