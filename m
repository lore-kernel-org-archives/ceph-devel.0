From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/11] rbd: layered read functionality
Date: Thu, 11 Apr 2013 21:14:39 -0500
Message-ID: <51676E0F.2010504@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:65305 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3DLCOk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 22:14:40 -0400
Received: by mail-ie0-f176.google.com with SMTP id x12so2838958ief.35
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 19:14:39 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This series puts in place code that is able to handle
read requests on rbd clone images, forwarding them to
a parent snapshot image if necessary.  Missing from this
series is a temporary patch at the end which actually
activates this functionality.  That will not go in
until the rest of rbd layering functionality is in place.

I'm going to restate that.  This code implements reads
for layered rbd images, but the functionality will not
be usable quite yet.

Most of the series is adding flags to image and object
requests, and putting in place some accounting in (parent)
image requests so it can be used to record the completion
of an object request that initiated it.

					-Alex

[PATCH 01/11] rbd: record overall image request result
[PATCH 02/11] rbd: record aggregate image transfer count
[PATCH 03/11] rbd: record image-relative offset in object requests
[PATCH 04/11] rbd: define image request flags
[PATCH 05/11] rbd: define image request originator flag
[PATCH 06/11] rbd: define image request layered flag
[PATCH 07/11] rbd: encapsulate image object end request handling
[PATCH 08/11] rbd: define an rbd object request flags field
[PATCH 09/11] rbd: add an object request flag for image data objects
[PATCH 10/11] rbd: probe the parent of an image if present
[PATCH 11/11] rbd: implement layered reads
