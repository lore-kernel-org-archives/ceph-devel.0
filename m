From: Joaquim Rocha <joaquim.rocha@cern.ch>
Subject: Problem in src_cmpxattr?
Date: Thu, 13 Nov 2014 15:03:35 +0100
Message-ID: <5464BA37.1080801@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:57334 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932756AbaKMODj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 13 Nov 2014 09:03:39 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi there,

I need to create an object O (if it doesn't exist) and set an xattr on 
it based on a condition that another xattr in a different object (X) 
should obey. For this, on the same write operation (called on O) I call 
create (not exclusively), setxattr and src_cmpxattr (with X as the 
src_oid), respectively.

What I noticed is that if object O does not exist, the src_cmpxattr 
returns -ENOENT (even if object X does exist). IMO, this error should 
only be returned if X didn't exist and not O.

Is this the correct expectation for what src_cmpxattr should do (compare 
an xattr on the given source object to the parameters given)?
Is this somehow expected? If so, is there any other way that I can 
accomplish what I need as mentioned above?


Thank you in advance,

--
Joaquim Rocha
