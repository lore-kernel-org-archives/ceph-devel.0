From: Derek Yarnell <derek@umiacs.umd.edu>
Subject: RGW Multipart Uplaods
Date: Mon, 18 Feb 2013 11:28:26 -0500
Message-ID: <512256AA.6070408@umiacs.umd.edu>
Reply-To: derek@umiacs.umd.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from homsar.umiacs.umd.edu ([128.8.120.251]:50438 "EHLO
	homsar.umiacs.umd.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab3BRQ21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 11:28:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@ceph.com" <ceph-users@ceph.com>
Cc: derek@umiacs.umd.edu, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

I am trying to write some multipart parallel upload scripts.  I have run
into an issue with listing the current multipart uploads.  Is this
feature available in the current radosgw (0.56.3)?  I am able to upload
using multipart when initiatiating the upload and then itterating over
the chunks sequentially.  But when I try to iterate over a pool of
chunks in parallel I can't call the listing of multipart uploads on the
given bucket.

The response I get back from the 'GET /?uploads HTTP/1.1' (the server is
setup to handle bucket DNS names) is a 200 OK, with a XML
<ListBucketResult> with the contents of the bucket.

Thanks,
derek

-- 
---
Derek T. Yarnell
University of Maryland
Institute for Advanced Computer Studies
